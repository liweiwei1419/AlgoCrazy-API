package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.Comment;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.CommentMapper;
import com.suanfa8.algocrazyapi.utils.DingTalkGroupNotificationUtil;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Resource
    private CommentMapper commentsMapper;

    @Resource
    private DingTalkGroupNotificationUtil dingTalkGroupNotificationUtil;

    @Resource
    private IUserService userService; // 注入用户服务

    @Override
    public List<Comment> getCommentsByArticleId(Integer articleId) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getArticleId, articleId).isNull(Comment::getParentCommentId).orderByDesc(Comment::getCreatedAt);
        List<Comment> comments = commentsMapper.selectList(queryWrapper);
        // 调用公共方法填充用户信息
        fillUserInfoForComments(comments);
        return comments;
    }

    @Override
    public Comment addComment(Comment comment) {
        int insert = commentsMapper.insert(comment);
        String userNickname = comment.getUserNickname();
        Integer articleId = comment.getArticleId();
        if (insert > 0) {
            if (comment.getParentCommentId() != null) {
                // 如果是回复评论，更新父评论的回复数量
                updateReplyCount(comment.getParentCommentId(), 1);
                // 有新回复，发送通知
                dingTalkGroupNotificationUtil.sendNewReplyNotification(userNickname, articleId, comment.getContent());
            } else {
                // 有新评论，发送通知
                dingTalkGroupNotificationUtil.sendNewCommentNotification(userNickname, articleId, comment.getContent());
            }
            Long replyToUserId = comment.getReplyToUserId();
            if (replyToUserId!= null) {
                // 根据 replyToUserId 只查询用户名
                String replyToUserNickname = userService.getNicknameById(replyToUserId);
                if (replyToUserNickname!= null) {
                    comment.setReplyToUserNickname(replyToUserNickname);
                }
            }
            return comment;
        }
        return null;
    }

    /**
     * 为评论列表填充用户昵称、头像和回复用户昵称
     * @param comments 评论列表
     */
    private void fillUserInfoForComments(List<Comment> comments) {
        // 收集所有 userId 和 replyToUserId
        Set<Long> userIds = new HashSet<>();
        for (Comment comment : comments) {
            if (comment.getUserId() != null) {
                userIds.add(comment.getUserId());
            }
            if (comment.getReplyToUserId() != null) {
                userIds.add(comment.getReplyToUserId());
            }
        }

        // 一次性查询用户信息
        Map<Long, User> userMap = userService.getUserMapByIds(new ArrayList<>(userIds));

        // 设置用户昵称和头像
        for (Comment comment : comments) {
            if (comment.getUserId() != null) {
                User user = userMap.get(comment.getUserId());
                if (user != null) {
                    comment.setUserNickname(user.getNickname());
                    comment.setUserAvatar(user.getAvatar());
                }
            }
            if (comment.getReplyToUserId() != null) {
                User replyToUser = userMap.get(comment.getReplyToUserId());
                if (replyToUser != null) {
                    comment.setReplyToUserNickname(replyToUser.getNickname());
                }
            }
        }
    }

    @Override
    public boolean incrementLikeCount(Integer id) {
        return baseMapper.incrementLikeCount(id);
    }

    @Override
    public boolean deleteComment(Integer id) {
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
    public List<Comment> getRepliesByCommentId(Integer commentId) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getParentCommentId, commentId).orderByAsc(Comment::getCreatedAt);
        List<Comment> comments = commentsMapper.selectList(queryWrapper);
        fillUserInfoForComments(comments);
        return comments;
    }

    @Override
    public boolean updateReplyCount(Integer commentId, int increment) {
        LambdaUpdateWrapper<Comment> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Comment::getId, commentId).setSql("reply_count = reply_count + " + increment);
        return update(updateWrapper);
    }

    @Override
    public IPage<Comment> listComments( Integer pageNum, Integer pageSize) {
        // 设置默认页码和每页数量
        if (pageNum == null || pageNum < 1) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        // 创建 Page 对象
        Page<Comment> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        // 按评论创建时间倒序排列
        queryWrapper.orderByDesc(Comment::getCreatedAt);
        IPage<Comment> commentPage = this.page(page, queryWrapper);
        // 调用公共方法填充用户信息
        fillUserInfoForComments(commentPage.getRecords());
        return commentPage;
    }

}