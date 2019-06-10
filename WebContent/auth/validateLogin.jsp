<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="loginDAO" class="db.LoginDAO" ></jsp:useBean>
<%
request.setCharacterEncoding("UTF-8");
// 로그인 이전 경로를 받아 저장
String referer = request.getParameter("referer");
if(referer == null || referer.equals("null") || referer=="")
{
	referer = "/projectslb/index.jsp";
}

// 아이디, 비밀번호 받기
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pwd");
// DB에 연동
boolean loginResult = loginDAO.login(userId, userPwd);

if(loginResult){
	// 로그인  성공
	session.setAttribute("user_id",userId);
	%>
	<script>
   alert("로그인 성공했습니다.");
   location.href = "<%=referer%>";
  </script>
	<%
}else{
	// 로그인 실패
	%>
	<script>
   alert("로그인 실패했습니다.");
   location.href = "/projectslb/auth/login.jsp";
  </script>
	<%
}

%>