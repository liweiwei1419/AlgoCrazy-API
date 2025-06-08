package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

@Service
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements IArticleService{

    @Resource
    private ArticleMapper articleMapper;

    @Override
    public Page<Article> selectPage(int curPage, int pageSize) {
        Page<Article> page = new Page<>(curPage, pageSize);
        return articleMapper.selectPage(page, null);
    }

}
