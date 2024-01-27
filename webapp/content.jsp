<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.main.*" %>
<%@ include file="color.jspf" %>    
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.getArticle(num);
%>
<head>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor=<%=bodyback_c %>>
<table align=center>
	<tr>
		<td align=center colspan=4><b>글내용 보기</b></td>
	</tr>
	<tr>
		<td align=center colspan=4>&nbsp;</td>
	</tr>
	<tr>
		<td align=center width=125 bgcolor=<%=value_c %>>글번호</td>
		<td align=center width=125><%=article.getNum() %></td>
		<td align=center width=125 bgcolor=<%=value_c %>>조회수</td>
		<td align=center width=125><%=article.getReadcount() %></td>
	</tr>
	<tr>
		<td align=center bgcolor=<%=value_c %>>작성자</td>
		<td align=center><%=article.getWriter() %></td>
		<td align=center bgcolor=<%=value_c %>>작성일</td>
		<td align=center><%=article.getReg_date() %></td>
	</tr>
	<tr>
		<td align=center bgcolor=<%=value_c %>>글제목</td>
		<td align=center colspan=3><%=article.getSubject() %></td>
	</tr>
	<tr>
		<td align=center bgcolor=<%=value_c %>>글내용</td>
		<td colspan=3><pre><%=article.getContent() %></pre></td>
	</tr>
	<tr>
		<td align=center colspan=4 bgcolor=<%=value_c %> align=center>
			<input type=button value=글수정 onClick="location.href='updateForm.jsp?num=<%=article.getNum()%>'">
			<input type=button value=글삭제 onClick="location.href='deleteForm.jsp?num=<%=article.getNum()%>'">
			<input type=button value=답글쓰기  onClick="location.href='writeForm.jsp?num=<%=article.getNum() %>&ref=<%=article.getRef() %>&re_step=<%=article.getRe_step() %>&re_level=<%=article.getRe_level()%>'">
			<input type=button value=글목록 onClick="location.href='index.jsp'">
		</td>
	</tr>
</table>
</body>