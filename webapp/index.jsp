<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.main.*" %>
<%@ page import="java.util.*" %>
<%@ include file="color.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null)
		pageNum="1";
	int currentPage = Integer.parseInt(pageNum);
	int pageSize = 10;
	int startRow = (currentPage-1)*pageSize + 1;
	int endRow = currentPage*pageSize;
	int number=0; // 글 번호 표시를 위한 변수
	
	List<BoardDataBean> articleList = new ArrayList<>();

	BoardDBBean dbPro = BoardDBBean.getInstance();
	articleList = dbPro.getArticles(startRow, endRow);
	int count = dbPro.getArticleCount();
	
	number = count - (currentPage-1)*pageSize;
%>
<link href="style.css" rel="ctylesheet" type="text/css">
</head>
<body bgcolor=<%=bodyback_c %>>
<table>
	<tr>
		<td colspan=6 align=center><p><font size=5>글목록(전체 글 : <%=count %>)</font></p></td>
	</tr>
	<tr>
		<td colspan=5> </td>
		<td align=right><a href="writeForm.jsp">글쓰기</a></td>
	</tr>
	<tr bgcolor="#FF9966">
		<td width=50 align=center>번호</td>
		<td width=250 align=center>제목</td>
		<td width=100 align=center>작성자</td>
		<td width=150 align=center>작성일</td>
		<td width=50 align=center>조회</td>
		<td width=100 align=center>IP</td>
	</tr>
<%
	if (!articleList.isEmpty()){
		for(int i = 0; i < articleList.size(); i++){
			BoardDataBean article = articleList.get(i);
%>
	<tr>
		<td align=center><%=number-- %></td>
		<td align=center>
<% 
			int wid=0;
			if(article.getRe_level() > 0){
				wid = 10*article.getRe_level();
%>
			<img src="images/level.jpg" width=<%=wid %>>
			<img src="images/re.png">
<%
			}
%>
			<a href="content.jsp?num=<%=article.getNum()%>"><%=article.getSubject() %></a>
			
		</td>
		<td align=center><%=article.getWriter() %></td>
		<td><%=article.getReg_date() %></td>
		<td align=center><%=article.getReadcount() %></td>
		<td><%=article.getIp() %></td>
	</tr>
<%
		}
	}
%>	
</table>
</body>
</html>