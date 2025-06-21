package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.entity.Comment;
import com.suanfa8.algocrazyapi.service.ICommentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "评论")
@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private ICommentService commentService;

    @Operation(summary = "获取文章评论列表")
    @Parameter(name = "articleId", required = true, description = "文章 ID")
    @GetMapping("/{articleId}")
    public Result<List<Comment>> getCommentsByArticleId(@PathVariable Long articleId) {
        List<Comment> comments = commentService.getCommentsByArticleId(articleId);
        return Result.success(comments);
    }

    @Operation(summary = "添加评论")
    @PostMapping("/add")
    public Result<Comment> addComment(@RequestBody Comment comment) {
        Comment newComment = commentService.addComment(comment);
        return Result.success(newComment);
    }

    @Operation(summary = "评论点赞")
    @Parameter(name = "id", required = true, description = "评论 ID")
    @PostMapping("/{id}/like")
    public Result<Boolean> incrementLikeCount(@PathVariable Long id) {
        boolean result = commentService.incrementLikeCount(id);
        return Result.success(result);
    }

    @Operation(summary = "逻辑删除评论")
    @Parameter(name = "id", required = true, description = "评论 ID")
    @DeleteMapping("/{id}")
    public Result<Boolean> deleteComment(@PathVariable Long id) {
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