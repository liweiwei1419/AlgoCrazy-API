package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.entity.Label;
import com.suanfa8.algocrazyapi.service.ITagService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@Tag(name = "标签管理")
@RestController
@RequestMapping("/tag")
public class TagController {

    @Resource
    private ITagService tagService;

    @Operation(summary = "获取所有标签列表")
    @GetMapping("/all")
    public Result<List<Label>> getAllTags() {
        return Result.success(tagService.getAllTags());
    }

    @Operation(summary = "分页获取标签列表")
    @Parameter(name = "pageNum", description = "页码")
    @Parameter(name = "pageSize", description = "每页数量")
    @GetMapping("/list")
    public Result<IPage<Label>> listTags(
            @RequestParam(required = false) Integer pageNum,
            @RequestParam(required = false) Integer pageSize) {
        return Result.success(tagService.listTags(pageNum, pageSize));
    }

    @Operation(summary = "根据 ID 获取标签")
    @Parameter(name = "id", required = true, description = "标签ID")
    @GetMapping("/{id}")
    public Result<Label> getTagById(@PathVariable Integer id) {
        return Result.success(tagService.getTagById(id));
    }

    @Operation(summary = "创建标签")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @PostMapping("/create")
    public Result<Label> createTag(@RequestBody Label tag) {
        return Result.success(tagService.createTag(tag));
    }

    @Operation(summary = "更新标签")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @PutMapping("/update")
    public Result<Label> updateTag(@RequestBody Label tag) {
        return Result.success(tagService.updateTag(tag));
    }

    @Operation(summary = "删除标签")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @DeleteMapping("/{id}")
    public Result<Boolean> deleteTag(@PathVariable Integer id) {
        return Result.success(tagService.deleteTag(id));
    }

    @Operation(summary = "批量删除标签")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @DeleteMapping("/batch")
    public Result<Boolean> deleteTags(@RequestBody List<Integer> ids) {
        return Result.success(tagService.deleteTags(ids));
    }

    @Operation(summary = "为文章添加标签")
    @PreAuthorize("hasAnyRole('ADMIN', 'USER')")
    @PostMapping("/article/{articleId}/add")
    public Result<Boolean> addTagsToArticle(
            @PathVariable Integer articleId,
            @RequestBody List<Integer> tagIds) {
        return Result.success(tagService.addTagsToArticle(articleId, tagIds));
    }

    @Operation(summary = "更新文章标签")
    @PreAuthorize("hasAnyRole('ADMIN', 'USER')")
    @PutMapping("/article/{articleId}/update")
    public Result<Boolean> updateArticleTags(
            @PathVariable Integer articleId,
            @RequestBody List<Integer> tagIds) {
        return Result.success(tagService.updateArticleTags(articleId, tagIds));
    }

    @Operation(summary = "移除文章标签")
    @PreAuthorize("hasAnyRole('ADMIN', 'USER')")
    @DeleteMapping("/article/{articleId}/{tagId}")
    public Result<Boolean> removeTagFromArticle(
            @PathVariable Integer articleId,
            @PathVariable Integer tagId) {
        return Result.success(tagService.removeTagFromArticle(articleId, tagId));
    }

    @Operation(summary = "获取文章的标签列表")
    @GetMapping("/article/{articleId}")
    public Result<List<Label>> getTagsByArticleId(@PathVariable Integer articleId) {
        return Result.success(tagService.getTagsByArticleId(articleId));
    }

    @Operation(summary = "获取标签下的文章ID列表")
    @GetMapping("/{tagId}/articles")
    public Result<List<Integer>> getArticleIdsByTagId(@PathVariable Integer tagId) {
        return Result.success(tagService.getArticleIdsByTagId(tagId));
    }
}