package com.main;

import java.sql.*;
import java.util.*;

public class BoardDBBean {
	
	private Connection conn;
	private PreparedStatement pstmt;
	
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String JDBC_URL = "jdbc:mysql://eunyooung.ddns.net:3306/jjh";
	private static final String DB_ID = "jjh";
	private static final String DB_PASS = "19980216";
	
	private static BoardDBBean instance = new BoardDBBean();
	
	private BoardDBBean() {}
	
	public static BoardDBBean getInstance() {
		
		return instance;
	}
	
	private void getConnection() {
		
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, DB_ID, DB_PASS);
			
		} catch (Exception e) {
			
			System.out.println("Exception : " + e.getMessage());
		}
	}
	
	public void disConnection() {
		
		try {
			if(pstmt != null) pstmt.close();
			if(conn != null) pstmt.close();
			
		} catch(Exception ex) {
			
		}
	}
	
	public void insertArticle(BoardDataBean article) {
		
		String sql;
		
		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		int number = 0;

		try {
			getConnection();
			
			sql = "SELECT max(num) FROM board";
			
			pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				number = rs.getInt(1) + 1;
			} else {
				number = 1;
			}

			if (num != 0) {
				
				sql = "UPDATE board SET re_step = re_step + 1 WHERE ref = ? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
				
			} else {
				
				ref = number;
				re_step = 0;
				re_level = 0;
			}

			sql = "INSERT INTO board(writer,email,subject,passwd,";
			sql += "reg_date,ref,re_step,re_level,content,ip) VALUES(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			pstmt.executeUpdate();
			
			rs.close();
			
		} catch (Exception e) {
			
			System.out.println("Exception : " + e.getMessage());
		} finally {
			
			disConnection();
		}
	}

	public int getArticleCount() {
		
		int count = 0;
		
		try {
			getConnection();
			
			pstmt = conn.prepareStatement("SELECT count(*) FROM board");
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
			rs.close();
			
		} catch (Exception e) {
			
			System.out.println("Exception : " + e.getMessage());
		}
		return count;
	}
	
	public List<BoardDataBean> getArticles(int start, int pageSize) {
		
		List<BoardDataBean> articleList = new ArrayList<>();

		try {
			getConnection();
			
			String sql = "SELECT * FROM board ORDER BY ref desc, re_step asc LIMIT ?, ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start - 1);
			pstmt.setInt(2, pageSize);
			
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				
				articleList = new ArrayList<BoardDataBean>();
				
				do {
					BoardDataBean article = new BoardDataBean();
					
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);
					
				} while (rs.next());
			}
			rs.close();
			
		} catch (Exception e) {
			
			System.out.println("Exception : " + e.getMessage());
		} finally {
			
			disConnection();
		}
		return articleList;
	}

	public BoardDataBean getArticle(int num) {
		
		BoardDataBean article = new BoardDataBean();
		
		try {
			getConnection();
			
			String sql = "UPDATE board SET readcount = readcount + 1 WHERE num = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			sql = "select * from board where num = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
			rs.close();
			
		} catch (Exception e) {
			
			System.out.println("Exception[getAticle] : " + e.getMessage());
		} finally {
			
			disConnection();
		}
		return article;
	}

	public BoardDataBean updateGetArticle(int num) {
		
		BoardDataBean article = new BoardDataBean();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM board WHERE num = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				article = new BoardDataBean();
				
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
			rs.close();
			
		} catch (Exception e) {
			
			System.out.println("Exception[updateGetArticle] : " + e.getMessage());
		} finally {
			
			disConnection();
		}
		return article;
	}

	public int updateArticle(BoardDataBean article) {
		
		int check = 0;
		
		try {
			getConnection();
			
			String sql = "SELECT passwd FROM board WHERE num = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				String pwd = rs.getString("passwd");
				
				if (pwd.equals(article.getPasswd())) {
					sql = "UPDATE board SET writer = ?, subject = ?, email = ?, content = ? WHERE num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getEmail());
					pstmt.setString(4, article.getContent());
					pstmt.setInt(5, article.getNum());
					check = pstmt.executeUpdate();
				}
			}
			rs.close();
			
		} catch (Exception e) {
			
			System.out.println("Exception[updateArticle] : " + e.getMessage());
		} finally {
			
			disConnection();
		}
		return check;
	}

	public int deleteArticle(int num, String passwd) {
		int check = 0;
		
		try {
			getConnection();
			
			String sql = "SELECT passwd FROM board WHERE num = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				String pwd = rs.getString("passwd");
				
				if (pwd.equals(passwd)) {
					sql = "DELETE FROM board WHERE num = ?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					check = pstmt.executeUpdate();
				}
			}
			rs.close();
			
		} catch (Exception e) {
			
			System.out.println("Exception[deleteArticle] : " + e.getMessage());
		} finally {
			
			disConnection();
		}
		return check;
	}
}
