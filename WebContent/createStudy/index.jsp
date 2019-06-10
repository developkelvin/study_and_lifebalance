<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<% if (session.getAttribute("user_id") == null) { 
	
%>
	<script>
   alert("로그인이 필요합니다.");
   location.href="/projectslb/auth/login.jsp?referer=/projectslb/createStudy/index.jsp"
  </script>
<%
} %>
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>스터디 만들기</title>

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
            <h1>스터디 만들기</h1>
            <span class="subheading">스터디를 만들어 사람들과 함께 공부해 보세요!</span>
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
        <p>어떤 스터디를 만드실 건가요?</p>
        <!-- Contact Form - Enter your email address on line 19 of the mail/contact_me.php file to make this form work. -->
        <!-- WARNING: Some web hosts do not allow emails to be sent through forms to common mail hosts like Gmail or Yahoo. It's recommended that you use a private domain email address! -->
        <!-- To use the contact form, your site must be on a live web host with PHP! The form will not work locally! -->
        <form name="createStudy" id="createStudyForm" action="/projectslb/createStudy/createStudyProcess.jsp" method="post" novalidate>
          <div class="control-group">
            <div class="form-group floating-label-form-group controls">
              <label>스터디 이름</label>
              <input type="text" class="form-control" placeholder="스터디 이름" name="studyName" required data-validation-required-message="스터디 이름을 작성하세요.">
              <p class="help-block text-danger"></p>
            </div>
          </div>
          <div class="control-group">
            <div class="form-group floating-label-form-group controls">
              <label>스터디 설명</label>
              <textarea rows="5" class="form-control" placeholder="스터디 설명" name="studyDesc" required data-validation-required-message="Please enter a message."></textarea>
              <p class="help-block text-danger"></p>
            </div>
          </div>
          <br>
          <div id="success"></div>
          <div class="form-group">
            <button type="submit" class="btn btn-primary" id="sendStudyInfo">만들기</button>
          </div>
        </form>
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
