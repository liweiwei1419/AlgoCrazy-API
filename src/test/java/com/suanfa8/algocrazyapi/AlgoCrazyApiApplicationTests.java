package com.suanfa8.algocrazyapi;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.suanfa8.algocrazyapi.dto.ArticleTreeNode;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import com.suanfa8.algocrazyapi.mapper.UserMapper;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.test.context.ActiveProfiles;

import java.util.List;

@ActiveProfiles("local")
@SpringBootTest
public class AlgoCrazyApiApplicationTests {

    @Resource
    private UserMapper userMapper;

    @Resource
    private ArticleMapper articleMapper;

    private final String CACHE_KEY = "article:fullTree";

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    // 测试数据库
    @Test
    void contextLoads() {
        String username = "liweiwei1419";
        User user = userMapper.selectOne(new QueryWrapper<User>().eq("username", username));
        System.out.println(user);
    }

    @Test
    public void test() {
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
                // 更新记录，注意，这里的更新是所有查询出来的字段都更新，不建议这么做
                articleMapper.updateById(article);
            }
        }
    }

    // 测试 redis
    @Test
    public void testRedis() {
        List<ArticleTreeNode> fullTree = (List<ArticleTreeNode>) redisTemplate.opsForValue().get(CACHE_KEY);
        System.out.println(fullTree.size());
    }

}
