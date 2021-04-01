package com.memo.security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.security.crypto.password.PasswordEncoder;

public class SHA256Encryption implements PasswordEncoder {
	
	private static String encrypt(String str) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] passBytes = str.getBytes();
            md.reset();
 
            byte[] digested = md.digest(passBytes);
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < digested.length; ++i) {
                sb.append(Integer.toHexString(0xff & digested[i]));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            return str;
        }
    }

	
	 /*
     * 암호화된 문자열을 리턴.
     * @see org.springframework.security.crypto.password.PasswordEncoder#encode(java.lang.CharSequence)
     */
	@Override
	public String encode(CharSequence rawPassword) {
		String rawPasswordStr = (String) rawPassword;
        return encrypt(rawPasswordStr);
	}

	/*
     * 암호화 된 문자열과 암호화 되지 않은 문자열을 입력 받아, 암호화 되지 않은 문자열을 암호화 알고리즘을 통해 암호화 된 문자열을 만들고,
     * 파라미터로 받은 암호화 된 문자열과 equals 메소드로 비교한 후 결과를 리턴.
     * @see org.springframework.security.crypto.password.PasswordEncoder#matches(java.lang.CharSequence, java.lang.String)
     */
	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		String rawPasswordStr = (String) rawPassword;
        String encodePassword = encrypt(rawPasswordStr);
 
        return encodedPassword.equals(encodePassword);
	}

}
