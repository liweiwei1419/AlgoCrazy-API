package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.Comment;

import java.util.List;

public interface ICommentService extends IService<Comment> {

    List<Comment> getCommentsByArticleId(Integer articleId);

    Comment addComment(Comment comment);

    boolean incrementLikeCount(Integer id);

    boolean deleteComment(Integer id);

    boolean updateComment(Comment comment);

    // 获取指定评论的回复列表
    List<Comment> getRepliesByCommentId(Integer commentId);

    // 更新评论的回复数量
    boolean updateReplyCount(Integer commentId, int increment);
}