<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="searchDAO" class="db.SearchDAO"/>
<%
	request.setCharacterEncoding("UTF-8");
	int studyIdx = Integer.valueOf(request.getParameter("studyIdx"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writter = (String)session.getAttribute("user_id");
	
	boolean writeResult = searchDAO.writeDiary(studyIdx, title, content, writter);
	%>
	<script>
	<%
	if(writeResult){//성공한 경우
		//response.sendRedirect("/projectslb/searchStudy/studyDetail.jsp?studyIdx="+studyIdx);
	%>
	alert('일지 작성이 완료되었습니다.');
	<%
	
	}else{
		%>
		alert('일지 작성에 실패했습니다.');
		<%
	}
%>
location.href="/projectslb/searchStudy/studyDetail.jsp?studyIdx=<%=studyIdx%>";
</script>
