package com.memo.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.GrantedAuthority;

import com.memo.domain.MemberVO;
import com.memo.dto.MemberDTO;

@Mapper
public interface MemberDAO {
	
	/*
     * security User -> security 접근 권한 정보를 담는 dto
     */
    public MemberDTO readUser(String username);
 
    /*
     * 이게 뭐냐면, 유저마다 권한이 1개 이상인 경우가 있을 수 있다는 가정에 만든 '권한 테이블'이고, 'username' 으로 검색을
     * 때리면 유저권한(USER_ROLE)이 주르륵 나온다 그래서 List<String> 타입으로 리턴 해줘야한다. 근데 이걸
     * GrantedAuthoriy 타입으로 받기 위해서 바꿔야한다. 왜냐하면 암호화 할 때 이 타입으로 리턴을 받을 수가 없다.
     * GrantedAuthoriy 타입으로 받기 위해서는 TypeHandler를 사용해야 한다. MyBatis에서 지원하지 않는 리턴
     * 타입이기 때문에.
     */
    // List<String> readAuthority(String username);
    public List<GrantedAuthority> readAuthority(String username);
    
    public String readAuth(String auth);
 
    public void createUser(MemberDTO member);
    
    public int userNameCheck(String username) throws Exception;
 
    public void createAuthority(MemberDTO member);
 
    public void deleteUser(String username);
 
    public void deleteAuthority(String username);


	// public MemberVO getUsersByID(String memEmail);

}
