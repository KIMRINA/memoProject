package com.memo.dto;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;


@SuppressWarnings("serial")
public class MemberDTO implements UserDetails {
	private int mem_no;
	private String mem_name;
	private String mem_type;
	private String mem_access_token;
	private String mem_phone;
	private String mem_gender;
	
	private String username;
    private String password;
    private String authorities;
    private boolean isEnabled;
    private boolean isAccountNonExpired;
    private boolean isAccountNonLocked;
    private boolean isCredentialsNonExpired;
    
    private String pwCheck;
    
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
        auth.add(new SimpleGrantedAuthority(authorities));
        return auth;
	}
	@Override
	public String getPassword() {
		return password;
	}
	@Override
	public String getUsername() {
		return username;
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	@Override
	public boolean isEnabled() {
		return isEnabled;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setAccountNonExpired(boolean isAccountNonExpired) {
		this.isAccountNonExpired = isAccountNonExpired;
	}
	public void setAccountNonLocked(boolean isAccountNonLocked) {
		this.isAccountNonLocked = isAccountNonLocked;
	}
	public void setCredentialsNonExpired(boolean isCredentialsNonExpired) {
		this.isCredentialsNonExpired = isCredentialsNonExpired;
	}
	public void setEnabled(boolean isEnabled) {
		this.isEnabled = isEnabled;
	}
	public void setAuthorities(String authorities) {
		this.authorities = authorities;
	}
	@Override
	public String toString() {
		return "MemberDTO [mem_no=" + mem_no + ", mem_name=" + mem_name + ", mem_type=" + mem_type
				+ ", mem_access_token=" + mem_access_token + ", mem_phone=" + mem_phone + ", mem_gender=" + mem_gender
				+ ", username=" + username + ", password=" + password + ", authorities=" + authorities + ", isEnabled="
				+ isEnabled + ", isAccountNonExpired=" + isAccountNonExpired + ", isAccountNonLocked="
				+ isAccountNonLocked + ", isCredentialsNonExpired=" + isCredentialsNonExpired + "]";
	}
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_type() {
		return mem_type;
	}
	public void setMem_type(String mem_type) {
		this.mem_type = mem_type;
	}
	public String getMem_access_token() {
		return mem_access_token;
	}
	public void setMem_access_token(String mem_access_token) {
		this.mem_access_token = mem_access_token;
	}
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getMem_gender() {
		return mem_gender;
	}
	public void setMem_gender(String mem_gender) {
		this.mem_gender = mem_gender;
	}
	
	public boolean passwordCheck() {
        return password.equals(pwCheck);
    }
	public String getPwCheck() {
		return pwCheck;
	}
	public void setPwCheck(String pwCheck) {
		this.pwCheck = pwCheck;
	}
	
}
