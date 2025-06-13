package com.suanfa8.algocrazyapi;


import org.junit.jupiter.api.Test;

public class PasswordTest {

    private CustomMd5PasswordEncoder customMd5PasswordEncoder = new CustomMd5PasswordEncoder(1024);

    @Test
    public void testMD5New() {
        String saltStr = "liweiwei1419";
        String password = "p@sSw0rdsf8";
        CustomMd5PasswordEncoder customMd5PasswordEncoder = new CustomMd5PasswordEncoder(1024);

        String encodedPassword = "017d41134acd4086c59d2e999b68671d";
        String encoded = customMd5PasswordEncoder.encode(password, saltStr);
        System.out.println(encoded);
        System.out.println(encoded.equals(encodedPassword));
    }
}
