package com.memo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
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
import com.memo.domain.BookmarkVO;
import com.memo.domain.MemojangVO;
import com.memo.dto.MemberDTO;
import com.memo.service.MemberService;
import com.memo.service.MemojangService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemoBookmarkCtrl {

	@Inject
	private MemojangService service;

	@Inject
	private MemberService memService;

	// 북마크로 모아보기
	@GetMapping("/mymemo/mymemoBookmark")
	public void mymemoBookmarkGET(@ModelAttribute MemberDTO dto, HttpSession session, Model model) throws Exception {
		log.info("** mymemoBookmarkGET **");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;

		String username = userDetails.getUsername();

		MemberDTO login = (MemberDTO) session.getAttribute("login");
		MemberDTO after = memService.readUser(username);

		model.addAttribute("listAll", service.memoListAll(dto.getMem_no()));
		model.addAttribute("listCount", service.countBookPaging());
	}

	// ajax
	@RequestMapping(value = "/mymemo/heartAdd", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int heartAdd(HttpServletRequest httpRequest) throws Exception {
		log.info("** heartAdd **");

		int heart = Integer.parseInt(httpRequest.getParameter("heart"));
		int memoNo = Integer.parseInt(httpRequest.getParameter("memo_no"));
		int userid = ((MemberDTO) httpRequest.getSession().getAttribute("login")).getMem_no();

		BookmarkVO vo = new BookmarkVO();

		vo.setMemo_no(memoNo);
		vo.setMem_no(userid);

		System.out.println("memoNo" + memoNo);
		System.out.println("userid" + userid);
		System.out.println("heart" + heart);

		if (heart >= 1) {
			System.out.println("지워지고있나");
			service.bookmarkDelete(vo);
			heart = 0;
		} else {
			service.bookmarkAdd(vo);
			heart = 1;
		}

		return heart;

	}

	@RequestMapping(value = "/mymemo/mymemoBookSort", produces = "application/text;charset=UTF-8", method = RequestMethod.GET)
	@ResponseBody
	public String mymemoBookSort(@RequestParam Map<String, String> param) throws Exception {
		log.info("** searchMoreNotify **");

		Map<String, String> searchParam = new HashMap<String, String>(); // search 파라미터 생성
		String aa = searchParam.put("startIndex", param.get("startIndex"));
		String bb = searchParam.put("endIndex", param.get("endIndex"));
		String dd = searchParam.put("mem_no", param.get("mem_no"));

		System.out.println("?: " + aa);
		System.out.println("??: " + bb);
		System.out.println("???: " + dd);

		// startIndex ~ endIndex 범위에 해당하는 list 조회
		List<MemojangVO> addList = service.listBookCriteria(searchParam);

		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(addList);
		return jsonStr;
	}

}
