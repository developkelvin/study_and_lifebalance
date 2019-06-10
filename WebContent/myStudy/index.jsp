<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="myStudyDAO" class="db.MyStudyDAO"></jsp:useBean>
<!DOCTYPE html>
<html lang="en">
<% if (session.getAttribute("user_id") == null) { 
	
%>
	<script>
   alert("로그인이 필요합니다.");
  </script>
<%
request.setAttribute("referer", "/projectslb/myStudy/index.jsp");
pageContext.forward("/auth/login.jsp");
} %>
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>내 스터디</title>

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
  <header class="masthead" style="">
    <div class="overlay"></div>
    <div class="container">
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
          <div class="page-heading">
            <h1>내 스터디</h1>
            <span class="subheading">참여 중인 스터디를 확인해 보세요</span>
          </div>
        </div>
      </div>
    </div>
  </header>

  <!-- Main Content -->
  <!-- Main Content -->
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
        <p>가입한 스터디 목록</p>
        <hr/>
        <hr/>
        <% 
        String userId = (String) session.getAttribute("user_id");
      ResultSet rs = myStudyDAO.getJoinedStudy(userId);
    //for문 사용해서 스터디 출력하기
    while(rs.next()){
    	%>
    	<div class="post-preview">
          <a href="/projectslb/searchStudy/studyDetail.jsp?studyIdx=<%= rs.getString("study_idx")%>">
            <h2 class="post-title">
              	<%= rs.getString("study_name") %>
            </h2>
          </a>
          <p class="post-meta">
            스터디 <%out.print(rs.getInt("is_master")==1?"개설자":"회원"); %>
            <!-- on March 24, 2019 --></p>
        </div>
        <hr>
    	<%
    }
      %>
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
