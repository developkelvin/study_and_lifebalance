<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="searchDAO" class="db.SearchDAO"></jsp:useBean>
<% 
	String userId = (String) session.getAttribute("user_id");
	int studyIdx = Integer.valueOf(request.getParameter("studyIdx")); 
	ResultSet detail = searchDAO.getStudyDetail(studyIdx);
	ResultSet members = searchDAO.getStudyMemberList(studyIdx);
	detail.next();
	
%>
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
            <h1><%=detail.getString("study_name") %></h1>
            <span class="subheading"><%= detail.getString("study_desc") %></span>
          </div>
        </div>
      </div>
    </div>
  </header>

  <!-- Main Content -->
  <div class="container">
    <div class="row">
      
      	<% if(userId == null){//로그인이 되지 않은 경우
      		%>
      		<div class="col-lg col-md mx-auto text-center" >
      		<p>로그인 하셔야 확인할 수 있습니다.</p>
      		<button type="button" id="login-required" class="btn btn-outline-warning">로그인</button>
      		</div>
      		
      		<%
      	}else if(!searchDAO.checkJoinStudy(userId, studyIdx)){ // 스터디가 가입되지 않은 경우
      		%>
      		<div class="col-lg col-md mx-auto text-center" >
      		<p>스터디에 가입 하셔야 확인할 수 있습니다.</p>
      		<button type="button" id="join-study" class="btn btn-outline-warning">가입하기</button>
      		</div>
      		<% 
      	}else{// 스터디에 가입한 경우 스터디 일지 보여주기
      		
      		%>
      		<div class="col-lg-8 col-md-10 mx-auto" >
      		<p>스터디 일지</p>
		        <form name="createStudy" id="createStudyForm" action="/projectslb/searchStudy/writeStudyDiary.jsp" method="post" novalidate>
		          <input type="hidden" name="studyIdx" value="<%=studyIdx%>">
		          <div class="control-group">
		            <div class="form-group floating-label-form-group controls">
		              <label>제목</label>
		              <input type="text" class="form-control" placeholder="제목" name="title" required data-validation-required-message="일지의 제목을 작성하세요.">
		              <p class="help-block text-danger"></p>
		            </div>
		          </div>
		          <div class="control-group">
		            <div class="form-group floating-label-form-group controls">
		              <label>스터디 내용</label>
		              <textarea rows="3" class="form-control" placeholder="스터디 내용" name="content" required data-validation-required-message="스터디 내용을 작성하세요"></textarea>
		              <p class="help-block text-danger"></p>
		            </div>
		          </div>
		          <br>
		          <div id="success"></div>
		          <div class="form-group text-right">
		            <button type="submit" class="btn btn-primary" id="sendStudyInfo">일지 작성</button>
		          </div>
		        </form>
		        
		        <hr/>
		         <% 
      ResultSet rs = searchDAO.getDiaryList(studyIdx);
    //for문 사용해서 스터디 출력하기
    while(rs.next()){
    	%>
    	<div class="post-preview">
          
            <h2 class="post-title">
              	<%= rs.getString("diary_title") %>
            </h2>
            <h3 class="post-subtitle">
              <%= rs.getString("diary_content") %>
            </h3>
   
          <p class="post-meta">작성자
            <%= rs.getString("user_name") %> 
            <%= rs.getDate("diary_datetime") %>
            <!-- on March 24, 2019 --></p>
        </div>
        <hr>
    	<%
    }
      %>
      		</div>
      		<%
      	}
      		%>
    </div>
  </div>

  <hr>

  <jsp:include page="/footer.jsp"></jsp:include>

  <!-- Bootstrap core JavaScript -->
  <script src="../vendor/jquery/jquery.min.js"></script>
  <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Custom scripts for this template -->
  <script src="../js/clean-blog.min.js"></script>

</body><!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalScrollable">
  회원목록
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModalScrollable" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalScrollableTitle">회원목록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table">
		  <thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">Name</th>
		      <th scope="col">Contact</th>
		      <th scope="col">분류</th>
		    </tr>
		  </thead>
		  <tbody>
		    <%while(members.next()){
		    	%>
		    	<tr>
		      		<th scope="row"><%=members.getRow() %></th>
		      		<td><%=members.getString("user_name") %></td>
		      		<td><%=members.getString("user_contact") %></td>
		      		<td><%=members.getInt("is_master") == 1?"개설자":"회원" %></td>
		    	</tr>
		    	<%
		    	} 
		    %>
		    
		  </tbody>
		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>

</html>

<script type="text/javascript">
$(document).ready(function() {
	$("button#login-required").click(function() {
		location.href="/projectslb/auth/login.jsp?referer=/projectslb/searchStudy/studyDetail.jsp?studyIdx=<%=studyIdx%>";	
	});
	$("button#join-study").click(function() {
		location.href="/projectslb/searchStudy/studyJoin.jsp?studyIdx=<%=studyIdx%>";	
	});
 });
</script>
