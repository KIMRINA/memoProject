package com.memo.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class MemojangVO {
	
	private int memo_no;
	private int mem_no;
	private String username;
	private String memo_name;
	private String memo_title;
	private String memo_contents;
	private int memo_hits;
	private int memo_open;
	private String[] files;
	
	private int book_likecheck;
	
	private String keyword;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date memo_writedate;
	
	private BookmarkVO bookmarkVO;
}
