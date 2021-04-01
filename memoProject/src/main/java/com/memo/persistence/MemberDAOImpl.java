package com.memo.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Repository;

import com.memo.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.memo.mappers.MemberMapper";

	@Override
	public MemberDTO readUser(String username) {
		return session.selectOne(namespace + ".readUser", username);
	}
	
	@Override
	public String readAuth(String auth) {
		return session.selectOne(namespace + ".readAuth", auth);
	}

	@Override
	public List<GrantedAuthority> readAuthority(String username) {
		return session.selectList(namespace + ".readAuthority");
	}

	@Override
	public void createUser(MemberDTO member) {
		session.insert(namespace + ".createUser", member);
	}

	@Override
	public void createAuthority(MemberDTO member) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteUser(String username) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteAuthority(String username) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int userNameCheck(String username) throws Exception {
		return session.selectOne(namespace+"usersNameCheck", username);
	}


}