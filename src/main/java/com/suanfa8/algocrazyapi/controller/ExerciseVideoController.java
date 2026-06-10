package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.entity.ExerciseVideo;
import com.suanfa8.algocrazyapi.entity.ExerciseVideoDanmu;
import com.suanfa8.algocrazyapi.service.IExerciseVideoDanmuService;
import com.suanfa8.algocrazyapi.service.IExerciseVideoService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.cache.annotation.CacheEvict;
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
@RequestMapping("/exercise-videos")
@Tag(name = "练习视频管理", description = "练习视频和弹幕相关接口")
public class ExerciseVideoController {

    @Resource
    private IExerciseVideoService exerciseVideoService;

    @Resource
    private IExerciseVideoDanmuService exerciseVideoDanmuService;

    @GetMapping("/exercise/{exerciseSolutionId}")
    @Operation(summary = "获取练习已发布视频", description = "根据练习解答ID获取用户侧可播放的视频列表")
    public Result<List<ExerciseVideo>> getPublishedByExerciseSolutionId(
            @Parameter(description = "练习解答ID") @PathVariable Integer exerciseSolutionId) {
        return Result.success(exerciseVideoService.getByExerciseSolutionId(exerciseSolutionId, true));
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @GetMapping("/admin/exercise/{exerciseSolutionId}")
    @Operation(summary = "后台获取练习视频", description = "根据练习解答ID获取全部未删除视频列表")
    public Result<List<ExerciseVideo>> getAdminByExerciseSolutionId(
            @Parameter(description = "练习解答ID") @PathVariable Integer exerciseSolutionId) {
        return Result.success(exerciseVideoService.getByExerciseSolutionId(exerciseSolutionId, false));
    }

    @GetMapping("/{id}/danmus")
    @Operation(summary = "获取视频弹幕", description = "根据练习视频ID获取弹幕列表")
    public Result<List<ExerciseVideoDanmu>> getDanmus(@Parameter(description = "练习视频ID") @PathVariable Integer id) {
        return Result.success(exerciseVideoDanmuService.getByExerciseVideoId(id));
    }

    @PostMapping("/{id}/danmus")
    @Operation(summary = "发送视频弹幕", description = "发送并持久化视频弹幕")
    public Result<ExerciseVideoDanmu> createDanmu(
            @Parameter(description = "练习视频ID") @PathVariable Integer id,
            @RequestBody ExerciseVideoDanmu danmu) {
        ExerciseVideo video = exerciseVideoService.getById(id);
        if (video == null || Boolean.TRUE.equals(video.getIsDeleted()) || !Boolean.TRUE.equals(video.getIsPublished())) {
            return Result.fail(ResultCode.EXERCISE_VIDEO_NOT_FOUND);
        }
        if (!hasText(danmu.getContent()) || danmu.getTimeMs() == null || danmu.getTimeMs() < 0) {
            return Result.fail(ResultCode.PARAM_ERROR);
        }

        danmu.setId(null);
        danmu.setExerciseVideoId(id);
        danmu.setContent(danmu.getContent().trim());
        if (!hasText(danmu.getColor())) {
            danmu.setColor("#ffffff");
        }
        if (!hasText(danmu.getMode())) {
            danmu.setMode("scroll");
        }

        boolean success = exerciseVideoDanmuService.save(danmu);
        if (success) {
            return Result.success(danmu);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PostMapping("/admin")
    @CacheEvict(cacheNames = "exercise-solutions", key = "'catalog'")
    @Operation(summary = "创建练习视频", description = "为练习绑定一个已上传的视频")
    public Result<ExerciseVideo> create(@RequestBody ExerciseVideo video) {
        if (!isValidVideo(video)) {
            return Result.fail(ResultCode.PARAM_ERROR);
        }
        boolean success = exerciseVideoService.save(video);
        if (success) {
            return Result.success(video);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PutMapping("/admin/{id}")
    @CacheEvict(cacheNames = "exercise-solutions", key = "'catalog'")
    @Operation(summary = "更新练习视频", description = "根据ID更新练习视频信息")
    public Result<ExerciseVideo> update(@PathVariable Integer id, @RequestBody ExerciseVideo video) {
        if (!isValidVideo(video)) {
            return Result.fail(ResultCode.PARAM_ERROR);
        }
        video.setId(id);
        boolean success = exerciseVideoService.updateById(video);
        if (success) {
            return Result.success(video);
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @DeleteMapping("/admin/{id}")
    @CacheEvict(cacheNames = "exercise-solutions", key = "'catalog'")
    @Operation(summary = "删除练习视频", description = "根据ID软删除练习视频")
    public Result<Void> delete(@PathVariable Integer id) {
        boolean success = exerciseVideoService.softDelete(id);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.EXERCISE_VIDEO_NOT_FOUND);
    }

    private boolean isValidVideo(ExerciseVideo video) {
        return video != null
                && video.getExerciseSolutionId() != null
                && hasText(video.getTitle())
                && hasText(video.getVideoUrl());
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
