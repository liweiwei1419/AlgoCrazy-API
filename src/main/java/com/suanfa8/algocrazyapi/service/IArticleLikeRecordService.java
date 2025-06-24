package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.ArticleLikeRecord;

public interface IArticleLikeRecordService extends IService<ArticleLikeRecord> {

    /**
     * 检查用户是否已对文章点赞
     * @param userId 用户 ID
     * @param articleId 文章 ID
     * @return 已点赞返回 true，未点赞返回 false
     */
    boolean hasUserLikedArticle(Long userId, Integer articleId);

}