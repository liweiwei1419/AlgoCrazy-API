package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.entity.ExerciseSolutionDraft;
import com.suanfa8.algocrazyapi.service.IExerciseSolutionDraftService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 练习草稿控制器
 */
@RestController
@RequestMapping("/exercise-solution-drafts")
@Tag(name = "练习草稿管理", description = "练习草稿相关接口")
public class ExerciseSolutionDraftController {

    @Resource
    private IExerciseSolutionDraftService exerciseSolutionDraftService;

    @GetMapping("/exercise/{exerciseSolutionId}")
    @Operation(summary = "根据练习解答ID获取草稿", description = "根据练习解答ID获取对应的草稿内容")
    public Result<ExerciseSolutionDraft> getByExerciseSolutionId(
            @Parameter(description = "练习解答ID") @PathVariable Integer exerciseSolutionId) {
        ExerciseSolutionDraft draft = exerciseSolutionDraftService.getByExerciseSolutionId(exerciseSolutionId);
        if (draft == null) {
            return Result.fail(ResultCode.DRAFT_NOT_FOUND);
        }
        return Result.success(draft);
    }

    @PostMapping
    @Operation(summary = "创建草稿", description = "创建新的练习草稿")
    public Result<ExerciseSolutionDraft> create(@RequestBody ExerciseSolutionDraft draft) {
        boolean success = exerciseSolutionDraftService.save(draft);
        if (success) {
            return Result.success(draft);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PutMapping("/exercise/{exerciseSolutionId}")
    @Operation(summary = "保存或更新草稿", description = "根据练习解答ID保存或更新草稿内容")
    public Result<Void> saveOrUpdate(
            @Parameter(description = "练习解答ID") @PathVariable Integer exerciseSolutionId,
            @Parameter(description = "草稿内容") @RequestBody String draftContent) {
        boolean success = exerciseSolutionDraftService.saveOrUpdateDraft(exerciseSolutionId, draftContent);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }

    @DeleteMapping("/exercise/{exerciseSolutionId}")
    @Operation(summary = "删除草稿", description = "根据练习解答ID删除草稿（软删除）")
    public Result<Void> deleteByExerciseSolutionId(
            @Parameter(description = "练习解答ID") @PathVariable Integer exerciseSolutionId) {
        boolean success = exerciseSolutionDraftService.deleteByExerciseSolutionId(exerciseSolutionId);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.DELETE_FAILED);
    }

    @GetMapping("/{id}")
    @Operation(summary = "根据ID获取草稿", description = "根据草稿ID获取草稿详情")
    public Result<ExerciseSolutionDraft> getById(@Parameter(description = "草稿ID") @PathVariable Integer id) {
        ExerciseSolutionDraft draft = exerciseSolutionDraftService.getById(id);
        if (draft == null || draft.getIsDeleted()) {
            return Result.fail(ResultCode.DRAFT_NOT_FOUND);
        }
        return Result.success(draft);
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新草稿", description = "根据ID更新草稿")
    public Result<ExerciseSolutionDraft> update(
            @Parameter(description = "草稿ID") @PathVariable Integer id,
            @RequestBody ExerciseSolutionDraft draft) {
        draft.setId(id);
        boolean success = exerciseSolutionDraftService.updateById(draft);
        if (success) {
            return Result.success(draft);
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除草稿", description = "根据ID删除草稿（软删除）")
    public Result<Void> delete(@Parameter(description = "草稿ID") @PathVariable Integer id) {
        ExerciseSolutionDraft draft = exerciseSolutionDraftService.getById(id);
        if (draft == null) {
            return Result.fail(ResultCode.DRAFT_NOT_FOUND);
        }
        draft.setIsDeleted(true);
        boolean success = exerciseSolutionDraftService.updateById(draft);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.DELETE_FAILED);
    }
}