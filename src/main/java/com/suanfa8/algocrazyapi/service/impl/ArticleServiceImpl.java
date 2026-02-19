package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.entity.ArticleLikeRecord;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import com.suanfa8.algocrazyapi.service.IArticleLikeRecordService;
import com.suanfa8.algocrazyapi.service.IArticleService;
import jakarta.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements IArticleService {

    @Resource
    private ArticleMapper articleMapper;

    @Resource
    private IArticleLikeRecordService articleLikeRecordService;

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
        return articleMapper.selectOne(new LambdaQueryWrapper<Article>().eq(Article::getUrl, url));
    }

    /**
     * 如果 article 有 sourceUrl，自动生成并设置 url
     *
     * @param article
     */
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
            // 将字符串转为整数，再格式化为 4 位，不足前面补 0
            try {
                int number = Integer.parseInt(numberStr);
                // 格式化为 4 位，不足补 0
                return String.format("%04d", number);
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

    @Override
    public ResponseEntity<InputStreamResource> downloadArticleAsMarkdown(Article article) {
        if (article == null || article.getContent() == null) {
            throw new IllegalArgumentException("Article or content cannot be null");
        }

        // 获取文件名，使用 url 字段作为基础
        String filename = StringUtils.isNotBlank(article.getUrl()) ? article.getUrl() + ".md" : "article_" + article.getId() + ".md";
        // 将内容转换为字节数组
        byte[] contentBytes = article.getContent().getBytes(StandardCharsets.UTF_8);
        // 创建输入流
        InputStream inputStream = new ByteArrayInputStream(contentBytes);
        // 设置响应头
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename);
        headers.add(HttpHeaders.CACHE_CONTROL, "no-cache, no-store, must-revalidate");
        headers.add(HttpHeaders.PRAGMA, "no-cache");
        headers.add(HttpHeaders.EXPIRES, "0");
        return ResponseEntity.ok().headers(headers).contentLength(contentBytes.length).contentType(MediaType.APPLICATION_OCTET_STREAM).body(new InputStreamResource(inputStream));
    }

    @Override
    public Map<Integer, Article> getArticleMapByIds(List<Integer> articleIds) {
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.select(Article::getId,Article::getTitle, Article::getUrl);
        queryWrapper.in(Article::getId, articleIds);
        List<Article> articles = articleMapper.selectList(queryWrapper);

        Map<Integer, Article> articleMap = new HashMap<>(articleIds.size());
        for (Article article : articles) {
            articleMap.put(article.getId(), article);
        }
        return articleMap;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean likeArticle(Long userId, Integer articleId) {
        if (articleLikeRecordService.hasUserLikedArticle(userId, articleId)) {
            return false;
        }
        LambdaUpdateWrapper<Article> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Article::getId, articleId).setSql("like_count = like_count + 1");
        boolean result = this.update(updateWrapper);
        if (result) {
            // 点赞成功，记录用户点赞信息
            ArticleLikeRecord record = new ArticleLikeRecord();
            record.setUserId(userId);
            record.setArticleId(articleId);
            articleLikeRecordService.save(record);
        }
        return result;
    }

}
