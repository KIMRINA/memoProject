package com.memo.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.memo.domain.BookmarkVO;
import com.memo.domain.CalendarVO;
import com.memo.domain.Criteria;
import com.memo.domain.MemojangVO;
import com.memo.dto.ContentChartDTO;
import com.memo.dto.DayChartDTO;
import com.memo.dto.MemberDTO;
import com.memo.dto.WordcloudDTO;

@Mapper
public interface MemojangDAO {
	
	public void memoCreate(MemojangVO vo) throws Exception;
	public MemojangVO memoOneRead(Integer memoNo) throws Exception;
	public void memoUpdate(MemojangVO vo) throws Exception;
	public void memoDelete(Integer memoNo) throws Exception;
	public List<MemojangVO> memoListAll(Integer memNo) throws Exception;
	public void updateViewCnt(Integer memoNo) throws Exception;
	
	public void addAttach(String fullName) throws Exception;
	public List<String> getAttach(Integer memoNo) throws Exception;
	public void deleteAttach(Integer memoNo) throws Exception;
	public void replaceAttach(String fullName, Integer memoNo) throws Exception;
	
	public int countPaging() throws Exception;
	public List<MemojangVO> listCriteria(Map<String, String> searchParam);
	
	public void bookmarkAdd(BookmarkVO vo) throws Exception;
	public void bookmarkDelete(BookmarkVO vo) throws Exception;
	public int countBookPaging() throws Exception;
	public List<MemojangVO> listBookCriteria(Map<String, String> searchParam);
	public int getMemoLike(BookmarkVO vo) throws Exception;
	
	public List<MemojangVO> othersMemoList(Map<String, String> searchParam);	// 타인메모모아보기
	
	public List<CalendarVO> calendarList(Map<String, String> searchParam);		// 캘린더로모아보기
	
	public List<DayChartDTO> dayChart(Integer memNo);	// 차트로모아보기
	public List<ContentChartDTO> contentChart(Integer memNo);	// 차트로모아보기
	public List<WordcloudDTO> wordCloud(Map<String, String> searchParam);

}
