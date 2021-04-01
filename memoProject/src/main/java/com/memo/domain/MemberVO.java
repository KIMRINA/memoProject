package com.memo.domain;

import lombok.Data;

@Data
public class MemberVO {
	private String memNo;
	private String memEmail;
	private String memName;
	private String memType;
	private String memAccessToken;
	private String memPw;
	private String memPhone;
	private String memGender;
	private boolean memEnabled;
	private String memAuthority;
	

}
