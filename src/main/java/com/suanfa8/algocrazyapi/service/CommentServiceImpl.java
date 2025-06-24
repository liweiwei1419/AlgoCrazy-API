package com.suanfa8.algocrazyapi.service;

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
import com.suanfa8.algocrazyapi.utils.DingTalkGroupNotificationUtil;
import jakarta.annotation.Resource;
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

    @Resource
    private CommentMapper commentsMapper;

    @Resource
    private DingTalkGroupNotificationUtil dingTalkGroupNotificationUtil;

    /**
     * 注入用户服务
     */
    @Resource
    private IUserService userService;

    /**
     * 注入文章服务
     */
    @Resource
    private IArticleService articleService;

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
     *
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
    public boolean deleteComment(CommentDeleteDto commentDeleteDto) {
        // 情况 1：它的下面有回复
        // 查询谁的 parentCommentId 是它
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getParentCommentId, commentDeleteDto.getCommentId());
        List<Comment> comments = commentsMapper.selectList(queryWrapper);
        // 批量删除
        if (comments!= null &&!comments.isEmpty()) {
            List<Integer> commentIds = comments.stream().map(Comment::getId).collect(Collectors.toList());
            commentsMapper.deleteBatchIds(commentIds);
        }
        // 情况 2：它只是回复，需要把父评论的回复数 - 1
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
        // 调用带 entity 参数的 update 方法
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
        fillArticleInfoForComments(commentPage.getRecords());
        return commentPage;
    }


    private void fillArticleInfoForComments(List<Comment> comments) {
        // 收集所有的 articleId
        Set<Integer> articleIds = comments.stream().map(Comment::getArticleId).filter(Objects::nonNull).collect(Collectors.toCollection(HashSet::new));
        // 一次性查询用户信息
        Map<Integer, Article> articleMap = articleService.getArticleMapByIds(new ArrayList<>(articleIds));
        // 设置用户昵称和头像
        for (Comment comment : comments) {
            Article article = articleMap.get(comment.getArticleId());
            if (article != null) {
                comment.setArticleTitle(article.getTitle());
                comment.setArticleUrl(article.getUrl());
            }
        }

        System.out.println(comments);
    }

}