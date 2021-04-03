package com.memo.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.memo.dto.MemberDTO;
import com.memo.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberCRUDCtrl {
	
	@Inject
	MemberService service;
	
	@Inject
	BCryptPasswordEncoder pwEncoder;
	
	private static final String ViewPage = "member/memberModify1";
	
	
	@GetMapping("/member/memberModify1")
	public void memberModify1() {
		log.info("** memberModify1 **");
	}

//	@PostMapping("/member/memberModPwCheck")
//	public String memberModPwCheck(@ModelAttribute(name = "MemberDTO") MemberDTO dto, Model model) throws Exception {
//		// 비밀번호 체크
//		if (!dto.passwordCheck()) {
//			log.info("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
//			log.info("비번1: " + dto.getPassword() + "비번2: " + dto.getPwCheck());
//			model.addAttribute("pwCheck", "비밀번호가 일치하지 않습니다.");
//			return ViewPage;
//		}
//		
//		return "/member/memberModify2";
//	}
	
	// 패스워드 체크
	@ResponseBody
	@PostMapping("/member/memberModPwCheck")
	public boolean memberModPwCheck(@RequestParam("username") String username, 
									@RequestParam("password") String password) throws Exception {
		log.info("** memberModPwCheck **");

		MemberDTO login = service.readUser(username);
		log.info("전: " + password + "후: " + login.getPassword());
		boolean pwdChk = pwEncoder.matches(password, login.getPassword());
		return pwdChk;
	}
	
	
	@GetMapping("/member/memberModify2")
	public void memberModify2() {
		log.info("** memberModify2 **");
	}
	
	@GetMapping("/member/memberModify3")
	public void memberModify3(@ModelAttribute MemberDTO dto, HttpSession session) {
		log.info("** memberModify3 **");
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserDetails userDetails = (UserDetails)principal;
        
        String id = userDetails.getUsername();
 
        dto.setMem_name(id);
        //레코드 저장
        service.readUser(id);
		
	}
	
	
	
	
	

}
