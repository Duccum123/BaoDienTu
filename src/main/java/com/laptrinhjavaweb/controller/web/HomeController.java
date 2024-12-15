package com.laptrinhjavaweb.controller.web;

import com.laptrinhjavaweb.model.CategoryModel;
import com.laptrinhjavaweb.model.NewModel;
import com.laptrinhjavaweb.model.UserModel;
import com.laptrinhjavaweb.paging.PageRequest;
import com.laptrinhjavaweb.paging.Pageble;
import com.laptrinhjavaweb.service.ICategoryService;
import com.laptrinhjavaweb.service.INewService;
import com.laptrinhjavaweb.service.IUserService;
import com.laptrinhjavaweb.utils.FormUtil;
import com.laptrinhjavaweb.utils.SessionUtil;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

@WebServlet(urlPatterns = {"/trang-chu","/dang-nhap","/thoat","/news"})
public class HomeController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Inject
	private INewService newService;

	@Inject
	private ICategoryService categoryService;

	@Inject
	private IUserService userService;

	ResourceBundle resourceBundle = ResourceBundle.getBundle("message");

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		if (action != null && action.equals("login")) {
			handleLoginGet(req, resp);
		} else if (action != null && action.equals("logout")) {
			handleLogout(req, resp);
		} else if("sport".equals(action)){
			handleHomePageByCategory(req, resp, 6);
		} else if("economy".equals(action)){
			handleHomePageByCategory(req, resp, 7);
		} else if("entertainment".equals(action)){
			handleHomePageByCategory(req, resp, 8);
		}
		else {
			handleHomePage(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		if (action != null && action.equals("login")) {
			handleLoginPost(req, resp);
		} else if(action.equals("read")){
			NewModel news = newService.findOne(Integer.parseInt(req.getParameter("idNews")));
			req.setAttribute("news", news);
			RequestDispatcher rd = req.getRequestDispatcher("/views/web/news.jsp");
			rd.forward(req, resp);
		}
	}
	private void handleLoginGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String alert = req.getParameter("alert");
		String message = req.getParameter("message");
		if (alert != null && message != null) {
			req.setAttribute("message", resourceBundle.getString(message));
			req.setAttribute("alert", alert);
		}
		RequestDispatcher dispatcher = req.getRequestDispatcher("/views/login.jsp");
		dispatcher.forward(req, resp);
	}

	private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		SessionUtil.getInstance().removeValue(req, "USERMODEL");
		resp.sendRedirect(req.getContextPath() + "/trang-chu");
	}

	private void handleHomePage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pageStr = req.getParameter("page");
		String limitStr = req.getParameter("limit");

		int page = pageStr != null ? Integer.parseInt(pageStr) : 1;
		int limit = limitStr != null ? Integer.parseInt(limitStr) : 10;

		Pageble pageble = new PageRequest(page, limit, null);


		List<NewModel> newsList = newService.findAll(pageble);
		List<CategoryModel> CategoryList = categoryService.findAll();

		int totalItems = newService.getTotalItem();
		int totalPages = (int) Math.ceil((double) totalItems / limit);

		req.setAttribute("newsList", newsList);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("currentPage", page);
		req.setAttribute("categories", categoryService.findAll());
		req.setAttribute("categoryList", CategoryList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/views/web/home.jsp");
		dispatcher.forward(req, resp);
	}
	private void handleLoginPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserModel userModel = FormUtil.toModel(UserModel.class, req);
		userModel = userService.findByUserNameAndPasswordAndStatus(
				userModel.getUserName(),
				userModel.getPassword(),
				1
		);

		if (userModel != null) {
			SessionUtil.getInstance().putValue(req, "USERMODEL", userModel);
			if (userModel.getRole().getCode().equals("USER")) {
				resp.sendRedirect(req.getContextPath() + "/trang-chu");
			} else if (userModel.getRole().getCode().equals("ADMIN")) {
				resp.sendRedirect(req.getContextPath() + "/admin-home");
			}
		} else {
			resp.sendRedirect(req.getContextPath() + "/login?action=login&message=username_password_invalid&alert=danger");
		}
	}
	public void handleHomePageByCategory(HttpServletRequest req, HttpServletResponse resp, int id) throws ServletException, IOException {
		String pageStr = req.getParameter("page");
		String limitStr = req.getParameter("limit");

		int page = pageStr != null ? Integer.parseInt(pageStr) : 1;
		int limit = limitStr != null ? Integer.parseInt(limitStr) : 10;

		Pageble pageble = new PageRequest(page, limit, null);


		List<NewModel> newsList = newService.findAll(pageble);
		List<NewModel> newsListByCategory = new ArrayList<NewModel>();
		for (NewModel newModel : newsList) {
			if (newModel.getCategoryId() == id) {
				newsListByCategory.add(newModel);
			}
		}

		List<CategoryModel> CategoryList = categoryService.findAll();

		int totalItems = newService.getTotalItem();
		int totalPages = (int) Math.ceil((double) totalItems / limit);

		req.setAttribute("newsList", newsListByCategory);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("currentPage", page);
		req.setAttribute("categoryList", CategoryList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/views/web/home.jsp");
		dispatcher.forward(req, resp);
	}
}