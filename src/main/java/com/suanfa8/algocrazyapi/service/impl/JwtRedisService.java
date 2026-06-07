package com.suanfa8.algocrazyapi.service.impl;

import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
public class JwtRedisService {

    private static final String JWT_KEY_PREFIX = "jwt:";

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @Value("${jwt.expiration}")
    private long expiration;

    public void saveJwt(String username, String jwt) {
        String key = JWT_KEY_PREFIX + username;
        redisTemplate.opsForValue().set(key, jwt, expiration, TimeUnit.MILLISECONDS);
    }

    public boolean validateJwt(String username, String jwt) {
        String key = JWT_KEY_PREFIX + username;
        String storedJwt = redisTemplate.opsForValue().get(key);
        return jwt.equals(storedJwt);
    }

    public void deleteJwt(String username) {
        String key = JWT_KEY_PREFIX + username;
        redisTemplate.delete(key);
    }
}
