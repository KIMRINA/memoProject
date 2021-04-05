package com.memo.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.memo.domain.MemojangVO;
import com.memo.service.MemojangService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemojangCtrl {
	
	@Inject
	private MemojangService service;
	
	@GetMapping("/main/memoMain")
	public void main() {
		log.info("** memozzang main **");
	}
	
	@PostMapping("/main/memoCreate")
	public String memoCreate(MemojangVO vo, RedirectAttributes rttr) throws Exception {
		log.info("** memozzang memoCreate **");
		log.info(vo.toString());
		
		service.memoCreate(vo);
		
		rttr.addAttribute("msg", "SUCCESS");
		
		return "redirect:/mymemo/mymemoDefaultAll";
	}
	
	@GetMapping("/mymemo/mymemoDefaultAll")
	public void mymemoDefaultAll() {
		log.info("** mymemoDefaultAll **");
	}
	
	

}
