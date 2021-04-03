package com.memo.controller;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
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
public class MemberJoinCtrl {
	
	@Inject
	MemberService service;
	
	@Inject
	BCryptPasswordEncoder pwEncoder;
	
	private static final String ViewPage = "member/memberJoin2";
	
	@GetMapping("/member/memberJoin2")
	public String memberForm(MemberDTO dto) throws Exception {
		log.info("** memberJoin2 **");
		return ViewPage;
	}
	
	//bindResult 다음에 Model 이 와야 한다. 순서가 틀리면 에러가 발생한다.
	@PostMapping("/member/memberJoin")
	public String memberInsert(@ModelAttribute(name = "MemberDTO") MemberDTO dto, Model model)
			throws Exception {
		log.info("** memberJoin **");

//		// username 중복 체크
//		if (service.userNameCheck(dto.getUsername())) {
//			// 0보다 크면 중복이 존재 true 반환
//			log.info("중복된 아이디 입니다.");
//			model.addAttribute("idCheck", "중복된 아이디 입니다.");
//			return ViewPage;
//		}

		// 비밀번호 체크
		if (!dto.passwordCheck()) {
			log.info("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			log.info("비번1: " + dto.getPassword() + "비번2: " + dto.getPwCheck());
			model.addAttribute("pwCheck", "비밀번호가 일치하지 않습니다.");
			return ViewPage;
		}

		// 비밀번호 암호화 작업
		if (StringUtils.hasText(dto.getPassword())) {
			String bCryptString = pwEncoder.encode(dto.getPassword());
			dto.setPassword(bCryptString);
		}

		log.info("null뜨는 이유가 뭘까: " + dto);
		service.createUser(dto);

		// return "redirect:/";
		return "/member/memberJoin3";
	}
	
	@GetMapping("/member/memberJoin1")
	public void memberJoin1() {
		log.info("** memberJoin1 **");
	}
	
	@GetMapping("/member/memberJoin3")
	public void memberJoin3() {
		log.info("** memberJoin3 **");
	}
	
	@GetMapping("/member/memberJoinTerms1")
	public void memberJoinTerms1() {
		log.info("** memberJoinTerms1 **");
	}
	
	@GetMapping("/member/memberJoinTerms2")
	public void memberJoinTerms2() {
		log.info("** memberJoinTerms2 **");
	}
	
	
	// id체크 ajax
	@GetMapping("/member/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("username") String username) {
		log.info("** memberidCheck **");
		return service.userNameCheck(username);
	}

	

}
