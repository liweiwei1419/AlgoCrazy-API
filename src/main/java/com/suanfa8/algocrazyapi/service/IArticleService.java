package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.Article;

public interface IArticleService extends IService<Article> {

    Page<Article> selectPage(int curPage, int pageSize);

}
