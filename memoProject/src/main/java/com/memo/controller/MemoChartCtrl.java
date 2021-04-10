package com.memo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.memo.domain.Criteria;
import com.memo.dto.ContentChartDTO;
import com.memo.dto.DayChartDTO;
import com.memo.dto.MemberDTO;
import com.memo.dto.WordcloudDTO;
import com.memo.service.MemberService;
import com.memo.service.MemojangService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemoChartCtrl {

	@Inject
	private MemojangService service;

	@Inject
	private MemberService memService;

	// 힌눈에 모아보기
	@GetMapping("/mymemo/mymemoChart")
	public void mymemoDefaultAll(@ModelAttribute MemberDTO dto, HttpSession session, Criteria cri, Model model)
			throws Exception {
		log.info("** mymemoChart **");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;

		String username = userDetails.getUsername();

		MemberDTO login = (MemberDTO) session.getAttribute("login");
		MemberDTO after = memService.readUser(username);

		model.addAttribute("listCount", service.listCountCriteria());
	}

	@SuppressWarnings("unchecked")
	@GetMapping("/mymemo/dayChart")
	public ResponseEntity<JSONObject> dayChart(int mem_no) {
		ResponseEntity<JSONObject> entity = null;
		List<DayChartDTO> items = service.dayChart(mem_no);
		// 리스트 형태를 json 형태로 만들어서 리턴
		JSONObject data = new JSONObject();

		// 컬럼객체
		JSONObject col1 = new JSONObject();
		JSONObject col2 = new JSONObject();
		JSONArray title = new JSONArray();
		col1.put("label", "날짜");
		col1.put("type", "string");
		col2.put("label", "카운트");
		col2.put("type", "number");

		title.add(col1);
		title.add(col2);

		data.put("cols", title);
		/*
		 * "rows": [ {"c":[{"v":"Mushrooms"},{"v":3}]}, {"c":[{"v":"Onions"},{"v":1}]},
		 * ]
		 * 
		 * rows : [ 배열 (객체 :배열[객체])]
		 * 
		 */

		// 들어갈 형태 -> rows 객체 에 배열 <-
		// <- [ c 라는 객체에 배열 <- 객체
		// data 객체 -> rows 배열 <- c 객체 ->배열 <- v 객체 2개/

		JSONArray body = new JSONArray();
		for (DayChartDTO dto : items) {
			JSONObject writedate = new JSONObject();
			writedate.put("v", dto.getMemo_writedate()); // 가격 ->v 객체
			JSONObject count = new JSONObject();
			count.put("v", dto.getCount()); // 상품이름 -> v 객체

			// v객체를 row 배열을 만든후 추가한다.
			JSONArray row = new JSONArray();
			row.add(writedate);
			row.add(count);

			// c 객체 를 만든후 row 배열을 담는다.
			JSONObject c = new JSONObject();
			c.put("c", row);
			// c 객체를 배열 형태의 body 에 담는다.
			body.add(c);
		}
		// 배열 형태의 body 를 rows 키값으로 객체 data 에 담는다.
		data.put("rows", body);
		try {
			entity = new ResponseEntity<JSONObject>(data, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(" 에러            -- ");
			entity = new ResponseEntity<JSONObject>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@SuppressWarnings("unchecked")
	@GetMapping("/mymemo/contentChart")
	public ResponseEntity<JSONObject> contentChart(int mem_no) {
		ResponseEntity<JSONObject> entity = null;
		List<ContentChartDTO> items = service.contentChart(mem_no);
		// 리스트 형태를 json 형태로 만들어서 리턴
		JSONObject data = new JSONObject();

		// 컬럼객체
		JSONObject col1 = new JSONObject();
		JSONArray title = new JSONArray();
		col1.put("label", "내용");
		col1.put("type", "string");

		title.add(col1);

		data.put("cols", title);

		JSONArray body = new JSONArray();
		for (ContentChartDTO dto : items) {
			JSONObject content = new JSONObject();
			content.put("v", dto.getMemo_contents()); // 가격 ->v 객체

			// v객체를 row 배열을 만든후 추가한다.
			JSONArray row = new JSONArray();
			row.add(content);

			// c 객체 를 만든후 row 배열을 담는다.
			JSONObject c = new JSONObject();
			c.put("c", row);
			// c 객체를 배열 형태의 body 에 담는다.
			body.add(c);
		}
		// 배열 형태의 body 를 rows 키값으로 객체 data 에 담는다.
		data.put("rows", body);
		try {
			entity = new ResponseEntity<JSONObject>(data, HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(" 에러            -- ");
			entity = new ResponseEntity<JSONObject>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	
	@GetMapping("/mymemo/wordcloud")
	@ResponseBody
	public String wordCloud(@RequestParam Map<String, String> param) throws Exception {
		Map<String, String> searchParam = new HashMap<String, String>(); // search 파라미터 생성
		String dd = searchParam.put("mem_no", param.get("mem_no"));

		List<WordcloudDTO> list = service.wordCloud(param);

		String json = null;
		try {
			json = new ObjectMapper().writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}

}
