<%@ page import="com.laptrinhjavaweb.model.CategoryModel" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
  <div class="container">
    <a class="navbar-brand" href="#">Báo Điện Tử</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/new-jdbc-12-month-2018/">Trang chủ</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/new-jdbc-12-month-2018/">Tin Nóng</a>
        </li>

        <%
          List<CategoryModel> categories = (List<CategoryModel>) request.getAttribute("categoryList");

          for(int i =0; i < categories.size(); i++){
            %>
        <li class="nav-item">
          <a class="nav-link" href="/new-jdbc-12-month-2018/trang-chu?action=category&id=<%=categories.get(i).getId()%>"><%=categories.get(i).getName()%></a>
        </li>
            <%
          }
        %>


      </ul>
      <form class="d-flex" role="search" method="POST" action="<c:url value="/trang-chu?action=search"/>">
        <input class="form-control me-2" style="margin-right: 20px; margin-left: 30px" name="search" type="search" placeholder="Tìm kiếm..." aria-label="Search">
        <button class="btn btn-light" type="submit">Tìm</button>
      </form>
      <ul class="navbar-nav ms-3">
        <c:if test="${not empty USERMODEL}">
          <li class="nav-item">
            <a class="nav-link" href="#">Chào, ${USERMODEL.fullName}</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href='<c:url value="/thoat?action=logout"/>'>Thoát</a>
          </li>
        </c:if>
        <c:if test="${empty USERMODEL}">
          <li class="nav-item">
            <a class="nav-link" href='<c:url value="/dang-nhap?action=login"/>'>Đăng nhập</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href='<c:url value="/dang-nhap?action=register"/>'>Đăng ký</a>
          </li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>
