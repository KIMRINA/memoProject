package com.memo.service;

import java.util.List;

import com.memo.domain.MemojangVO;

public interface MemojangService {
	
	public void memoCreate(MemojangVO vo) throws Exception;
	public MemojangVO memoOneRead(Integer memoNo) throws Exception;
	public void memoUpdate(MemojangVO vo) throws Exception;
	public void memoDelete(Integer memoNo) throws Exception;
	public List<MemojangVO> memoListAll() throws Exception;
	public List<String> getAttach(Integer imgNo) throws Exception;

}
