package com.suanfa8.algocrazyapi;


import com.suanfa8.algocrazyapi.config.CustomMd5PasswordEncoder;
import org.junit.jupiter.api.Test;

public class PasswordTest {

    @Test
    public void testPasswordEncode() {
        CustomMd5PasswordEncoder customMd5PasswordEncoder = new CustomMd5PasswordEncoder(1024);
        String saltStr = "zhouguang";
        String password = "zhouguang666";
        // String encodedPassword = "00b55404d50be3bbede8d4194058e540";
        String encoded = customMd5PasswordEncoder.passwordEncrypt(password, saltStr);
        System.out.println(encoded);
        // System.out.println(encoded.equals(encodedPassword));
    }

}
