<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "color.jspf" %>  
<%@ page import = "com.main.*" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css">    
</head>
<body bgcolor=<%=bodyback_c %>>
<form action=deletePro.jsp method=post>
	<table align=center>
		<tr>
			<td colspan=2 height=30 align=center><b>글삭제</b>
			<input type="hidden" name=num value=<%=request.getParameter("num") %>>
			</td>
		</tr>
		<tr>
			<td colspan=2 bgcolor=<%=value_c %>>비밀번호를 입력하십시오.</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type=password name=passwd></td>
		</tr>
		<tr>
			<td colspan=2 bgcolor=<%=value_c %> align=center>
				<input type="submit" value=글삭제>
				<input type="button" value=글목록 onClick="location.href='index.jsp'">
			</td>
		</tr>
	</table>
</form>
</body>
</html>