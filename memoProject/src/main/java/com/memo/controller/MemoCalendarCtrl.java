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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.memo.domain.CalendarVO;
import com.memo.dto.MemberDTO;
import com.memo.service.MemberService;
import com.memo.service.MemojangService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemoCalendarCtrl {

	@Inject
	private MemojangService service;

	@Inject
	private MemberService memService;

	// 캘린더로 모아보기
	@GetMapping("/mymemo/mymemoCalendar")
	public void mymemoBookmarkGET(@ModelAttribute MemberDTO dto, HttpSession session, Model model) throws Exception {
		log.info("** mymemoCalendar **");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;

		String username = userDetails.getUsername();

		MemberDTO login = (MemberDTO) session.getAttribute("login");
		MemberDTO after = memService.readUser(username);

		model.addAttribute("listAll", service.memoListAll(dto.getMem_no()));
		model.addAttribute("listCount", service.countBookPaging());
	}
	
	
	@RequestMapping(value = "/mymemo/calendarList", produces = "application/text;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public String calendarList(@RequestParam Map<String, String> param) throws Exception {
		log.info("** calendarList **");

		Map<String, String> searchParam = new HashMap<String, String>(); // search 파라미터 생성
		String cc = searchParam.put("mem_no", param.get("mem_no"));

		System.out.println("???: " + cc);

		List<CalendarVO> addList = service.calendarList(searchParam);
		System.out.println("캘린더예? "+addList);

		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(addList);
		return jsonStr;
	}
	

}
