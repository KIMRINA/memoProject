package com.memo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

import com.memo.dto.MemberDTO;

public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	@Autowired
	MemberServiceImpl memberService;

	@SuppressWarnings("unchecked")
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = (String) authentication.getPrincipal();
        String password = (String) authentication.getCredentials();
        
        MemberDTO member = (MemberDTO) memberService.loadUserByUsername(username);
        
        if(!matchPassword(password, member.getPassword())) {
            throw new BadCredentialsException(username);
        }
 
        if(!member.isEnabled()) {
            throw new BadCredentialsException(username);
        }
		
		return new UsernamePasswordAuthenticationToken(username, password, member.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}
	
	
	private boolean matchPassword(String password, String memPw) {
        return password.equals(memPw);
    }


}
