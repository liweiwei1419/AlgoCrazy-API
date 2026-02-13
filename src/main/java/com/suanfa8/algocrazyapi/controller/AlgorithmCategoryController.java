package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.entity.AlgorithmCategory;
import com.suanfa8.algocrazyapi.service.IAlgorithmCategoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "算法分类管理")
@RestController
@RequestMapping("/algorithm-category")
public class AlgorithmCategoryController {

    @Resource
    private IAlgorithmCategoryService algorithmCategoryService;


    @Operation(summary = "获取所有算法分类列表")
    @GetMapping("/all")
    @Cacheable(value = "algorithmCategories", key = "'all'", unless = "#result == null || #result.data.size() == 0")
    public Result<List<AlgorithmCategory>> getAllCategories() {
        return Result.success(algorithmCategoryService.getAllCategories());
    }

    @Operation(summary = "分页获取算法分类列表")
    @Parameter(name = "pageNum", description = "页码")
    @Parameter(name = "pageSize", description = "每页数量")
    @GetMapping("/list")
    public Result<IPage<AlgorithmCategory>> listCategories(@RequestParam(required = false) Integer pageNum, @RequestParam(required = false) Integer pageSize) {
        return Result.success(algorithmCategoryService.listCategories(pageNum, pageSize));
    }

    @Operation(summary = "根据 ID 获取算法分类")
    @Parameter(name = "id", required = true, description = "分类ID")
    @GetMapping("/{id}")
    public Result<AlgorithmCategory> getCategoryById(@PathVariable Integer id) {
        return Result.success(algorithmCategoryService.getCategoryById(id));
    }

    @Operation(summary = "根据 value 获取算法分类")
    @Parameter(name = "value", required = true, description = "分类值")
    @GetMapping("/value/{value}")
    public Result<AlgorithmCategory> getCategoryByValue(@PathVariable Integer value) {
        return Result.success(algorithmCategoryService.getCategoryByValue(value));
    }

    @Operation(summary = "根据 label 获取算法分类")
    @Parameter(name = "label", required = true, description = "分类标签")
    @GetMapping("/label/{label}")
    public Result<AlgorithmCategory> getCategoryByLabel(@PathVariable String label) {
        return Result.success(algorithmCategoryService.getCategoryByLabel(label));
    }

    @Operation(summary = "创建算法分类")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @PostMapping("/create")
    public Result<AlgorithmCategory> createCategory(@RequestBody AlgorithmCategory category) {
        return Result.success(algorithmCategoryService.createCategory(category));
    }

    @Operation(summary = "更新算法分类")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @PutMapping("/update")
    public Result<AlgorithmCategory> updateCategory(@RequestBody AlgorithmCategory category) {
        return Result.success(algorithmCategoryService.updateCategory(category));
    }

    @Operation(summary = "删除算法分类")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @DeleteMapping("/{id}")
    public Result<Boolean> deleteCategory(@PathVariable Integer id) {
        return Result.success(algorithmCategoryService.deleteCategory(id));
    }

    @Operation(summary = "批量删除算法分类")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @DeleteMapping("/batch")
    public Result<Boolean> deleteCategories(@RequestBody List<Integer> ids) {
        return Result.success(algorithmCategoryService.deleteCategories(ids));
    }

}