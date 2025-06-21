package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.comment.CommentAddDto;
import com.suanfa8.algocrazyapi.entity.Comment;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.ICommentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.security.PermitAll;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin
@Tag(name = "评论")
@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private ICommentService commentService;

    @Operation(summary = "获取文章评论列表")
    @Parameter(name = "articleId", required = true, description = "文章 ID")
    @GetMapping("/comments")
    public Result<List<Comment>> getCommentsByArticleId(@RequestParam String articleId) {
        return Result.success(commentService.getCommentsByArticleId(Integer.parseInt(articleId)));
    }

    @Operation(summary = "添加评论")
    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PostMapping("/add")
    public Result<Comment> addComment(@RequestBody CommentAddDto commentAddDto) {
        System.out.println("commentAddDto => " + commentAddDto);
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Comment comment = new Comment();
        // 复制相同字段（要求 DTO 和 Entity 字段名一致）
        BeanUtils.copyProperties(commentAddDto, comment);
        // 手动设置 DTO 没有的字段
        comment.setUserId(user.getId());
        comment.setUserNickname(user.getNickname());
        System.out.println("comment => " + comment);
        Comment newComment = commentService.addComment(comment);
        return Result.success(newComment);
    }


    @PermitAll
    @Operation(summary = "获取指定评论的回复列表")
    @Parameter(name = "commentId", required = true, description = "评论 ID")
    @GetMapping("/{commentId}/replies")
    public Result<List<Comment>> getRepliesByCommentId(@PathVariable Integer commentId) {
        List<Comment> replies = commentService.getRepliesByCommentId(commentId);
        return Result.success(replies);
    }

    @Operation(summary = "评论点赞")
    @Parameter(name = "id", required = true, description = "评论 ID")
    @PostMapping("/{commentId}/like")
    public Result<Boolean> incrementLikeCount(@PathVariable Integer commentId) {
        boolean result = commentService.incrementLikeCount(commentId);
        return Result.success(result);
    }

    @Operation(summary = "逻辑删除评论")
    @Parameter(name = "id", required = true, description = "评论 ID")
    @DeleteMapping("/{id}")
    public Result<Boolean> deleteComment(@PathVariable Integer id) {
        boolean result = commentService.deleteComment(id);
        return Result.success(result);
    }

    @Operation(summary = "修改评论")
    @PutMapping("/update")
    public Result<Boolean> updateComment(@RequestBody Comment comment) {
        boolean result = commentService.updateComment(comment);
        return Result.success(result);
    }

}