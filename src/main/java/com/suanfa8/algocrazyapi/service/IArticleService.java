package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.Article;

import java.util.List;

public interface IArticleService extends IService<Article> {

    int articleCreate(Article article);

    Page<Article> selectPage(int curPage, int pageSize);

    List<Article> getTitleAndIdSelect();

    int update(Article article);

    Article queryByUrl(String url);

    boolean incrementLikeCount(Long id);

}
