package com.memo.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.memo.domain.Criteria;
import com.memo.domain.MemojangVO;
import com.memo.dto.MemberDTO;
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
		
		String contents = vo.getMemo_contents();
		int idx = contents.indexOf("</p>"); 
		String setTitile = contents.substring(0, idx);
		
		vo.setMemo_title(setTitile+"</p>");
		
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
	public List<MemojangVO> memoListAll(Integer memNo) throws Exception {
		return dao.memoListAll(memNo);
	}

	@Override
	public List<String> getAttach(Integer memoNo) throws Exception {
		return dao.getAttach(memoNo);
	}

	@Override
	public List<MemojangVO> listCriteria(Integer memNo, Integer pageStart, Integer perPageNum) throws Exception {
		return dao.listCriteria(memNo, pageStart, perPageNum);
	}

	@Override
	public int listCountCriteria() throws Exception {
		return dao.countPaging();
	}

	@Override
	public List<MemojangVO> listCriteria(Map<String, String> searchParam) {
		return dao.listCriteria(searchParam);
	}

}
