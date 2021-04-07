package com.memo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.memo.domain.Criteria;
import com.memo.domain.MemojangVO;
import com.memo.dto.MemberDTO;
import com.memo.service.MemberService;
import com.memo.service.MemojangService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemojangCtrl {
	
	@Inject
	private MemojangService service;
	
	@Inject
	private MemberService memService;
	

	@GetMapping("/main/memoMain")
	public void memoMain() {
		log.info("** memozzang NoLoin main **");
	}
	
	@GetMapping("/main/loginMain")
	public void loginMain(@ModelAttribute MemberDTO dto, HttpSession session) {
		log.info("** memozzang loginMain **");
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		
		String username = userDetails.getUsername();
		
		MemberDTO login = (MemberDTO)session.getAttribute("login");
		MemberDTO after = memService.readUser(username);
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
	public void mymemoDefaultAll(@ModelAttribute MemberDTO dto, HttpSession session, 
				Criteria cri, Model model) throws Exception {
		log.info("** mymemoDefaultAll **");
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		
		String username = userDetails.getUsername();
		
		MemberDTO login = (MemberDTO)session.getAttribute("login");
		MemberDTO after = memService.readUser(username);
		
		model.addAttribute("listAll", service.memoListAll(dto.getMem_no()));
		model.addAttribute("listCount", service.listCountCriteria());
		//model.addAttribute("list", service.listCriteria(dto.getMem_no(), cri.getPage(), cri.getPageStart()));
	}
	
	@RequestMapping(value = "/mymemo/searchMoreNotify", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	@ResponseBody
	public String searchMoreNotify(@RequestParam Map<String,String> param) throws Exception {
		log.info("** searchMoreNotify **");
		
		Map<String, String> searchParam = new HashMap<String, String>();	// search 파라미터 생성
		String aa = searchParam.put("startIndex", param.get("startIndex"));	
		String bb = searchParam.put("endIndex", param.get("endIndex"));
		String dd = searchParam.put("mem_no", param.get("mem_no"));
		
		System.out.println("?: "+aa);
		System.out.println("??: "+bb);
		System.out.println("???: "+dd);
		
		// startIndex ~ endIndex 범위에 해당하는 list 조회 
		List<MemojangVO> addList = service.listCriteria(searchParam);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(addList);
		return jsonStr;
	}
	
	@RequestMapping(value = "/mymemo/readOneMemo", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	@ResponseBody
	public String readOneMemo(@RequestParam("memo_no") int memoNo, Model model) throws Exception {
		log.info("** readOneMemo **");
		
		System.out.println("memoOneRead: " + service.memoOneRead(memoNo));
		model.addAttribute("list", service.memoOneRead(memoNo));
		
		MemojangVO addList = service.memoOneRead(memoNo);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(addList);
		return jsonStr;
	}
	
	// 삭제
	@GetMapping("/mymemo/memoDelete")
	public String memoDelete(@RequestParam("memo_no")int memoNo, RedirectAttributes rttr)
			throws Exception {
		log.info("** memoDelete **");
		service.memoDelete(memoNo);
		
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/mymemo/mymemoDefaultAll";
	}
	
	


}