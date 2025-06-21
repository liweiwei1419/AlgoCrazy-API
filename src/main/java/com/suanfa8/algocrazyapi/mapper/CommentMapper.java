package com.suanfa8.algocrazyapi.mapper;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.suanfa8.algocrazyapi.entity.Comment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommentMapper extends BaseMapper<Comment> {

    // List<Comment> getCommentsByArticleId(Integer articleId);

    default boolean incrementLikeCount(Integer id) {
        LambdaUpdateWrapper<Comment> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Comment::getId, id).setSql("like_count = like_count + 1");
        return update(updateWrapper) > 0;
    }

}