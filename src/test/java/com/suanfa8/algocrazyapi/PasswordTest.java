package com.suanfa8.algocrazyapi;


import com.suanfa8.algocrazyapi.config.CustomMd5PasswordEncoder;
import org.junit.jupiter.api.Test;

public class PasswordTest {

//    String saltStr = "liweiwei1419";
//    String password = "p@sSw0rdsf8";
//    String encodedPassword = "017d41134acd4086c59d2e999b68671d";

    //    String saltStr = "liweiwei1419";
//    String password = "p@sSw0rdsf8";
//    String encodedPassword = "017d41134acd4086c59d2e999b68671d";



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

    // 00b55404d50be3bbede8d4194058e540

}
