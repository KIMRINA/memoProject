package com.memo.service;

import java.util.List;
import java.util.Map;

import com.memo.domain.BookmarkVO;
import com.memo.domain.CalendarVO;
import com.memo.domain.Criteria;
import com.memo.domain.MemojangVO;
import com.memo.dto.ContentChartDTO;
import com.memo.dto.DayChartDTO;
import com.memo.dto.MemberDTO;
import com.memo.dto.WordcloudDTO;

public interface MemojangService {
	
	public void memoCreate(MemojangVO vo) throws Exception;
	public MemojangVO memoOneRead(Integer memoNo) throws Exception;
	public void memoUpdate(MemojangVO vo) throws Exception;
	public void memoDelete(Integer memoNo) throws Exception;
	public List<MemojangVO> memoListAll(Integer memoNo) throws Exception;
	public List<String> getAttach(Integer imgNo) throws Exception;
	
	public int listCountCriteria() throws Exception;
	public List<MemojangVO> listCriteria(Map<String, String> searchParam);
	
	public List<MemojangVO> listSearch(Map<String, String> searchParam);	// 타인메모모아보기
	public int listSearchCount(MemojangVO vo) throws Exception;
	
	public void bookmarkAdd(BookmarkVO vo) throws Exception;
	public void bookmarkDelete(BookmarkVO vo) throws Exception;
	public int countBookPaging() throws Exception;
	public List<MemojangVO> listBookCriteria(Map<String, String> searchParam);
	public int getMemoLike(BookmarkVO vo) throws Exception;
	
	public List<MemojangVO> othersMemoList(Map<String, String> searchParam);
	
	public List<CalendarVO> calendarList(Map<String, String> searchParam);		// 캘린더로모아보기
	
	public List<DayChartDTO> dayChart(Integer memNo);
	public List<ContentChartDTO> contentChart(Integer memNo);	// 차트로모아보기
	public List<WordcloudDTO> wordCloud(Map<String, String> searchParam);

}
