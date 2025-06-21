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
}