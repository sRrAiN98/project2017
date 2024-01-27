<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "color.jspf" %>  
<%@ page import = "com.main.*" %>  
<link href="style.css" rel="stylesheet" type="text/css">    
<script type="text/javascript" src="script.js"></script>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.updateGetArticle(num);
%>

<body bgcolor=<%=bodyback_c %>>
<form name=updateform method=post action=updatePro.jsp onSubmit="return writeSave()">
<table border=1>
	<tr>
		<td colspan=2 align=center><b>글수정</b>
			<input type=hidden name=num value=<%=article.getNum() %>>
		</td>		
	</tr>
	<tr>
		<td colspan=2 align=right><a href="index.jsp">글목록</a></td>
	</tr>
	<tr>
		<td width=70 bgcolor=<%=value_c %>>이름 </td>
		<td width=330><input type=text name=writer size=10 value="<%=article.getWriter() %>" maxlength=10></td>
	</tr>
	<tr>
		<td bgcolor=<%=value_c %>>제 목</td>
		<td><input type=text name=subject size=40 value="<%=article.getSubject() %>" maxlength=50></td>
	</tr>
	<tr>
		<td bgcolor=<%=value_c %>>Email</td>
		<td><input type=text name=email size=40 value="<%=article.getEmail() %>" maxlength=30></td>
	</tr>
	<tr>
		<td bgcolor=<%=value_c %>>내 용</td>
		<td><textarea name=content rows=13 cols=40><%=article.getContent() %></textarea></td>
	</tr>
	<tr>
		<td bgcolor=<%=value_c %>>비밀번호</td>
		<td><input type=password name=passwd size=8 maxlength=12></td>
	</tr>
	<tr>
		<td colspan=2 align=center>
			<input type=submit value=글수정>
			<input type=reset value=다시작성>
			<input type=button value=목록보기 onClick="location.href='index.jsp'">
		</td>
	</tr>
</table>
</form>
</body>