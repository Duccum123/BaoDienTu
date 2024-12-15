<%@ page import="com.laptrinhjavaweb.model.NewModel" %><%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 12/14/2024
  Time: 1:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đọc Bài Báo</title>
  <!-- Thêm link đến Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
  NewModel news = (NewModel) request.getAttribute("news");
  String date = news.getCreatedDate().toString().substring(0,10);

  %>

<div class="container mt-5">
  <!-- Header -->
  <header class="text-center mb-4">
    <h1><%=news.getTitle()%></h1>
    <p class="text-muted">Ngày: <%=date%></p>
  </header>

  <!-- Article -->
  <article>
    <h3 class="mb-3"><%=news.getShortDescription()%></h3>
    <%=news.getContent()%>
  </article>

  <!-- Footer -->
  <footer class="text-center mt-5">
    <p>&copy; 2024 Tất cả quyền được bảo vệ.</p>
  </footer>
</div>

<!-- Thêm link đến Bootstrap JS và Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>

