package com.memo.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.memo.domain.BookmarkVO;
import com.memo.domain.Criteria;
import com.memo.domain.MemojangVO;
import com.memo.dto.MemberDTO;

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
	

}
