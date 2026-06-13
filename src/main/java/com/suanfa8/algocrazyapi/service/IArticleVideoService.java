package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.ArticleVideo;

import java.util.List;

public interface IArticleVideoService extends IService<ArticleVideo> {

    List<ArticleVideo> getByArticleId(Integer articleId, boolean publishedOnly);

    boolean softDelete(Integer id);
}
