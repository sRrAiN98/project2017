<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.main.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDBBean dbPro = BoardDBBean.getInstance();
	String passwd = request.getParameter("passwd");
	int check = dbPro.deleteArticle(num,passwd);
	if (check==0){
		out.println("<script language=javascript>");
		out.println("alert('비밀번호를 잘못 입력하셨습니다.')");
		out.println("history.back()");
		out.println("</script>");
	}else{
		out.println("<script language=javascript>");
		out.println("alert('삭제되었습니다.')");
		out.println("location.href='index.jsp'");
		out.println("</script>");
		
		//response.sendRedirect("index.jsp");
	}
%>
</body>
</html>