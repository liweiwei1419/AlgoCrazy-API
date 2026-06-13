package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.entity.ArticleVideo;
import com.suanfa8.algocrazyapi.entity.ArticleVideoDanmu;
import com.suanfa8.algocrazyapi.service.IArticleVideoDanmuService;
import com.suanfa8.algocrazyapi.service.IArticleVideoService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/article-videos")
@Tag(name = "正文视频管理", description = "正文视频和弹幕相关接口")
public class ArticleVideoController {

    @Resource
    private IArticleVideoService articleVideoService;

    @Resource
    private IArticleVideoDanmuService articleVideoDanmuService;

    @GetMapping("/article/{articleId}")
    @Operation(summary = "获取正文已发布视频", description = "根据文章ID获取用户侧可播放的视频列表")
    public Result<List<ArticleVideo>> getPublishedByArticleId(
            @Parameter(description = "文章ID") @PathVariable Integer articleId) {
        return Result.success(articleVideoService.getByArticleId(articleId, true));
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @GetMapping("/admin/article/{articleId}")
    @Operation(summary = "后台获取正文视频", description = "根据文章ID获取全部未删除视频列表")
    public Result<List<ArticleVideo>> getAdminByArticleId(
            @Parameter(description = "文章ID") @PathVariable Integer articleId) {
        return Result.success(articleVideoService.getByArticleId(articleId, false));
    }

    @GetMapping("/{id}/danmus")
    @Operation(summary = "获取正文视频弹幕", description = "根据正文视频ID获取弹幕列表")
    public Result<List<ArticleVideoDanmu>> getDanmus(@Parameter(description = "正文视频ID") @PathVariable Integer id) {
        return Result.success(articleVideoDanmuService.getByArticleVideoId(id));
    }

    @PostMapping("/{id}/danmus")
    @Operation(summary = "发送正文视频弹幕", description = "发送并持久化正文视频弹幕")
    public Result<ArticleVideoDanmu> createDanmu(
            @Parameter(description = "正文视频ID") @PathVariable Integer id,
            @RequestBody ArticleVideoDanmu danmu) {
        ArticleVideo video = articleVideoService.getById(id);
        if (video == null || Boolean.TRUE.equals(video.getIsDeleted()) || !Boolean.TRUE.equals(video.getIsPublished())) {
            return Result.fail(ResultCode.ARTICLE_VIDEO_NOT_FOUND);
        }
        if (!hasText(danmu.getContent()) || danmu.getTimeMs() == null || danmu.getTimeMs() < 0) {
            return Result.fail(ResultCode.PARAM_ERROR);
        }

        danmu.setId(null);
        danmu.setArticleVideoId(id);
        danmu.setContent(danmu.getContent().trim());
        if (!hasText(danmu.getColor())) {
            danmu.setColor("#ffffff");
        }
        if (!hasText(danmu.getMode())) {
            danmu.setMode("scroll");
        }

        boolean success = articleVideoDanmuService.save(danmu);
        if (success) {
            return Result.success(danmu);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PostMapping("/admin")
    @Operation(summary = "创建正文视频", description = "为正文绑定一个已上传的视频")
    public Result<ArticleVideo> create(@RequestBody ArticleVideo video) {
        if (!isValidVideo(video)) {
            return Result.fail(ResultCode.PARAM_ERROR);
        }
        boolean success = articleVideoService.save(video);
        if (success) {
            return Result.success(video);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PutMapping("/admin/{id}")
    @Operation(summary = "更新正文视频", description = "根据ID更新正文视频信息")
    public Result<ArticleVideo> update(@PathVariable Integer id, @RequestBody ArticleVideo video) {
        if (!isValidVideo(video)) {
            return Result.fail(ResultCode.PARAM_ERROR);
        }
        video.setId(id);
        boolean success = articleVideoService.updateById(video);
        if (success) {
            return Result.success(video);
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @DeleteMapping("/admin/{id}")
    @Operation(summary = "删除正文视频", description = "根据ID软删除正文视频")
    public Result<Void> delete(@PathVariable Integer id) {
        boolean success = articleVideoService.softDelete(id);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.ARTICLE_VIDEO_NOT_FOUND);
    }

    private boolean isValidVideo(ArticleVideo video) {
        return video != null
                && video.getArticleId() != null
                && hasText(video.getTitle())
                && hasText(video.getVideoUrl());
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
