package com.suanfa8.algocrazyapi;


import com.suanfa8.algocrazyapi.dto.ArticleTreeNode;
import com.suanfa8.algocrazyapi.service.IArticleTreeService;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;

import java.util.List;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class RedisTest {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    private final String CACHE_KEY = "article:fullTree";

    private final long CACHE_EXPIRE_HOURS = 1;

    @Resource
    private IArticleTreeService articleTreeService;

    @Test
    public void testSet() {
        List<ArticleTreeNode> fullTree = articleTreeService.getFullTree();
        redisTemplate.opsForValue().set(CACHE_KEY, fullTree, CACHE_EXPIRE_HOURS, TimeUnit.HOURS);
    }

    @Test
    public void testGet() {
        List<ArticleTreeNode> fullTree = (List<ArticleTreeNode>) redisTemplate.opsForValue().get(CACHE_KEY);
        System.out.println(fullTree.size());
    }

}
