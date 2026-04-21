package com.suanfa8.algocrazyapi;


import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class ReplaceTest {

    @Resource
    private ArticleMapper articleMapper;

    @Test
    void contextLoads() {
        List<Article> articles = articleMapper.selectList(null);
        System.out.println(articles);
        int updatedCount = 0;
        for (Article article : articles) {
            String content = article.getContent();
            if (content != null && content.contains("https://crazy-static.suanfa8.com")) {
                String newContent = content.replace("https://crazy-static.suanfa8.com", "https://static.suanfa8.com");
                // 创建更新包装器，明确指定更新条件
                LambdaUpdateWrapper<Article> updateWrapper = new LambdaUpdateWrapper<>();
                updateWrapper.eq(Article::getId, article.getId()) // 必须添加 ID 条件
                        .set(Article::getContent, newContent);

                // 执行更新
                int result = articleMapper.update(null, updateWrapper);
                if (result > 0) {
                    updatedCount++;
                    // 可选：更新内存中的对象，保持一致性
                    article.setContent(newContent);
                }
            }
        }
        System.out.println("成功更新 " + updatedCount + " 篇文章");
    }
    
}
