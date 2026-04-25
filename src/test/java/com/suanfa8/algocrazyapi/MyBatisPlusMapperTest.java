package com.suanfa8.algocrazyapi;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.entity.LeetCodeProblems;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import com.suanfa8.algocrazyapi.mapper.LeetCodeProblemsMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;

import java.util.List;

// @Profile("local")
@SpringBootTest
public class MyBatisPlusMapperTest {

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private LeetCodeProblemsMapper leetCodeProblemsMapper;

    @Test
    public void testSelect() {
        System.out.println("hello world");
        List<Article> articles = articleMapper.selectList(null);
        System.out.println(articles.size());
    }

    @Test
    public void testInsert() {
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

    @Test
    public void testUpdate() {
        Article article = new Article();
        article.setId(1);
        article.setTitle("测试修改");
        article.setContent("测试");

        int insert = articleMapper.updateById(article);
        System.out.println(insert);
    }

    @Test
    public void testUpdateById() {
        List<LeetCodeProblems> leetCodeProblems = leetCodeProblemsMapper.selectList(null);
        for (LeetCodeProblems leetCodeProblem : leetCodeProblems) {
            Integer id = leetCodeProblem.getId();
            leetCodeProblemsMapper.update(new LambdaUpdateWrapper<LeetCodeProblems>().set(LeetCodeProblems::getLeetcodeNumber, id)  // id 是您要设置的编号值
                    .eq(LeetCodeProblems::getId, id));  // 这里的 id 是查询条件的值
        }
    }

}
