package com.memo.service;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.memo.domain.MemojangVO;
import com.memo.persistence.MemojangDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Repository
public class MemojangServiceImpl implements MemojangService {
	
	@Inject
	private MemojangDAO dao;
	
	@Transactional
	@Override
	public void memoCreate(MemojangVO vo) throws Exception {
		dao.memoCreate(vo);
		
		String[] files = vo.getFiles();
		
		if(files == null) {return;}
		
		for(String fileName : files) {
			dao.addAttach(fileName);
		}
		
	}

	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public MemojangVO memoOneRead(Integer memoNo) throws Exception {
		dao.updateViewCnt(memoNo);
		return dao.memoOneRead(memoNo);
	}

	@Transactional
	@Override
	public void memoUpdate(MemojangVO vo) throws Exception {
		dao.memoUpdate(vo);
		
		Integer memoNo = vo.getMemo_no();
		
		dao.deleteAttach(memoNo);
		
		String[] files = vo.getFiles();
		
		if(files == null) { return; }
		
		for(String fileName : files) {
			dao.replaceAttach(fileName, memoNo);
		}
		
	}

	@Transactional
	@Override
	public void memoDelete(Integer memoNo) throws Exception {
		dao.deleteAttach(memoNo);
		dao.memoDelete(memoNo);
	}

	@Override
	public List<MemojangVO> memoListAll() throws Exception {
		return dao.memoListAll();
	}

	@Override
	public List<String> getAttach(Integer memoNo) throws Exception {
		return dao.getAttach(memoNo);
	}

}
