<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="searchDAO" class="db.SearchDAO"></jsp:useBean>
<%
int studyIdx = Integer.valueOf(request.getParameter("studyIdx"));
String userId = (String) session.getAttribute("user_id");


if(userId==null){//로그인을 하지 않은 경우
	request.setAttribute("referer", "/projectslb/searchStudy/studyJoin.jsp");
	pageContext.forward("/auth/login.jsp");
}else if(!searchDAO.checkJoinStudy(userId, studyIdx)){//로그인을 했지만 스터디 가입은 하지 않은 경우
	boolean joinResult = searchDAO.joinStudy(userId, studyIdx);
	if(joinResult){
		%>
		<script type="text/javascript">
			alert('스터디 가입이 완료되었습니다^_^');
			location.href = "/projectslb/searchStudy/studyDetail.jsp?studyIdx=<%=studyIdx%>";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert('스터디 가입이 실패했습니다.x_x');
			location.href = "/projectslb/searchStudy/studyDetail.jsp?studyIdx=<%=studyIdx%>";
		</script>
		<%
	}
}else{//로그인은 했지만 스터디가 가입된 경우
	%>
	<script>
		alert('이미 가입된 스터디입니다.');
		location.href="/projectslb/searchStudy/index.jsp"
	</script>
	<%
}

%>