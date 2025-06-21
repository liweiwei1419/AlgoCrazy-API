package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.Comment;

import java.util.List;

public interface ICommentService extends IService<Comment> {

    List<Comment> getCommentsByArticleId(Integer articleId);

    Comment addComment(Comment comment);

    boolean incrementLikeCount(Long id);

    boolean deleteComment(Long id);

    boolean updateComment(Comment comment);

    // 获取指定评论的回复列表
    List<Comment> getRepliesByCommentId(Long commentId);

    // 更新评论的回复数量
    boolean updateReplyCount(Long commentId, int increment);
}