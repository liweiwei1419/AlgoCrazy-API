package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.dto.comment.CommentDeleteDto;
import com.suanfa8.algocrazyapi.dto.comment.CommentUpdateDto;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.entity.Comment;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.CommentMapper;
import com.suanfa8.algocrazyapi.service.IArticleService;
import com.suanfa8.algocrazyapi.service.ICommentService;
import com.suanfa8.algocrazyapi.service.IUserService;
import com.suanfa8.algocrazyapi.utils.DingTalkGroupNotificationUtil;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Autowired
    private CommentMapper commentsMapper;

    @Autowired
    private DingTalkGroupNotificationUtil dingTalkGroupNotificationUtil;

    /**
     * 注入用户服务
     */
    @Autowired
    private IUserService userService;

    /**
     * 注入文章服务
     */
    @Resource
    private IArticleService articleService;

    /**
     * 目标类型常量
     */
    private static final String TARGET_TYPE_ARTICLE = "ARTICLE";
    private static final String TARGET_TYPE_EXERCISE = "EXERCISE";

    @Override
    public List<Comment> getCommentsByArticleId(Integer articleId) {
        return getCommentsByTarget(TARGET_TYPE_ARTICLE, articleId);
    }

    /**
     * 根据目标类型和目标ID获取评论列表
     */
    public List<Comment> getCommentsByTarget(String targetType, Integer targetId) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getTargetType, targetType)
                   .eq(Comment::getTargetId, targetId)
                   .isNull(Comment::getParentCommentId)
                   .orderByDesc(Comment::getCreatedAt);
        List<Comment> comments = commentsMapper.selectList(queryWrapper);
        fillUserInfoForComments(comments);
        fillTargetInfoForComments(comments, targetType);
        return comments;
    }

    /**
     * 获取练习评论列表
     */
    public List<Comment> getCommentsByExerciseId(Integer exerciseId) {
        return getCommentsByTarget(TARGET_TYPE_EXERCISE, exerciseId);
    }

    @Override
    public Comment addComment(Comment comment) {
        int insert = commentsMapper.insert(comment);
        String userNickname = comment.getUserNickname();
        Integer targetId = comment.getTargetId();
        if (insert > 0) {
            if (comment.getParentCommentId() != null) {
                // 如果是回复评论，更新父评论的回复数量
                updateReplyCount(comment.getParentCommentId(), 1);
                // 有新回复，发送通知
                dingTalkGroupNotificationUtil.sendNewReplyNotification(userNickname, targetId, comment.getContent());
            } else {
                // 有新评论，发送通知
                dingTalkGroupNotificationUtil.sendNewCommentNotification(userNickname, targetId, comment.getContent());
            }
            Long replyToUserId = comment.getReplyToUserId();
            if (replyToUserId != null) {
                // 根据 replyToUserId 只查询用户名
                String replyToUserNickname = userService.getNicknameById(replyToUserId);
                if (replyToUserNickname != null) {
                    comment.setReplyToUserNickname(replyToUserNickname);
                }
            }
            return comment;
        }
        return null;
    }

    /**
     * 为评论列表填充用户昵称、头像和回复用户昵称
     */
    private void fillUserInfoForComments(List<Comment> comments) {
        Set<Long> userIds = new HashSet<>();
        for (Comment comment : comments) {
            if (comment.getUserId() != null) {
                userIds.add(comment.getUserId());
            }
            if (comment.getReplyToUserId() != null) {
                userIds.add(comment.getReplyToUserId());
            }
        }

        Map<Long, User> userMap = userService.getUserMapByIds(new ArrayList<>(userIds));

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

    /**
     * 为评论列表填充目标信息
     */
    private void fillTargetInfoForComments(List<Comment> comments, String targetType) {
        if (comments == null || comments.isEmpty()) {
            return;
        }

        Set<Integer> targetIds = comments.stream()
                .map(Comment::getTargetId)
                .filter(Objects::nonNull)
                .collect(Collectors.toCollection(HashSet::new));

        if (TARGET_TYPE_ARTICLE.equals(targetType)) {
            Map<Integer, Article> articleMap = articleService.getArticleMapByIds(new ArrayList<>(targetIds));
            for (Comment comment : comments) {
                Article article = articleMap.get(comment.getTargetId());
                if (article != null) {
                    comment.setTargetTitle(article.getTitle());
                    comment.setTargetUrl(article.getUrl());
                }
            }
        } else if (TARGET_TYPE_EXERCISE.equals(targetType)) {
            // TODO: 当练习模块实现后，添加练习信息填充逻辑
        }
    }

    @Override
    public boolean incrementLikeCount(Integer id) {
        return baseMapper.incrementLikeCount(id);
    }

    @Override
    public boolean deleteComment(CommentDeleteDto commentDeleteDto) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getParentCommentId, commentDeleteDto.getCommentId());
        List<Comment> comments = commentsMapper.selectList(queryWrapper);
        if (comments != null && !comments.isEmpty()) {
            List<Integer> commentIds = comments.stream().map(Comment::getId).collect(Collectors.toList());
            commentsMapper.deleteBatchIds(commentIds);
        }
        if (commentDeleteDto.getParentCommentId() != null) {
            updateReplyCount(commentDeleteDto.getParentCommentId(), -1);
        }
        return removeById(commentDeleteDto.getCommentId());
    }

    @Override
    public boolean updateComment(CommentUpdateDto commentUpdateDto) {
        LambdaUpdateWrapper<Comment> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Comment::getId, commentUpdateDto.getCommentId());
        updateWrapper.set(Comment::getContent, commentUpdateDto.getContent());
        updateWrapper.set(true, Comment::getUpdatedAt, LocalDateTime.now());
        return this.update(updateWrapper);
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
        updateWrapper.set(true, Comment::getUpdatedAt, LocalDateTime.now());
        return update(updateWrapper);
    }

    @Override
    public IPage<Comment> listComments(Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageNum < 1) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        Page<Comment> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.orderByDesc(Comment::getCreatedAt);
        IPage<Comment> commentPage = this.page(page, queryWrapper);
        fillUserInfoForComments(commentPage.getRecords());
        // 填充目标信息（简化处理）
        for (Comment comment : commentPage.getRecords()) {
            fillTargetInfoForComments(List.of(comment), comment.getTargetType());
        }
        return commentPage;
    }

}
