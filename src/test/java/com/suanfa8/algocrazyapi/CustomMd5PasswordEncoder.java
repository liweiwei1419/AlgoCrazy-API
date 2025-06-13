package com.suanfa8.algocrazyapi;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class CustomMd5PasswordEncoder {

    private final int hashIterations;

    public CustomMd5PasswordEncoder(int hashIterations) {
        this.hashIterations = hashIterations;
    }

    public String encode(String password, String salt) {
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