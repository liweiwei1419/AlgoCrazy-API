package com.suanfa8.algocrazyapi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
public class JwtRedisService {

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    public void saveJwt(String username, String jwt) {
        redisTemplate.opsForValue().set(username, jwt, 24, TimeUnit.HOURS);
    }

    public boolean validateJwt(String username, String jwt) {
        String storedJwt = redisTemplate.opsForValue().get(username);
        return jwt.equals(storedJwt);
    }

    public void deleteJwt(String username) {
        redisTemplate.delete(username);
    }
}
