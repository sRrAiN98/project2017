package com.main;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardDataBean {
	
	private int num;
	
	private String writer;
	
	private String subject;
	
	private String email;
	
	private String content;
	
	private String passwd;
	
	private Timestamp reg_date;
	
	private int readcount;
	
	private String ip;
	
	private int ref;
	
	private int re_step;
	
	private int re_level;
}
