package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.comment.CommentAddDto;
import com.suanfa8.algocrazyapi.dto.comment.CommentDeleteDto;
import com.suanfa8.algocrazyapi.dto.comment.CommentUpdateDto;
import com.suanfa8.algocrazyapi.entity.Comment;
import com.suanfa8.algocrazyapi.entity.CommentTargetType;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.ICommentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.annotation.security.PermitAll;
import org.springframework.beans.BeanUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin
@Tag(name = "评论")
@RestController
public class CommentController {

    @Resource
    private ICommentService commentService;

    @PermitAll
    @Operation(summary = "分页获取指定目标的顶层评论")
    @GetMapping("/comments")
    public Result<IPage<Comment>> pageComments(
            @RequestParam String targetType,
            @RequestParam Long targetId,
            @RequestParam(required = false) Integer pageNum,
            @RequestParam(required = false) Integer pageSize) {
        return Result.success(commentService.pageTopComments(targetType, targetId, pageNum, pageSize));
    }

    @PermitAll
    @Operation(summary = "添加评论或回复")
    @PostMapping("/comments")
    public Result<Comment> addComment(@RequestBody CommentAddDto commentAddDto) {
        Comment comment = new Comment();
        BeanUtils.copyProperties(commentAddDto, comment);
        if (comment.getParentId() == null && commentAddDto.getParentCommentId() != null) {
            comment.setParentId(commentAddDto.getParentCommentId().longValue());
        }
        return Result.success(commentService.addComment(comment, getCurrentUserOrNull()));
    }

    @PermitAll
    @Operation(summary = "获取指定顶层评论的回复列表")
    @GetMapping("/comments/{commentId}/replies")
    public Result<List<Comment>> getRepliesByCommentId(@PathVariable Long commentId) {
        return Result.success(commentService.getRepliesByCommentId(commentId));
    }

    @PermitAll
    @Operation(summary = "评论点赞")
    @PostMapping("/comments/{commentId}/like")
    public Result<Boolean> incrementLikeCount(@PathVariable Long commentId) {
        return Result.success(commentService.incrementLikeCount(commentId));
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @Operation(summary = "修改评论")
    @PutMapping("/comments/{commentId}")
    public Result<Boolean> updateComment(@PathVariable Long commentId, @RequestBody CommentUpdateDto commentUpdateDto) {
        commentUpdateDto.setCommentId(commentId);
        return Result.success(commentService.updateComment(commentUpdateDto, getCurrentUserOrNull()));
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @Operation(summary = "删除评论")
    @DeleteMapping("/comments/{commentId}")
    public Result<Boolean> deleteComment(@PathVariable Long commentId) {
        CommentDeleteDto commentDeleteDto = new CommentDeleteDto();
        commentDeleteDto.setCommentId(commentId);
        return Result.success(commentService.deleteComment(commentDeleteDto, getCurrentUserOrNull()));
    }

    @PermitAll
    @Operation(summary = "兼容旧接口：获取文章评论列表")
    @Parameter(name = "articleId", required = true, description = "文章 ID")
    @GetMapping("/comment/comments")
    public Result<List<Comment>> getCommentsByArticleId(@RequestParam String articleId) {
        return Result.success(commentService.getCommentsByArticleId(Integer.parseInt(articleId)));
    }

    @PermitAll
    @Operation(summary = "兼容旧接口：获取练习评论列表")
    @Parameter(name = "exerciseId", required = true, description = "练习 ID")
    @GetMapping("/comment/exercise/comments")
    public Result<List<Comment>> getCommentsByExerciseId(@RequestParam String exerciseId) {
        return Result.success(commentService.getCommentsByExerciseId(Integer.parseInt(exerciseId)));
    }

    @PermitAll
    @Operation(summary = "兼容旧接口：根据目标类型获取评论列表")
    @GetMapping("/comment/target/comments")
    public Result<List<Comment>> getCommentsByTarget(@RequestParam String targetType, @RequestParam String targetId) {
        return Result.success(commentService.getCommentsByTarget(targetType, Integer.parseInt(targetId)));
    }

    @PermitAll
    @Operation(summary = "兼容旧接口：添加评论")
    @PostMapping("/comment/add")
    public Result<Comment> addCommentLegacy(@RequestBody CommentAddDto commentAddDto) {
        return addComment(commentAddDto);
    }

    @PermitAll
    @Operation(summary = "兼容旧接口：获取回复列表")
    @GetMapping("/comment/{commentId}/replies")
    public Result<List<Comment>> getRepliesByCommentIdLegacy(@PathVariable Long commentId) {
        return getRepliesByCommentId(commentId);
    }

    @PermitAll
    @Operation(summary = "兼容旧接口：评论点赞")
    @PostMapping("/comment/{commentId}/like")
    public Result<Boolean> incrementLikeCountLegacy(@PathVariable Long commentId) {
        return incrementLikeCount(commentId);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @Operation(summary = "兼容旧接口：逻辑删除评论")
    @DeleteMapping("/comment/delete")
    public Result<Boolean> deleteCommentLegacy(@RequestParam("comment_id") Long commentId) {
        return deleteComment(commentId);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @Operation(summary = "管理端：删除评论")
    @DeleteMapping("/comment/delete/{id}")
    public Result<Boolean> deleteCommentById(@PathVariable Long id) {
        return deleteComment(id);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @Operation(summary = "兼容旧接口：修改评论")
    @PutMapping("/comment/update")
    public Result<Boolean> updateCommentLegacy(@RequestBody CommentUpdateDto commentUpdateDto) {
        return Result.success(commentService.updateComment(commentUpdateDto, getCurrentUserOrNull()));
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @Operation(summary = "管理端：分页显示评论列表")
    @GetMapping("/comment/list")
    public Result<IPage<Comment>> listComments(
            @RequestParam(required = false) Integer pageNum,
            @RequestParam(required = false) Integer pageSize,
            @RequestParam(required = false) String targetType) {
        return Result.success(commentService.listComments(pageNum, pageSize, targetType));
    }

    @PermitAll
    @Operation(summary = "获取支持的评论目标类型")
    @GetMapping("/comments/target-types")
    public Result<CommentTargetType[]> listTargetTypes() {
        return Result.success(CommentTargetType.values());
    }

    private User getCurrentUserOrNull() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !(authentication.getPrincipal() instanceof User user)) {
            return null;
        }
        return user;
    }
}
