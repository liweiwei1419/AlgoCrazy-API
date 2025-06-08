package com.suanfa8.algocrazyapi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.suanfa8.algocrazyapi.entity.Article;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface ArticleMapper extends BaseMapper<Article> {

    @Select("SELECT * FROM articles WHERE url = #{url}")
    Article findByUrl(@Param("url") String url);

}