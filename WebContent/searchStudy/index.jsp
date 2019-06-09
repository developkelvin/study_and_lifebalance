<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="searchDB" class="db.SearchProcess"></jsp:useBean>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>스터디 찾기</title>

  <!-- Bootstrap core CSS -->
  <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

  <!-- Custom styles for this template -->
  <link href="../css/clean-blog.css" rel="stylesheet">

</head>

<body>

  <jsp:include page="/header.jsp"></jsp:include>
  

  <!-- Page Header -->
  <header class="masthead" style="background-image: url('img/home-bg.jpg')">
    <div class="overlay"></div>
    <div class="container">
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
          <div class="site-heading">
            <h1>스라밸</h1>
            <span class="subheading">원하는 IT 스터디를 찾아보세요.</span>
          </div>
        </div>
      </div>
    </div>
  </header>

  <!-- Main Content -->
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
      <% 
      ResultSet rs = searchDB.getStudyList(10);
    //for문 사용해서 스터디 출력하기
    while(rs.next()){
    	%>
    	<div class="post-preview">
          <a href="studyDetail.jsp?studyIdx=<%= rs.getString("study_idx")%>">
            <h2 class="post-title">
              	<%= rs.getString("study_name") %>
            </h2>
            <h3 class="post-subtitle">
              <%= rs.getString("study_desc") %>
            </h3>
          </a>
          <p class="post-meta">생성자
            <a href="#"><%= rs.getString("user_name") %></a>
            <!-- on March 24, 2019 --></p>
        </div>
        <hr>
    	<%
    }
      %>
        <!-- Pager -->
        <div class="clearfix">
          <a class="btn btn-primary float-right" href="#">Older Posts &rarr;</a>
        </div>
      </div>
    </div>
  </div>

  <hr>

  <jsp:include page="/footer.jsp"></jsp:include>

  <!-- Bootstrap core JavaScript -->
  <script src="../vendor/jquery/jquery.min.js"></script>
  <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Custom scripts for this template -->
  <script src="../js/clean-blog.min.js"></script>

</body>

</html>
