<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>News Home</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
  <div class="row">
    <div class="col-lg-3">
      <h1 class="my-4">News Portal</h1>
      <div class="list-group">
        <c:forEach var="category" items="${categoryList}">
          <a href="#" class="list-group-item">${category.name}</a>
        </c:forEach>
      </div>
    </div>
    <!-- /.col-lg-3 -->

    <div class="col-lg-9">
      <div class="row">
        <!-- Loop through the newsList -->
        <c:forEach var="news" items="${newsList}">
          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="#"><img class="card-img-top" src="${news.thumbnail}" alt="News Thumbnail"></a>
              <div class="card-body">
                <h4 class="card-title">
                  <a href="#">${news.title}</a>
                </h4>
                <p class="card-text">${news.shortDescription}</p>
              </div>
              <div class="card-footer">
                <small class="text-muted">Category: ${news.categoryCode}</small>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
      <!-- /.row -->
    </div>
    <!-- /.col-lg-9 -->
  </div>
  <!-- /.row -->
</div>
<!-- /.container -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
