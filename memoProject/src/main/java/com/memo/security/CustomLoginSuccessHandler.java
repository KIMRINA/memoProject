package com.memo.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import com.memo.domain.Criteria;
import com.memo.dto.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, 
			Authentication auth) throws IOException, ServletException {
		log.warn("Login Success");
		
		// IP, 세션 ID
		WebAuthenticationDetails web = (WebAuthenticationDetails) auth.getDetails();
		System.out.println("IP : " + web.getRemoteAddress());
		System.out.println("Session ID : " + web.getSessionId());
		
		// 인증 ID
		System.out.println("name : " + auth.getName());
		
		//인증된 사용자의 정보를 추출
		MemberDTO dto = (MemberDTO) auth.getPrincipal();
		System.out.println("인증후=>"+dto);
		
		//권한리스트를 추출
		Collection<GrantedAuthority> authlist = (Collection<GrantedAuthority>) auth.getAuthorities();
		Iterator<GrantedAuthority> authlist_it= authlist.iterator();
		
//		System.out.print("권한 : ");
//		for(int i = 0; i< authlist.size(); i++) {
//			System.out.print(authlist.get(i).getAuthority() + " ");
//		}
//		System.out.println();
		
		String url="/";
		while(authlist_it.hasNext()) {
			GrantedAuthority authority= authlist_it.next();
			//설정되어 있는 권한 중 ROLE_ADMIN이 있다면
			if(authority.getAuthority().equals("ROLE_ADMIN")) {
				url="/member/admin";
			} else if(authority.getAuthority().equals("ROLE_MEMBER")) {
				url="/main/loginMain";
			}
		}
		
		Criteria cri = new Criteria();
		
		request.getSession().setAttribute("msg", url);
		request.getSession().setAttribute("login", dto);
		request.getSession().setAttribute("memPhone", dto.getMem_phone());		// 세션고객번호
		request.getSession().setAttribute("memName", dto.getMem_name());	// 세션고객이름
		request.getSession().setAttribute("cri", cri);
		
		response.sendRedirect(url);

//		List<String> roleNames = new ArrayList<>();
//
//		auth.getAuthorities().forEach(authority -> {
//			roleNames.add(authority.getAuthority());
//		});
//		
//		log.warn("ROLE NAMES : " + roleNames);
//
//		if (roleNames.contains("ROLE_ADMIN")) {
//			response.sendRedirect("/sample/admin");
//			return;
//		}
//
//		if (roleNames.contains("ROLE_MEMBER")) {
//			response.sendRedirect("/sample/member");
//			return;
//		}
//
//		response.sendRedirect("/");

	}

}
