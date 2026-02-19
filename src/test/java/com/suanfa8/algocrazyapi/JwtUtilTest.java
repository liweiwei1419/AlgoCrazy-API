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
    public void testExtractClaims() {
        // 过期的 jwt 不能通过测试
        String token = "eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX0FETUlOIn1dLCJ1c2VyX2lkIjoiMTU3NTQwNjk0OTc5ODAyNzI2NSIsInJvbGVfaWQiOjEsIm5pY2tuYW1lIjoi5p2O5aiB5aiB5ZCM5a2mIiwiYXZhdGFyIjoiaHR0cHM6Ly9jcmF6eS1zdGF0aWMuc3VhbmZhOC5jb20vYWxnby1jcmF6eS9hdmF0YXJzL2xpd2VpLmpwZWciLCJlbWFpbCI6IjEyMTA4ODgyNUBxcS5jb20iLCJ1c2VybmFtZSI6Imxpd2Vpd2VpMTQxOSIsInN1YiI6Imxpd2Vpd2VpMTQxOSIsImlhdCI6MTc3MDYyMjYyNywiZXhwIjoxNzcwNjI2MjI3fQ.hBa9gHO5FT8UvtJhyzTgaaiLXl7T89Ej9lasF5gRKVx3zgdMjsQtCOYIftcAjLhLpDeltQGdGNKg1W_1OHdZSw";
        Claims claims = jwtUtil.extractClaims(token);
        System.out.println(claims);
    }

}

