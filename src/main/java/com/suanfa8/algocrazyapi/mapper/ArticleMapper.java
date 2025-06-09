package com.suanfa8.algocrazyapi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.suanfa8.algocrazyapi.entity.Article;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface ArticleMapper extends BaseMapper<Article> {

    @Select("SELECT id, title, parent_id, is_folder FROM articles where is_deleted = false ORDER BY display_order ASC")
    List<Article> selectAllWithoutContent();

    @Select("SELECT * FROM articles WHERE url = #{url}")
    Article findByUrl(@Param("url") String url);

    // 获取某个结点的直接子结点
    @Select("SELECT * FROM articles WHERE parent_id = #{parentId} AND is_deleted = false ORDER BY display_order ASC")
    List<Article> selectChildren(@Param("parentId") Long parentId);

    // 获取子树的所有结点
    @Select("SELECT * FROM articles WHERE (path LIKE CONCAT(#{path}, ',%') OR path = #{path} OR id = #{id} ORDER BY path, display_order")
    List<Article> selectSubTree(@Param("id") Long id, @Param("path") String path);

    // 更新路径
    @Update("UPDATE articles SET path = #{newPath} WHERE path LIKE CONCAT(#{oldPath}, '%')")
    int updatePath(@Param("oldPath") String oldPath, @Param("newPath") String newPath);

}