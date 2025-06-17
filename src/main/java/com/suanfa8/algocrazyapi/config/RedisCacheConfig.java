package com.suanfa8.algocrazyapi.config;

import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.time.Duration;

@Configuration
@EnableCaching
public class RedisCacheConfig {

    @Bean
    public RedisCacheManager cacheManager(RedisConnectionFactory redisConnectionFactory) {
        // 默认缓存配置，设置 1 小时过期
        RedisCacheConfiguration defaultCacheConfig = RedisCacheConfiguration.defaultCacheConfig().entryTtl(Duration.ofHours(1)).serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(new StringRedisSerializer())).serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(new GenericJackson2JsonRedisSerializer()));

        // 为 articleTitleAndId 缓存设置 30 天过期时间
        RedisCacheConfiguration articleTitleAndIdCacheConfig = defaultCacheConfig.entryTtl(Duration.ofDays(30));

        return RedisCacheManager.builder(redisConnectionFactory).cacheDefaults(defaultCacheConfig).withInitialCacheConfigurations(java.util.Map.of("articleTitleAndId", articleTitleAndIdCacheConfig)).build();
    }

}