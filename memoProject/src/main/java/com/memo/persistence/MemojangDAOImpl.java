package com.memo.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.memo.domain.BookmarkVO;
import com.memo.domain.CalendarVO;
import com.memo.domain.Criteria;
import com.memo.domain.MemojangVO;
import com.memo.dto.ContentChartDTO;
import com.memo.dto.DayChartDTO;
import com.memo.dto.MemberDTO;
import com.memo.dto.WordcloudDTO;

@Repository
public class MemojangDAOImpl implements MemojangDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.memo.mappers.MemojangMapper";

	@Override
	public void memoCreate(MemojangVO vo) throws Exception {
		session.insert(namespace + ".memoCreate", vo);
	}

	@Override
	public MemojangVO memoOneRead(Integer memoNo) throws Exception {
		return session.selectOne(namespace + ".memoOneRead", memoNo);
	}

	@Override
	public void memoUpdate(MemojangVO vo) throws Exception {
		session.update(namespace + ".memoUpdate", vo);
	}

	@Override
	public void memoDelete(Integer memoNo) throws Exception {
		session.delete(namespace + ".memoDelete", memoNo);
	}

	@Override
	public List<MemojangVO> memoListAll(Integer memoNo) throws Exception {
		return session.selectList(namespace + ".memoListAll", memoNo);
	}

	@Override
	public void updateViewCnt(Integer memoNo) throws Exception {
		session.update(namespace + ".updateViewCnt", memoNo);
		
	}

	@Override
	public void addAttach(String fullName) throws Exception {
		session.insert(namespace + ".addAttach", fullName);
		
	}

	@Override
	public List<String> getAttach(Integer memoNo) throws Exception {
		return session.selectList(namespace + ".getAttach", memoNo);
	}

	@Override
	public void deleteAttach(Integer memoNo) throws Exception {
		session.delete(namespace + ".deleteAttach", memoNo);
		
	}

	@Override
	public void replaceAttach(String fullName, Integer memoNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("MEMO_NO", memoNo);
		paramMap.put("IMAGE_NAME", fullName);
		
		session.insert(namespace + ".replaceAttach", paramMap);
		
	}

	@Override
	public int countPaging() throws Exception {
		return session.selectOne(namespace + ".countPaging");
	}

	@Override
	public List<MemojangVO> listCriteria(Map<String, String> searchParam) {
		return session.selectList(namespace + ".listCriteria", searchParam);
	}

	@Override
	public void bookmarkAdd(BookmarkVO vo) throws Exception {
		session.insert(namespace + ".bookmarkAdd", vo);
	}

	@Override
	public void bookmarkDelete(BookmarkVO vo) throws Exception {
		session.delete(namespace + ".bookmarkDelete", vo);
	}

	@Override
	public int countBookPaging() throws Exception {
		return session.selectOne(namespace + ".countBookPaging");
	}

	@Override
	public List<MemojangVO> listBookCriteria(Map<String, String> searchParam) {
		return session.selectList(namespace + ".listBookCriteria", searchParam);
	}

	@Override
	public int getMemoLike(BookmarkVO vo) throws Exception {
		return session.selectOne(namespace + ".getMemoLike", vo);
	}

	@Override
	public List<MemojangVO> othersMemoList(Map<String, String> searchParam) {
		return session.selectList(namespace + ".othersMemoList", searchParam);
	}

	@Override
	public List<CalendarVO> calendarList(Map<String, String> searchParam) {
		return session.selectList(namespace + ".calendarList", searchParam);
	}

	@Override
	public List<DayChartDTO> dayChart(Integer memNo) {
		return session.selectList(namespace + ".dayChart", memNo);
	}

	@Override
	public List<WordcloudDTO> wordCloud(Map<String, String> searchParam) {
		return session.selectList(namespace + ".wordCloud", searchParam);
	}

	@Override
	public List<ContentChartDTO> contentChart(Integer memNo) {
		return session.selectList(namespace + ".contentChart", memNo);
	}
	

}
