package com.memo.service;

import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.memo.dto.MemberDTO;
import com.memo.persistence.MemberDAO;
import com.memo.security.CustomLoginSuccessHandler;
import com.memo.security.SHA256Encryption;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {
	
	
	/*
	 * @Autowired private SHA256Encryption sha256Encryption;
	 */
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	
	@Resource
	private MemberDAO dao;
	
	/*
     * password 암호화.
     * # Spring Security 에 사용하는 인코더는 PasswordEncoder 인터페이스를 구현한 것이어야 한다.
     *    이것만 구현해준다면 본인만의 암호화 기법을 구현하면 된다.
     * # PasswordEncoder의 종류가 두가지 있다.
     * - org.springframework.security.authentication.encoding.PasswordEncoder (X) = >deprecated(사용되지 않음)
     * - org.springframework.security.crtpto.password.PasswordEncoder (O)
     */


	/*
	 * @Override public MemberDTO login(MemberDTO dto) throws Exception { 
	 * 		return null; 
	 * }
	 */

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberDTO member = dao.readUser(username);
		if(member==null) {
            throw new UsernameNotFoundException(username);
        }
		member.setAuthorities(dao.readAuth(username));
		
		log.warn("member : " + member);
 
        return member;
        
	}

	@Override
	public Collection<GrantedAuthority> getAuthorities(String username) {
		Collection<GrantedAuthority> authorities = dao.readAuthority(username);
        return authorities;
	}
	
	
	/*
     * read, create, delete, passwordEncoder.
     */

	@Override
	public MemberDTO readUser(String username) {
		MemberDTO member = dao.readUser(username);
		//member.setAuthorities(dao.readAuthority(username));
 
        return member;
	}

    /*
     * userMapper의 createUser를 호출하기 전에 패스워드를 암호화 해준다.
     * 암호화에 사용된 인코더는 SHA256Enctryption 이다.
     * @see com.mingood.gitup.service.UserService#createUser(com.mingood.gitup.dto.User)
     */
	@Override
	public void createUser(MemberDTO member) {
		//String rawPassword = member.getPassword();
        //String encodedPassword = bCryptPasswordEncoder.encode(rawPassword);
 
        //member.setPassword(encodedPassword);
		
		member.setEnabled(true);
		member.setAccountNonExpired(true);
		member.setAccountNonLocked(true);
		member.setCredentialsNonExpired(true);

        dao.createUser(member);
        // dao.createAuthority(member);

	}

	@Override
	public void deleteUser(String username) {
		dao.deleteUser(username);
		dao.deleteAuthority(username);
	}

	@Override
	public BCryptPasswordEncoder passwordEncoder() {
		return this.bCryptPasswordEncoder;
	}

	@Override
	public boolean userNameCheck(String username) throws Exception {
		
		boolean isCheck=false;
        int check = dao.userNameCheck(username);
        // 0보다 크면 중복이 존재 true 반환
        if(check>0) {
            isCheck=true;
        }else {
            // 0이면 중복 없음.
            isCheck=false;
        }
        return isCheck;
	}


}
