<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "color.jspf" %>    
<link href="style.css" rel="stylesheet" type="text/css">    
<script type="text/javascript" src="script.js"></script>
<body bgcolor=<%=bodyback_c %>>
<%
	int num=0,ref=0;
	int re_step=0,re_level=0;
	
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
		ref = Integer.parseInt(request.getParameter("ref"));
		re_step = Integer.parseInt(request.getParameter("re_step"));
		re_level = Integer.parseInt(request.getParameter("re_level"));
	}
	
%>

<form name=writeform method=post action=writePro.jsp onSubmit="return writeSave()">
<input type="hidden" name="num" value=<%=num %>>
<input type="hidden" name="ref" value=<%=ref %>>
<input type="hidden" name="re_step" value=<%=re_step %>>
<input type="hidden" name="re_level" value=<%=re_level %>>
<table border=1>
	<tr>
		<td colspan=2 align=center><b>글쓰기</b></td>
	</tr>
	<tr>
		<td colspan=2 align=right><a href="index.jsp">글목록</a></td>
	</tr>
	<tr>
		<td width=70 bgcolor=<%=value_c %>>이름 </td>
		<td width=330><input type=text name=writer size=10 maxlength=10></td>
	</tr>
	<tr>
		<td bgcolor=<%=value_c %>>제 목</td>
		<td><input type=text name=subject size=40 maxlength=50></td>
	</tr>
	<tr>
		<td bgcolor=<%=value_c %>>Email</td>
		<td><input type=text name=email size=40 maxlength=30></td>
	</tr>
	<tr>
		<td bgcolor=<%=value_c %>>내 용</td>
		<td><textarea name=content rows=13 cols=40></textarea></td>
	</tr>
	<tr>
		<td bgcolor=<%=value_c %>>비밀번호</td>
		<td><input type=password name=passwd size=8 maxlength=12></td>
	</tr>
	<tr>
		<td colspan=2 align=center>
			<input type=submit value=글쓰기>
			<input type=reset value=다시작성>
			<input type=button value=목록보기 onClick="location.href='index.jsp'">
		</td>
	</tr>
</table>
</form>
</body>