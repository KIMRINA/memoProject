package com.memo.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.memo.dto.MemberDTO;
import com.memo.service.MemberService;
import com.sun.org.apache.bcel.internal.util.BCELComparator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	
	@Inject
	MemberService service;
	
	@Inject
	BCryptPasswordEncoder pwEncoder;
	
	
	@GetMapping("/member/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/member/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("로그인 페이지로 이동");
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "로그인 실패");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "로그아웃 되었습니다.");
		}
	}
	
	@GetMapping("/member/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}

}
