package com.suanfa8.algocrazyapi;


import com.suanfa8.algocrazyapi.dto.ArticleTreeNode;
import com.suanfa8.algocrazyapi.service.IArticleTreeService;
import jakarta.annotation.Resource;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.io.LineIterator;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class RedisTest {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    private String CACHE_KEY = "article:fullTree";
    private long CACHE_EXPIRE_HOURS = 1;

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
