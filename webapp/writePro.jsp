<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.main.BoardDataBean" %>
<%@ page import = "com.main.BoardDBBean" %>
<%@ page import = "java.sql.*" %>

<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="article" class="com.main.BoardDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>
<%
	article.setReg_date(new Timestamp(System.currentTimeMillis()));
	article.setIp(request.getRemoteAddr());
	
	BoardDBBean dbPro = BoardDBBean.getInstance();
	dbPro.insertArticle(article);
	
	response.sendRedirect("index.jsp");	
%>