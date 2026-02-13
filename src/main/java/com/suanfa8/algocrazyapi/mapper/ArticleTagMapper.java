package com.suanfa8.algocrazyapi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.suanfa8.algocrazyapi.entity.ArticleTag;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ArticleTagMapper extends BaseMapper<ArticleTag> {

    List<Integer> selectTagIdsByArticleId(@Param("articleId") Integer articleId);

    List<Integer> selectArticleIdsByTagId(@Param("tagId") Integer tagId);

    int deleteByArticleId(@Param("articleId") Integer articleId);

}