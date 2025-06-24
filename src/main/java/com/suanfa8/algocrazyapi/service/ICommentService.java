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

    /**
     * 获取指定评论的回复列表
     *
     * @param commentId
     * @return
     */
    List<Comment> getRepliesByCommentId(Integer commentId);

    /**
     * 更新评论的回复数量
     * @param commentId
     * @param increment
     * @return
     */
    boolean updateReplyCount(Integer commentId, int increment);

    /**
     * 分页显示评论列表，按评论创建时间倒序排列
     * @param pageNum 页码
     * @param pageSize 每页数量
     * @return 分页后的评论列表
     */
    IPage<Comment> listComments(Integer pageNum, Integer pageSize);

}