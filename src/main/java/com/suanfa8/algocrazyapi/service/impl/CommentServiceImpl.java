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
import com.suanfa8.algocrazyapi.entity.CommentTargetType;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.CommentMapper;
import com.suanfa8.algocrazyapi.service.IArticleService;
import com.suanfa8.algocrazyapi.service.ICommentService;
import com.suanfa8.algocrazyapi.service.IExerciseSolutionService;
import com.suanfa8.algocrazyapi.utils.NotificationStrategy;
import com.suanfa8.algocrazyapi.utils.NotificationStrategyFactory;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    private static final String AUTHOR_TYPE_USER = "USER";
    private static final String AUTHOR_TYPE_GUEST = "GUEST";
    private static final String STATUS_VISIBLE = "VISIBLE";
    private static final String STATUS_DELETED = "DELETED";
    private static final String DEFAULT_GUEST_NAME = "匿名用户";

    @Resource
    private IArticleService articleService;

    @Resource
    private IExerciseSolutionService exerciseSolutionService;

    @Resource
    private NotificationStrategyFactory notificationStrategyFactory;

    @Override
    public List<Comment> getCommentsByArticleId(Integer articleId) {
        return getCommentsByTarget(CommentTargetType.ARTICLE.getCode(), articleId);
    }

    @Override
    public List<Comment> getCommentsByTarget(String targetType, Integer targetId) {
        return pageTopComments(targetType, targetId.longValue(), 1, 100).getRecords();
    }

    @Override
    public IPage<Comment> pageTopComments(String targetType, Long targetId, Integer pageNum, Integer pageSize) {
        validateTarget(targetType, targetId);
        Page<Comment> page = new Page<>(normalizePageNum(pageNum), normalizePageSize(pageSize));
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getTargetType, targetType)
                .eq(Comment::getTargetId, targetId)
                .isNull(Comment::getParentId)
                .eq(Comment::getStatus, STATUS_VISIBLE)
                .orderByDesc(Comment::getCreatedAt);
        IPage<Comment> commentPage = page(page, queryWrapper);
        fillTargetInfoForComments(commentPage.getRecords());
        return commentPage;
    }

    @Override
    public List<Comment> getCommentsByExerciseId(Integer exerciseId) {
        return getCommentsByTarget(CommentTargetType.EXERCISE.getCode(), exerciseId);
    }

    @Override
    public Comment addComment(Comment comment) {
        return addComment(comment, null);
    }

    @Override
    public Comment addComment(Comment comment, User currentUser) {
        normalizeNewComment(comment, currentUser);
        save(comment);

        if (comment.getParentId() != null) {
            updateReplyCount(comment.getParentId(), 1);
        }

        sendNewCommentNotification(comment);
        return comment;
    }

    @Override
    public boolean incrementLikeCount(Long id) {
        LambdaUpdateWrapper<Comment> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Comment::getId, id)
                .eq(Comment::getStatus, STATUS_VISIBLE)
                .setSql("like_count = like_count + 1")
                .set(Comment::getUpdatedAt, LocalDateTime.now());
        return update(updateWrapper);
    }

    @Override
    public boolean deleteComment(CommentDeleteDto commentDeleteDto) {
        return deleteComment(commentDeleteDto, null);
    }

    @Override
    public boolean deleteComment(CommentDeleteDto commentDeleteDto, User currentUser) {
        Comment comment = getVisibleComment(commentDeleteDto.getCommentId());
        requireOwnerOrAdmin(comment, currentUser);

        LocalDateTime now = LocalDateTime.now();
        LambdaUpdateWrapper<Comment> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Comment::getId, comment.getId())
                .or(wrapper -> wrapper.eq(Comment::getParentId, comment.getId()))
                .set(Comment::getStatus, STATUS_DELETED)
                .set(Comment::getDeletedAt, now)
                .set(Comment::getUpdatedAt, now);
        boolean deleted = update(updateWrapper);

        if (deleted && comment.getParentId() != null) {
            updateReplyCount(comment.getParentId(), -1);
        }
        return deleted;
    }

    @Override
    public boolean updateComment(CommentUpdateDto commentUpdateDto) {
        return updateComment(commentUpdateDto, null);
    }

    @Override
    public boolean updateComment(CommentUpdateDto commentUpdateDto, User currentUser) {
        Comment comment = getVisibleComment(commentUpdateDto.getCommentId());
        requireOwnerOrAdmin(comment, currentUser);
        String content = normalizeContent(commentUpdateDto.getContent());

        LambdaUpdateWrapper<Comment> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Comment::getId, commentUpdateDto.getCommentId())
                .eq(Comment::getStatus, STATUS_VISIBLE)
                .set(Comment::getContent, content)
                .set(Comment::getUpdatedAt, LocalDateTime.now());
        return update(updateWrapper);
    }

    @Override
    public List<Comment> getRepliesByCommentId(Long commentId) {
        Comment topComment = getVisibleComment(commentId);
        Long parentId = topComment.getParentId() == null ? topComment.getId() : topComment.getParentId();
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getParentId, parentId)
                .eq(Comment::getStatus, STATUS_VISIBLE)
                .orderByAsc(Comment::getCreatedAt);
        return list(queryWrapper);
    }

    @Override
    public boolean updateReplyCount(Long commentId, int increment) {
        LambdaUpdateWrapper<Comment> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Comment::getId, commentId)
                .setSql("reply_count = GREATEST(reply_count + (" + increment + "), 0)")
                .set(Comment::getUpdatedAt, LocalDateTime.now());
        return update(updateWrapper);
    }

    @Override
    public IPage<Comment> listComments(Integer pageNum, Integer pageSize, String targetType) {
        Page<Comment> page = new Page<>(normalizePageNum(pageNum), normalizePageSize(pageSize));
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(targetType)) {
            queryWrapper.eq(Comment::getTargetType, targetType);
        }
        queryWrapper.eq(Comment::getStatus, STATUS_VISIBLE)
                .orderByDesc(Comment::getCreatedAt);

        IPage<Comment> commentPage = page(page, queryWrapper);
        fillTargetInfoForComments(commentPage.getRecords());
        return commentPage;
    }

    private void normalizeNewComment(Comment comment, User currentUser) {
        validateTarget(comment.getTargetType(), comment.getTargetId());
        comment.setContent(normalizeContent(comment.getContent()));
        comment.setStatus(STATUS_VISIBLE);
        comment.setReplyCount(0);
        comment.setLikeCount(0);

        if (comment.getParentId() != null) {
            normalizeReply(comment);
        } else {
            comment.setReplyToCommentId(null);
            comment.setReplyToUserId(null);
            comment.setReplyToNickname(null);
        }

        if (currentUser != null) {
            comment.setAuthorType(AUTHOR_TYPE_USER);
            comment.setUserId(currentUser.getId());
            boolean anonymous = Boolean.TRUE.equals(comment.getAnonymous());
            comment.setAnonymous(anonymous);
            comment.setDisplayNickname(anonymous ? DEFAULT_GUEST_NAME : fallback(currentUser.getNickname(), currentUser.getUsername()));
            comment.setDisplayAvatar(anonymous ? null : currentUser.getAvatar());
            return;
        }

        comment.setAuthorType(AUTHOR_TYPE_GUEST);
        comment.setUserId(null);
        comment.setAnonymous(false);
        comment.setGuestNickname(fallback(comment.getGuestNickname(), DEFAULT_GUEST_NAME));
        comment.setGuestEmail(blankToNull(comment.getGuestEmail()));
        comment.setDisplayNickname(comment.getGuestNickname());
        comment.setDisplayAvatar(null);
    }

    private void normalizeReply(Comment comment) {
        Comment parent = getVisibleComment(comment.getParentId());
        Long topCommentId = parent.getParentId() == null ? parent.getId() : parent.getParentId();
        Long replyToCommentId = comment.getReplyToCommentId() == null ? parent.getId() : comment.getReplyToCommentId();
        Comment replyToComment = getVisibleComment(replyToCommentId);

        if (!Objects.equals(parent.getTargetType(), comment.getTargetType())
                || !Objects.equals(parent.getTargetId(), comment.getTargetId())
                || !Objects.equals(replyToComment.getTargetType(), comment.getTargetType())
                || !Objects.equals(replyToComment.getTargetId(), comment.getTargetId())) {
            throw new IllegalArgumentException("回复目标不一致");
        }

        comment.setParentId(topCommentId);
        comment.setReplyToCommentId(replyToCommentId);
        comment.setReplyToUserId(replyToComment.getUserId());
        comment.setReplyToNickname(replyToComment.getDisplayNickname());
    }

    private Comment getVisibleComment(Long commentId) {
        if (commentId == null) {
            throw new IllegalArgumentException("评论 ID 不能为空");
        }
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getId, commentId)
                .eq(Comment::getStatus, STATUS_VISIBLE);
        Comment comment = getOne(queryWrapper);
        if (comment == null) {
            throw new IllegalArgumentException("评论不存在");
        }
        return comment;
    }

    private void requireOwnerOrAdmin(Comment comment, User currentUser) {
        if (currentUser == null) {
            throw new IllegalArgumentException("请登录后再操作");
        }
        boolean isOwner = comment.getUserId() != null && Objects.equals(comment.getUserId(), currentUser.getId());
        boolean isAdmin = currentUser.getRoleId() != null && currentUser.getRoleId() == 1;
        if (!isOwner && !isAdmin) {
            throw new IllegalArgumentException("只能操作自己的评论");
        }
    }

    private void validateTarget(String targetType, Long targetId) {
        if (!StringUtils.hasText(targetType)) {
            throw new IllegalArgumentException("评论目标类型不能为空");
        }
        CommentTargetType.fromCode(targetType);
        if (targetId == null || targetId < 1) {
            throw new IllegalArgumentException("评论目标 ID 不合法");
        }
    }

    private String normalizeContent(String content) {
        String normalized = content == null ? "" : content.trim();
        if (normalized.isEmpty()) {
            throw new IllegalArgumentException("评论内容不能为空");
        }
        if (normalized.length() > 2000) {
            throw new IllegalArgumentException("评论内容不能超过 2000 个字符");
        }
        return normalized;
    }

    private int normalizePageNum(Integer pageNum) {
        return pageNum == null || pageNum < 1 ? 1 : pageNum;
    }

    private int normalizePageSize(Integer pageSize) {
        if (pageSize == null || pageSize < 1) {
            return 10;
        }
        return Math.min(pageSize, 50);
    }

    private String fallback(String value, String fallback) {
        return StringUtils.hasText(value) ? value.trim() : fallback;
    }

    private String blankToNull(String value) {
        return StringUtils.hasText(value) ? value.trim() : null;
    }

    private void sendNewCommentNotification(Comment comment) {
        try {
            NotificationStrategy notificationStrategy = notificationStrategyFactory.getNotificationStrategy();
            String author = fallback(comment.getDisplayNickname(), DEFAULT_GUEST_NAME);
            String targetName = getTargetName(comment.getTargetType());
            String message;
            if (comment.getParentId() == null) {
                message = author + "在" + targetName + " " + comment.getTargetId() + " 下发表了新的评论。\n"
                        + "评论内容：\n" + comment.getContent() + "\n";
            } else {
                message = author + "在" + targetName + " " + comment.getTargetId() + " 下发表了新的回复。\n"
                        + "回复对象：" + fallback(comment.getReplyToNickname(), DEFAULT_GUEST_NAME) + "\n"
                        + "回复内容：\n" + comment.getContent() + "\n";
            }
            notificationStrategy.sendNotification(message);
        } catch (Exception exception) {
            log.warn("评论通知发送失败，commentId={}", comment.getId(), exception);
        }
    }

    private String getTargetName(String targetType) {
        if (CommentTargetType.ARTICLE.getCode().equals(targetType)) {
            return "文章";
        }
        if (CommentTargetType.EXERCISE.getCode().equals(targetType)) {
            return "练习";
        }
        if (CommentTargetType.MESSAGE_BOARD.getCode().equals(targetType)) {
            return "留言板";
        }
        if (CommentTargetType.PROBLEM_REVIEW.getCode().equals(targetType)) {
            return "题目点评";
        }
        return "目标";
    }

    private void fillTargetInfoForComments(List<Comment> comments) {
        if (comments == null || comments.isEmpty()) {
            return;
        }
        fillArticleTargetInfo(comments);
        fillExerciseTargetInfo(comments);
    }

    private void fillArticleTargetInfo(List<Comment> comments) {
        Set<Integer> articleIds = comments.stream()
                .filter(comment -> CommentTargetType.ARTICLE.getCode().equals(comment.getTargetType()))
                .map(Comment::getTargetId)
                .filter(Objects::nonNull)
                .map(Long::intValue)
                .collect(Collectors.toCollection(HashSet::new));
        if (articleIds.isEmpty()) {
            return;
        }
        Map<Integer, Article> articleMap = articleService.getArticleMapByIds(new ArrayList<>(articleIds));
        for (Comment comment : comments) {
            if (!CommentTargetType.ARTICLE.getCode().equals(comment.getTargetType())) {
                continue;
            }
            Article article = articleMap.get(comment.getTargetId().intValue());
            if (article != null) {
                comment.setTargetTitle(article.getTitle());
                comment.setTargetUrl(article.getUrl());
            }
        }
    }

    private void fillExerciseTargetInfo(List<Comment> comments) {
        Set<Integer> exerciseIds = comments.stream()
                .filter(comment -> CommentTargetType.EXERCISE.getCode().equals(comment.getTargetType()))
                .map(Comment::getTargetId)
                .filter(Objects::nonNull)
                .map(Long::intValue)
                .collect(Collectors.toCollection(HashSet::new));
        if (exerciseIds.isEmpty()) {
            return;
        }
        Map<Integer, ExerciseSolution> exerciseMap = exerciseSolutionService.getExerciseMapByIds(new ArrayList<>(exerciseIds));
        for (Comment comment : comments) {
            if (!CommentTargetType.EXERCISE.getCode().equals(comment.getTargetType())) {
                continue;
            }
            ExerciseSolution exercise = exerciseMap.get(comment.getTargetId().intValue());
            if (exercise != null) {
                comment.setTargetTitle(exercise.getTitle());
                comment.setTargetUrl(exercise.getUrl());
            }
        }
    }
}
