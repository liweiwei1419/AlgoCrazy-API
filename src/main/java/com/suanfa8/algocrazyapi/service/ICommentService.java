package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.dto.comment.CommentDeleteDto;
import com.suanfa8.algocrazyapi.dto.comment.CommentUpdateDto;
import com.suanfa8.algocrazyapi.entity.Comment;
import com.suanfa8.algocrazyapi.entity.User;

import java.util.List;

public interface ICommentService extends IService<Comment> {

    List<Comment> getCommentsByArticleId(Integer articleId);

    Comment addComment(Comment comment, User currentUser);

    Comment addComment(Comment comment);

    boolean incrementLikeCount(Long id);

    boolean deleteComment(CommentDeleteDto commentDeleteDto, User currentUser);

    boolean deleteComment(CommentDeleteDto commentDeleteDto);

    boolean updateComment(CommentUpdateDto commentUpdateDto, User currentUser);

    boolean updateComment(CommentUpdateDto commentUpdateDto);

    List<Comment> getRepliesByCommentId(Long commentId);

    boolean updateReplyCount(Long commentId, int increment);

    /**
     * 分页显示评论列表，按评论创建时间倒序排列
     *
     * @param pageNum    页码
     * @param pageSize   每页数量
     * @param targetType 目标类型（可选）
     * @return 分页后的评论列表
     */
    IPage<Comment> listComments(Integer pageNum, Integer pageSize, String targetType);

    /**
     * 根据目标类型和目标ID获取评论列表
     */
    List<Comment> getCommentsByTarget(String targetType, Integer targetId);

    IPage<Comment> pageTopComments(String targetType, Long targetId, Integer pageNum, Integer pageSize);

    /**
     * 获取练习评论列表
     */
    List<Comment> getCommentsByExerciseId(Integer exerciseId);




}
