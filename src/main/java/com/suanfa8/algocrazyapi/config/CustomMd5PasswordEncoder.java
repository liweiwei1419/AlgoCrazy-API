package com.suanfa8.algocrazyapi.config;

import org.springframework.security.crypto.password.PasswordEncoder;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class CustomMd5PasswordEncoder implements PasswordEncoder {

    private final int hashIterations;

    public CustomMd5PasswordEncoder(int hashIterations) {
        this.hashIterations = hashIterations;
    }

    @Override
    public String encode(CharSequence rawPassword) {
        // System.out.println(rawPassword);
        // 对于没有 salt 的情况，直接返回原始密码（或者可以抛出异常）
        return rawPassword.toString();
    }

    /**
     * 原始密码和加密后的密码进行比较
     * @param rawPassword 原始密码
     * @param encodedPassword 加密以后的密码
     * @return
     */
    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        // 解析salt和密码
        String[] parts = rawPassword.toString().split("@@@@@@");
        if (parts.length != 2) {
            return false;
        }
        String salt = parts[0];
        String password = parts[1];
        // 计算加密后的密码
        String hashedPassword = passwordEncrypt(password, salt);
        // 比较结果
        return hashedPassword.equals(encodedPassword);
    }

    public String passwordEncrypt(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            if (salt != null) {
                md.update(salt.getBytes(StandardCharsets.UTF_8));
            }
            byte[] hashedPassword = md.digest(password.getBytes(StandardCharsets.UTF_8));
            for (int i = 1; i < hashIterations; i++) {
                hashedPassword = md.digest(hashedPassword);
            }
            return toHexString(hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 hashing algorithm not found", e);
        }
    }

    private String toHexString(byte[] bytes) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : bytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }

}