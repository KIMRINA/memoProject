package com.memo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.memo.domain.MemojangVO;
import com.memo.service.MemojangService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OthersMemoCtrl {

	@Inject
	private MemojangService service;

	// 타인메모 모아보기
	@GetMapping("/others/othersMemo")
	public void mymemoDefaultAll(Model model) throws Exception {
		log.info("** othersMemo **");

		model.addAttribute("listCount", service.listCountCriteria());
	}

	@RequestMapping(value = "/others/othersMemoList", produces = "application/text;charset=UTF-8", method = RequestMethod.GET)
	@ResponseBody
	public String othersMemoList(@RequestParam Map<String, String> param) throws Exception {
		log.info("** othersMemoList **");

		Map<String, String> searchParam = new HashMap<String, String>(); // search 파라미터 생성
		String aa = searchParam.put("startIndex", param.get("startIndex"));
		String bb = searchParam.put("endIndex", param.get("endIndex"));

		System.out.println("?: " + aa);
		System.out.println("??: " + bb);

		// startIndex ~ endIndex 범위에 해당하는 list 조회
		List<MemojangVO> addList = service.othersMemoList(searchParam);

		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(addList);
		return jsonStr;
	}
	

}
