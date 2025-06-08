package com.suanfa8.algocrazyapi;

import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import org.checkerframework.checker.units.qual.A;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class MyBatisPlusMapperTest {

    @Autowired
    private ArticleMapper articleMapper;


    @Test
    public void testSelect(){
        System.out.println("hello world");
        List<Article> articles = articleMapper.selectList(null);
        System.out.println(articles.size());
    }

    @Test
    public void testInsert(){
        Article article = new Article();
        article.setAuthor("liweiwei1419");
        article.setTitle("「力扣」第 96 题：不同的二叉搜索树（中等）");
        article.setContent("测试");
        article.setCategory("动态规划");

//        List<String> tags = new ArrayList<>();
//        tags.add("动态规划");
//        tags.add("二叉搜索树");
//        article.setTags(tags);
        int insert = articleMapper.insert(article);
        System.out.println(insert);
    }

}
