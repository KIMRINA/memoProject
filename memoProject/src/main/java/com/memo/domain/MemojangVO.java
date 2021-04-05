package com.memo.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemojangVO {
	
	private int memo_no;
	private int mem_no;
	private String username;
	private String memo_name;
	private String memo_title;
	private String memo_contents;
	private Date memo_writedate;
	private int memo_hits;
	private int memo_open;
	private String[] files;

}
