<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="studyDB" class="db.StudyProcess" ></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	String studyName = request.getParameter("studyName");
	String studyDesc = request.getParameter("studyDesc");
	String userId = (String)session.getAttribute("user_id"); // user_id가 안 전해진 이유?
	
	//스터디 생성 정보를 DB에 저장하는 코드 작성
	boolean createResult = false;
	if(userId != null){
		createResult = studyDB.createStudy(studyName, studyDesc, userId);
	}
	
	
	if(createResult){
		%>
		<script type="text/javascript">
			alert('스터디 생성이 완료되었습니다^_^');
			location.href = "/projectslb/index.jsp";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert('스터디 생성이 실패했습니다.x_x');
			location.href = "/projectslb/createStudy/index.jsp";
		</script>
		<%
	}
%>
