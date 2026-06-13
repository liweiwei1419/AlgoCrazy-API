package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.ArticleVideo;
import com.suanfa8.algocrazyapi.mapper.ArticleVideoMapper;
import com.suanfa8.algocrazyapi.service.IArticleVideoService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleVideoServiceImpl extends ServiceImpl<ArticleVideoMapper, ArticleVideo> implements IArticleVideoService {

    @Override
    public List<ArticleVideo> getByArticleId(Integer articleId, boolean publishedOnly) {
        LambdaQueryWrapper<ArticleVideo> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ArticleVideo::getArticleId, articleId)
                .eq(ArticleVideo::getIsDeleted, false)
                .orderByAsc(ArticleVideo::getSortOrder)
                .orderByAsc(ArticleVideo::getId);
        if (publishedOnly) {
            queryWrapper.eq(ArticleVideo::getIsPublished, true);
        }
        return list(queryWrapper);
    }

    @Override
    public boolean softDelete(Integer id) {
        ArticleVideo video = getById(id);
        if (video == null) {
            return false;
        }
        video.setIsDeleted(true);
        return updateById(video);
    }
}
