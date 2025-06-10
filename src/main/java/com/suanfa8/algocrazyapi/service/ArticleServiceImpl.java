package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import jakarta.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements IArticleService {

    @Resource
    private ArticleMapper articleMapper;

    @Override
    public int articleCreate(Article article) {
        generateAndSetArticleUrl(article);
        return articleMapper.insert(article);
    }


    @Override
    public int update(Article article) {
        generateAndSetArticleUrl(article);
        return articleMapper.updateById(article);
    }

    @Override
    public Article queryByUrl(String url) {
        LambdaQueryWrapper<Article> articleLambdaQueryWrapper = new LambdaQueryWrapper<Article>().eq(Article::getUrl, url);
        return articleMapper.selectOne(articleLambdaQueryWrapper);
    }


    // 如果 article 有 sourceUrl，自动生成并设置 url
    private void generateAndSetArticleUrl(Article article) {
        if (StringUtils.isNotBlank(article.getSourceUrl())) {
            String url = generateUrlFromSource(article.getSourceUrl(), article.getTitle());
            if (url != null) {
                article.setUrl(url);
            }
        }
    }


    private String generateUrlFromSource(String sourceUrl, String title) {
        try {
            // 1. 从 sourceUrl 提取 problems 和 description 之间的部分作为 b
            String b = extractMiddlePart(sourceUrl, "problems/", "/description");
            if (b == null) {
                b = extractMiddlePart(sourceUrl, "problems/", "/"); // 尝试另一种可能的格式
            }

            // 2. 从 title 提取「第 X 题」中的数字作为 a
            String a = extractNumberFromTitle(title);

            // 3. 组合成 a-b 格式
            if (a != null && b != null) {
                return a + "-" + b;
            }
        } catch (Exception e) {
            log.error("自动生成 URL 失败", e);
        }
        return null;
    }

    private String extractMiddlePart(String source, String prefix, String suffix) {
        int start = source.indexOf(prefix);
        if (start == -1) {
            return null;
        }
        start += prefix.length();

        int end = source.indexOf(suffix, start);
        if (end == -1) {
            return null;
        }
        return source.substring(start, end);
    }

    private String extractNumberFromTitle(String title) {
        // 匹配「第 X 题」或「第X题」等变体
        Pattern pattern = Pattern.compile("第\\s*(\\d+)\\s*题");
        Matcher matcher = pattern.matcher(title);
        if (matcher.find()) {
            String numberStr = matcher.group(1);
            // 将字符串转为整数，再格式化为4位，不足前面补0
            try {
                int number = Integer.parseInt(numberStr);
                return String.format("%04d", number); // 格式化为4位，不足补0
            } catch (NumberFormatException e) {
                log.error("提取的数字格式错误: " + numberStr, e);
                return null;
            }
        }
        return null;
    }


    @Override
    public Page<Article> selectPage(int curPage, int pageSize) {
        Page<Article> page = new Page<>(curPage, pageSize);
        return articleMapper.selectPage(page, null);
    }

    @Override
    public List<Article> getTitleAndIdSelect() {
        return articleMapper.getTitleAndIdSelect();
    }

}
