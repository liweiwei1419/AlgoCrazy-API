package com.suanfa8.algocrazyapi;


import com.suanfa8.algocrazyapi.utils.JwtUtil;
import io.jsonwebtoken.Claims;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class JwtUtilTest {

    @Resource
    private JwtUtil jwtUtil;

    @Test
    public void test01(){
        String token = "eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX1VTRVIifV0sInVzZXJfaWQiOjE5MzYxMDQ5MDgwNjE0OTUyOTcsInJvbGVfaWQiOjAsIm5pY2tuYW1lIjoiZ3VhbmciLCJlbWFpbCI6Inpob3VndWFuZ0AxNjMuY29tIiwic3ViIjoiemhvdWd1YW5nIiwiaWF0IjoxNzUwNDk4NzU4LCJleHAiOjE3NTA1MDIzNTh9.XMw4uWcWzxdxPsRUEI3gL5KOfHpDf3Z-GqtWgX150_q5wbnf832mxjLGkEFDvm6U4D18v335dc4Yz2sEnMEj-w";
        Claims claims = jwtUtil.extractClaims(token);
        System.out.println(claims);
    }
}

