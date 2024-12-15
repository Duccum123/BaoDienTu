<%@ page import="com.laptrinhjavaweb.model.NewModel" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Trang chủ báo điện tử</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #e0f7fa;
    }
    header {
      background-color: #0288d1;
    }
    .navbar {
      background-color: #03a9f4;
    }
    .navbar .nav-link {
      color: white;
    }
    .navbar .nav-link.active {
      font-weight: bold;
    }
    .card {
      border: 1px solid #0288d1;
    }
    footer {
      background-color: #01579b;
    }
  </style>
</head>
<body>


<!-- Main Content -->
<div class="container my-4">
  <div class="row">
    <!-- Featured Article -->
    <div class="col-md-12">
      <%
        List<NewModel> newsList = (List<NewModel>) request.getAttribute("newsList");

        for(int i = 0; i <newsList.size(); i++){

          %>

      <div class="card mb-4">
        <img src="<%=newsList.get(i).getThumbnail()%>" class="card-img-top" alt="Tin nổi bật">
        <form class="card-body" method="POST" action="/new-jdbc-12-month-2018/news?action=read">
          <h5 class="card-title"><%=newsList.get(i).getTitle()%></h5>
          <p class="card-text"><%=newsList.get(i).getShortDescription()%></p>
          <input type="hidden" value="<%=newsList.get(i).getId()%>" name="idNews"/>
          <button class="btn btn-primary" type="submit">Đọc thêm</button>
        </form>
      </div>

          <%


        }
      %>


    </div>

    <!-- Sidebar -->

  </div>
</div>

<!-- Footer -->
<footer class="text-white text-center py-3">
  <p>&copy; 2024 Báo Điện Tử. Mọi quyền được bảo lưu.</p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
