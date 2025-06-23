package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.Article;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

public interface IArticleService extends IService<Article> {

    int articleCreate(Article article);

    Page<Article> selectPage(int curPage, int pageSize);

    List<Article> getTitleAndIdSelect();

    int update(Article article);

    Article queryByUrl(String url);

    boolean incrementLikeCount(Long id);

    ResponseEntity<InputStreamResource> downloadArticleAsMarkdown(Article article);

    Map<Integer, Article> getArticleMapByIds(List<Integer> articleIds);

}

