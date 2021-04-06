package com.memo.service;

import java.util.List;
import java.util.Map;

import com.memo.domain.Criteria;
import com.memo.domain.MemojangVO;
import com.memo.dto.MemberDTO;

public interface MemojangService {
	
	public void memoCreate(MemojangVO vo) throws Exception;
	public MemojangVO memoOneRead(Integer memoNo) throws Exception;
	public void memoUpdate(MemojangVO vo) throws Exception;
	public void memoDelete(Integer memoNo) throws Exception;
	public List<MemojangVO> memoListAll(Integer memoNo) throws Exception;
	public List<String> getAttach(Integer imgNo) throws Exception;
	
	public List<MemojangVO> listCriteria(Integer memNo, Integer pageStart, Integer perPageNum) throws Exception;
	public int listCountCriteria() throws Exception;
	public List<MemojangVO> listCriteria(Map<String, String> searchParam);

}
