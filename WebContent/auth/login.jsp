<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>로그인</title>

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
  <header class="masthead">
    <div class="overlay"></div>
    <div class="container">
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
          <div class="page-heading">
            <h1>로그인</h1>
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
        <p>로그인 하세요</p>
        <form name="createStudy" id="createStudyForm" action="/projectslb/auth/validateLogin.jsp" method="post">
          <input type="hidden" name="referer" value="<%= request.getParameter("referer")%>">
          <div class="control-group">
            <div class="form-group floating-label-form-group controls">
              <label>아이디</label>
              <input type="text" class="form-control" placeholder="아이디" name="user_id" required data-validation-required-message="아이디를 입력하세요">
              <p class="help-block text-danger"></p>
            </div>
          </div>
          <div class="control-group">
            <div class="form-group floating-label-form-group controls">
              <label>비밀번호</label>
              <input type="password" class="form-control" placeholder="비밀번호" name="user_pwd" required data-validation-required-message="비밀번호를 입력하세요"></textarea>
              <p class="help-block text-danger"></p>
            </div>
          </div>
          <br>
          <div id="success"></div>
          <div class="form-group">
            <button type="submit" class="btn btn-primary" id="sendLoginInfo">로그인</button>
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
