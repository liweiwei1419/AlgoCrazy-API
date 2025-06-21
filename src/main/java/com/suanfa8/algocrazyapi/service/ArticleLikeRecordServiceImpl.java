package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.ArticleLikeRecord;
import com.suanfa8.algocrazyapi.mapper.ArticleLikeRecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleLikeRecordServiceImpl extends ServiceImpl<ArticleLikeRecordMapper, ArticleLikeRecord> implements IArticleLikeRecordService {

    @Autowired
    private ArticleLikeRecordMapper articleLikeRecordMapper;

    @Override
    public boolean likeArticle(Long userId, Long articleId) {
        if (hasLiked(userId, articleId)) {
            return false;
        }
        ArticleLikeRecord record = new ArticleLikeRecord();
        record.setUserId(userId);
        record.setArticleId(articleId);
        return save(record);
    }

    @Override
    public boolean hasLiked(Long userId, Long articleId) {
        LambdaQueryWrapper<ArticleLikeRecord> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ArticleLikeRecord::getUserId, userId)
                    .eq(ArticleLikeRecord::getArticleId, articleId);
        return count(queryWrapper) > 0;
    }
}