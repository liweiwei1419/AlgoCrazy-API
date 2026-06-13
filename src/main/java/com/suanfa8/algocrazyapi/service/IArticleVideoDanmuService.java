package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.ArticleVideoDanmu;

import java.util.List;

public interface IArticleVideoDanmuService extends IService<ArticleVideoDanmu> {

    List<ArticleVideoDanmu> getByArticleVideoId(Integer articleVideoId);
}
