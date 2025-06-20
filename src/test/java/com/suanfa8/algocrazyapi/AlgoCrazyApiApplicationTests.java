package com.suanfa8.algocrazyapi;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import com.suanfa8.algocrazyapi.mapper.UserMapper;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class AlgoCrazyApiApplicationTests {

    @Resource
    private UserMapper userMapper;

    @Resource
    private ArticleMapper articleMapper;

    @Test
    void contextLoads() {
        String username = "liweiwei1419";
        User user = userMapper.selectOne(new QueryWrapper<User>().eq("username", username));
        System.out.println(user);
    }

    @Test
    public void test(){
        // 构建查询条件，查询 content 字段包含 ::open 的记录
        QueryWrapper<Article> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("content", "::open");
        List<Article> articles = articleMapper.selectList(queryWrapper);
        System.out.println(articles.size());

        for (Article article : articles) {
            String content = article.getContent();
            if (content != null) {
                // 使用正则表达式匹配 ```java 行中的 ::open 并替换为空
                content = content.replaceAll("(?m)^```java\\s*::open", "```java");
                article.setContent(content);
                // 更新记录，我只更改 content 字段，其他字段保持不变，用 Wapper 是不是好点
                articleMapper.updateById(article);
            }
        }
    }



}
