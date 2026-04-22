package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;
import com.suanfa8.algocrazyapi.service.IExerciseSolutionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/exercise-solutions")
@Tag(name = "习题解答管理", description = "习题解答相关接口")
public class ExerciseSolutionController {

    @Resource
    private IExerciseSolutionService exerciseSolutionService;

    @GetMapping
    @Operation(summary = "获取习题解答列表", description = "分页获取习题解答列表")
    public Result<IPage<ExerciseSolution>> getList(
            @Parameter(description = "页码") @RequestParam(defaultValue = "1") Integer page,
            @Parameter(description = "每页大小") @RequestParam(defaultValue = "10") Integer size,
            @Parameter(description = "搜索关键词") @RequestParam(required = false) String keyword,
            @Parameter(description = "难度级别") @RequestParam(required = false) String difficulty,
            @Parameter(description = "分类") @RequestParam(required = false) String category,
            @Parameter(description = "章节序号") @RequestParam(required = false) String chapterNumber) {
        IPage<ExerciseSolution> pageList = exerciseSolutionService.getPageList(page, size, keyword, difficulty, category, chapterNumber);
        return Result.success(pageList);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @GetMapping("/{id}")
    @Operation(summary = "根据 ID 获取习题解答", description = "根据 ID 获取习题解答详情")
    public Result<ExerciseSolution> getById(@PathVariable Integer id) {
        ExerciseSolution exerciseSolution = exerciseSolutionService.getById(id);
        if (exerciseSolution == null || exerciseSolution.getIsDeleted()) {
            return Result.fail(ResultCode.EXERCISE_SOLUTION_NOT_FOUND);
        }
        return Result.success(exerciseSolution);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PostMapping
    @Operation(summary = "创建习题解答", description = "创建新的习题解答")
    public Result<ExerciseSolution> create(@RequestBody ExerciseSolution exerciseSolution) {
        boolean success = exerciseSolutionService.save(exerciseSolution);
        if (success) {
            return Result.success(exerciseSolution);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新习题解答", description = "根据 ID 更新习题解答")
    public Result<ExerciseSolution> update(@PathVariable Integer id, @RequestBody ExerciseSolution exerciseSolution) {
        exerciseSolution.setId(id);
        boolean success = exerciseSolutionService.updateById(exerciseSolution);
        if (success) {
            return Result.success(exerciseSolution);
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除习题解答", description = "根据ID删除习题解答（软删除）")
    public Result<Void> delete(@PathVariable Integer id) {
        ExerciseSolution exerciseSolution = exerciseSolutionService.getById(id);
        if (exerciseSolution == null) {
            return Result.fail(ResultCode.EXERCISE_SOLUTION_NOT_FOUND);
        }
        exerciseSolution.setIsDeleted(true);
        boolean success = exerciseSolutionService.updateById(exerciseSolution);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.DELETE_FAILED);
    }

    @GetMapping("/parent/{parentId}")
    @Operation(summary = "根据父ID获取子习题列表", description = "获取指定父节点下的所有子习题")
    public Result<List<ExerciseSolution>> getChildrenByParentId(@PathVariable Integer parentId) {
        List<ExerciseSolution> children = exerciseSolutionService.getChildrenByParentId(parentId);
        return Result.success(children);
    }

    @GetMapping("/difficulty/{difficulty}")
    @Operation(summary = "根据难度级别获取习题列表", description = "获取指定难度级别的习题列表")
    public Result<List<ExerciseSolution>> getByDifficulty(@PathVariable String difficulty) {
        List<ExerciseSolution> list = exerciseSolutionService.getByDifficulty(difficulty);
        return Result.success(list);
    }

    @GetMapping("/category/{category}")
    @Operation(summary = "根据分类获取习题列表", description = "获取指定分类的习题列表")
    public Result<List<ExerciseSolution>> getByCategory(@PathVariable String category) {
        List<ExerciseSolution> list = exerciseSolutionService.getByCategory(category);
        return Result.success(list);
    }

    @GetMapping("/chapter/{chapterNumber}")
    @Operation(summary = "根据章节序号获取习题列表", description = "获取指定章节序号的习题列表")
    public Result<List<ExerciseSolution>> getByChapterNumber(@PathVariable String chapterNumber) {
        List<ExerciseSolution> list = exerciseSolutionService.getByChapterNumber(chapterNumber);
        return Result.success(list);
    }

    @GetMapping("/leetcode/{leetcodeNumber}")
    @Operation(summary = "根据力扣题号获取习题", description = "根据力扣题号获取习题详情")
    public Result<ExerciseSolution> getByLeetcodeNumber(@PathVariable String leetcodeNumber) {
        ExerciseSolution exerciseSolution = exerciseSolutionService.getByLeetcodeNumber(leetcodeNumber);
        if (exerciseSolution == null) {
            return Result.fail(ResultCode.EXERCISE_SOLUTION_NOT_FOUND);
        }
        return Result.success(exerciseSolution);
    }

    @GetMapping("/tree")
    @Operation(summary = "获取树形结构的习题列表", description = "获取完整的树形结构习题列表")
    public Result<List<ExerciseSolution>> getTreeList() {
        List<ExerciseSolution> treeList = exerciseSolutionService.getTreeList();
        return Result.success(treeList);
    }

    @GetMapping("/children/{parentId}")
    @Operation(summary = "获取所有子节点", description = "获取指定节点的所有子节点（包括孙子节点）")
    public Result<List<ExerciseSolution>> getAllChildren(@PathVariable Integer parentId) {
        List<ExerciseSolution> children = exerciseSolutionService.getAllChildren(parentId);
        return Result.success(children);
    }

}