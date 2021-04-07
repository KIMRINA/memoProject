package com.memo.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.memo.persistence.CommonDAO;

@Service
public class CommonServiceImpl implements CommonService {
	
	@Inject
	private CommonDAO dao;

	@Override
	public int selectCompareTime(String time) {
		return dao.selectCompareTime(time);
	}

}
