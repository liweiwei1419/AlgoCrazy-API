package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.dto.comment.CommentDeleteDto;
import com.suanfa8.algocrazyapi.dto.comment.CommentUpdateDto;
import com.suanfa8.algocrazyapi.entity.Comment;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public interface ICommentService extends IService<Comment> {

    List<Comment> getCommentsByArticleId(Integer articleId);

    Comment addComment(Comment comment);

    boolean incrementLikeCount(Integer id);

    boolean deleteComment(CommentDeleteDto commentDeleteDto);

    boolean updateComment(CommentUpdateDto commentUpdateDto);

    List<Comment> getRepliesByCommentId(Integer commentId);

    boolean updateReplyCount(Integer commentId, int increment);

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

    /**
     * 获取练习评论列表
     */
    List<Comment> getCommentsByExerciseId(Integer exerciseId);




}
