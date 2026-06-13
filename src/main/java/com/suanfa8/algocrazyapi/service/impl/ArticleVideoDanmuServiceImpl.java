package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.ArticleVideoDanmu;
import com.suanfa8.algocrazyapi.mapper.ArticleVideoDanmuMapper;
import com.suanfa8.algocrazyapi.service.IArticleVideoDanmuService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleVideoDanmuServiceImpl extends ServiceImpl<ArticleVideoDanmuMapper, ArticleVideoDanmu> implements IArticleVideoDanmuService {

    @Override
    public List<ArticleVideoDanmu> getByArticleVideoId(Integer articleVideoId) {
        LambdaQueryWrapper<ArticleVideoDanmu> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ArticleVideoDanmu::getArticleVideoId, articleVideoId)
                .eq(ArticleVideoDanmu::getIsDeleted, false)
                .orderByAsc(ArticleVideoDanmu::getTimeMs)
                .orderByAsc(ArticleVideoDanmu::getId);
        return list(queryWrapper);
    }
}
