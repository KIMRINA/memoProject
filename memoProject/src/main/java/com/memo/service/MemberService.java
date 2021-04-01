package com.memo.service;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.memo.dto.MemberDTO;

@Service
public interface MemberService extends UserDetailsService {

	// Spring Security

	/*
	 * 권한을 받아오는 메소드. 향후 유저 등록이라든지 수정, 삭제 Service 등을 추가하면 된다.
	 */
	Collection<GrantedAuthority> getAuthorities(String username);

	/*
	 * password 암호화 과정. 유저 등록, 삭제, 읽기.
	 */
	public MemberDTO readUser(String username);

	public void createUser(MemberDTO member);

	public void deleteUser(String username);

	public PasswordEncoder passwordEncoder(); // PasswordEncoder를 리턴해 줄 메소드도 추가.

	public boolean userNameCheck(String username) throws Exception;
	
}
