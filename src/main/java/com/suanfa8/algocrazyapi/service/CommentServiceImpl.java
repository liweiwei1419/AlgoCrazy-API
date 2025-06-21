package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.Comment;
import com.suanfa8.algocrazyapi.mapper.CommentMapper;
import com.suanfa8.algocrazyapi.utils.DingTalkGroupNotificationUtil;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Resource
    private CommentMapper commentsMapper;

    @Resource
    private DingTalkGroupNotificationUtil dingTalkGroupNotificationUtil;

    @Override
    public List<Comment> getCommentsByArticleId(Integer articleId) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getArticleId, articleId).isNull(Comment::getParentCommentId).orderByDesc(Comment::getCreatedAt);
        return commentsMapper.selectList(queryWrapper);
    }

    @Override
    public Comment addComment(Comment comment) {
        int insert = commentsMapper.insert(comment);
        if (insert > 0) {
            // 如果是回复评论，更新父评论的回复数量
            if (comment.getParentCommentId() != null) {
                updateReplyCount(comment.getParentCommentId(), 1);
                // 有新回复，发送通知
                dingTalkGroupNotificationUtil.sendNewReplyNotification();
            }else {
                // 有新评论，发送通知
                dingTalkGroupNotificationUtil.sendNewCommentNotification();
            }
            return comment;
        }
        return null;
    }

    @Override
    public boolean incrementLikeCount(Long id) {
        return baseMapper.incrementLikeCount(id);
    }

    @Override
    public boolean deleteComment(Long id) {
        Comment comment = getById(id);
        if (comment != null && comment.getParentCommentId() != null) {
            // 如果是回复评论，减少父评论的回复数量
            updateReplyCount(comment.getParentCommentId(), -1);
        }
        return removeById(id);
    }

    @Override
    public boolean updateComment(Comment comment) {
        return updateById(comment);
    }

    @Override
    public List<Comment> getRepliesByCommentId(Long commentId) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getParentCommentId, commentId).orderByDesc(Comment::getCreatedAt);
        return commentsMapper.selectList(queryWrapper);
    }

    @Override
    public boolean updateReplyCount(Long commentId, int increment) {
        LambdaUpdateWrapper<Comment> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Comment::getId, commentId)
                .setSql("reply_count = reply_count + " + increment);
        return update(updateWrapper);
    }
}