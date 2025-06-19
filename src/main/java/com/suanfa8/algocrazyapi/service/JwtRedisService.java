package com.suanfa8.algocrazyapi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
public class JwtRedisService {

    private static final String JWT_KEY_PREFIX = "jwt:";

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    public void saveJwt(String username, String jwt) {
        String key = JWT_KEY_PREFIX + username;
        redisTemplate.opsForValue().set(key, jwt, 24, TimeUnit.HOURS);
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