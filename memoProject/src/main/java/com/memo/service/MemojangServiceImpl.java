package com.memo.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.memo.domain.BookmarkVO;
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
		
		int idxLast = contents.indexOf("</p>"); 	// 내용에서 제목추출하기위해 </p>까지 추출할라고 선언
		int idxLast2 = contents.lastIndexOf("\"");	// " <- 이 특수문자 없앨라고 선언
		
		String setTitile = contents.substring(4, idxLast);
		vo.setMemo_title(setTitile);
		
		String setContent = contents.substring(1,idxLast2);
		vo.setMemo_contents(setContent);
		
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
		
		String contents = vo.getMemo_contents();
		System.out.println("vo: "+vo);
		
		int idxLast = contents.indexOf("</p>"); 	// 내용에서 제목추출하기위해 </p>까지 추출할라고 선언
		int idxLast2 = contents.lastIndexOf("\"");	// " <- 이 특수문자 없앨라고 선언
		
		String setTitile = contents.substring(4, idxLast);
		vo.setMemo_title(setTitile);
		
		String setContent = contents.substring(1,idxLast2);
		vo.setMemo_contents(setContent);
		
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
	public int listCountCriteria() throws Exception {
		return dao.countPaging();
	}

	@Override
	public List<MemojangVO> listCriteria(Map<String, String> searchParam) {
		return dao.listCriteria(searchParam);
	}

	@Override
	public void bookmarkAdd(BookmarkVO vo) throws Exception {
		dao.bookmarkAdd(vo);
	}

	@Override
	public void bookmarkDelete(BookmarkVO vo) throws Exception {
		dao.bookmarkDelete(vo);
	}

	@Override
	public int countBookPaging() throws Exception {
		return dao.countBookPaging();
	}

	@Override
	public List<MemojangVO> listBookCriteria(Map<String, String> searchParam) {
		return dao.listBookCriteria(searchParam);
	}

	@Override
	public int getMemoLike(BookmarkVO vo) throws Exception {
		return dao.getMemoLike(vo);
	}

}
