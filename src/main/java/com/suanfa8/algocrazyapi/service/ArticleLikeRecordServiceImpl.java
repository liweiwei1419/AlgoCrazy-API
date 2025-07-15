package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.dto.article.ArticleLikeInfoDto;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.entity.ArticleLikeRecord;
import com.suanfa8.algocrazyapi.mapper.ArticleLikeRecordMapper;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ArticleLikeRecordServiceImpl extends ServiceImpl<ArticleLikeRecordMapper, ArticleLikeRecord> implements IArticleLikeRecordService {


    @Resource
    private ArticleMapper articleMapper;

    @Override
    public boolean hasUserLikedArticle(Long userId, Integer articleId) {
        // SELECT COUNT(*) > 0 FROM user_like_record WHERE user_id = #{userId} AND article_id = #{articleId}
        LambdaQueryWrapper<ArticleLikeRecord> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ArticleLikeRecord::getUserId, userId).eq(ArticleLikeRecord::getArticleId, articleId);
        return count(queryWrapper) > 0;
    }

    @Override
    public List<ArticleLikeInfoDto> getLikedArticlesByUserId(Long userId) {
        LambdaQueryWrapper<ArticleLikeRecord> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ArticleLikeRecord::getUserId, userId);
        List<ArticleLikeRecord> likeRecords = list(queryWrapper);

        return likeRecords.stream().map(record -> {
            Article article = articleMapper.selectById(record.getArticleId());
            ArticleLikeInfoDto dto = new ArticleLikeInfoDto();
            dto.setArticleId(article.getId());
            dto.setUrl(article.getUrl());
            dto.setTitle(article.getTitle());
            dto.setCreatedAt(article.getCreatedAt());
            return dto;
        }).collect(Collectors.toList());
    }

}