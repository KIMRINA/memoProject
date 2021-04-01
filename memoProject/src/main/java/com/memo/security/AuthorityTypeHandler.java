package com.memo.security;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

/**
 * AuthorityTypeHandler class.
 * - MyBatis에서 제공하지 않는 리턴 타입을 구현하기 위한 클래스.
 * - 기본적으로 BaseTypeHandler을 상속받는다. Generic type은 'SimpleGrantedAuthority' -> 우리가 제공 받고 싶은 리턴 타입.
 * - 상속을 받으면 구현해야 하는 4가지 메소드가 있다.
 * - PreparedStatement에 파라미터를 어떻게 넣을 것인지, ResultSet에서 데이터는 어떻게 가져올 건지.
 * - 완성된 TypeHandler, MyBatis Config에 추가.
 */

@MappedJdbcTypes(JdbcType.VARCHAR)
public class AuthorityTypeHandler extends BaseTypeHandler<SimpleGrantedAuthority> {

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, SimpleGrantedAuthority parameter, JdbcType jdbcType)
			throws SQLException {
		ps.setString(i, parameter.getAuthority());
	}

	@Override
	public SimpleGrantedAuthority getNullableResult(ResultSet rs, String columnName) throws SQLException {
		return new SimpleGrantedAuthority(rs.getString(columnName));
	}

	@Override
	public SimpleGrantedAuthority getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		return new SimpleGrantedAuthority(rs.getString(columnIndex));
	}

	@Override
	public SimpleGrantedAuthority getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		return new SimpleGrantedAuthority(cs.getString(columnIndex));
	}

}
