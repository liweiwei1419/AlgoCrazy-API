package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.dto.comment.CommentDeleteDto;
import com.suanfa8.algocrazyapi.dto.comment.CommentUpdateDto;
import com.suanfa8.algocrazyapi.entity.Comment;

import java.util.List;

public interface ICommentService extends IService<Comment> {

    List<Comment> getCommentsByArticleId(Integer articleId);

    Comment addComment(Comment comment);

    boolean incrementLikeCount(Integer id);

    boolean deleteComment(CommentDeleteDto commentDeleteDto);

    boolean updateComment(CommentUpdateDto commentUpdateDto);

    List<Comment> getRepliesByCommentId(Integer commentId);

    boolean updateReplyCount(Integer commentId, int increment);

    IPage<Comment> listComments(Integer pageNum, Integer pageSize);

    /**
     * 根据目标类型和目标ID获取评论列表
     */
    List<Comment> getCommentsByTarget(String targetType, Integer targetId);

    /**
     * 获取练习评论列表
     */
    List<Comment> getCommentsByExerciseId(Integer exerciseId);

}
