package com.suanfa8.algocrazyapi.service;

import com.suanfa8.algocrazyapi.dto.article.ArticleLikeInfoDto;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.ArticleLikeRecord;

import java.util.List;

public interface IArticleLikeRecordService extends IService<ArticleLikeRecord> {

    // 已有方法
    boolean hasUserLikedArticle(Long userId, Integer articleId);

    // 新增方法
    List<ArticleLikeInfoDto> getLikedArticlesByUserId(Long userId);

}