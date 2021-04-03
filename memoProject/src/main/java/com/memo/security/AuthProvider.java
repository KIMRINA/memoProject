package com.memo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.memo.dto.MemberDTO;
import com.memo.service.MemberService;

@Component
public class AuthProvider implements AuthenticationProvider {
	
    @Autowired
    private MemberService service;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = authentication.getName();

        MemberDTO dto = (MemberDTO) service.loadUserByUsername(username);
        if (dto == null) throw new UsernameNotFoundException("login failure");
        
        UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(dto, null, dto.getAuthorities());
		
        return result;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return false;
	}

}
