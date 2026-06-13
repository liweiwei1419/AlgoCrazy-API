package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.entity.AdminManualArticle;
import com.suanfa8.algocrazyapi.service.IAdminManualArticleService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Tag(name = "站长管理手册", description = "管理员私有 Markdown 手册文章")
public class AdminManualArticleController {

    @Resource
    private IAdminManualArticleService adminManualArticleService;

    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping("/admin/manual-articles")
    @Operation(summary = "获取手册文章列表")
    public Result<List<AdminManualArticle>> getAdminList(@Parameter(description = "搜索关键词") @RequestParam(required = false) String keyword) {
        return Result.success(adminManualArticleService.getAdminList(keyword));
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping("/admin/manual-articles/{id}")
    @Operation(summary = "根据 ID 获取手册文章")
    public Result<AdminManualArticle> getById(@PathVariable Integer id) {
        AdminManualArticle article = adminManualArticleService.getById(id);
        if (article == null || Boolean.TRUE.equals(article.getIsDeleted())) {
            return Result.fail(ResultCode.FAILED);
        }
        return Result.success(article);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PostMapping("/admin/manual-articles")
    @Operation(summary = "创建手册文章")
    public Result<AdminManualArticle> create(@RequestBody AdminManualArticle article) {
        boolean success = adminManualArticleService.save(article);
        if (success) {
            return Result.success(article);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PutMapping("/admin/manual-articles/{id}")
    @Operation(summary = "更新手册文章")
    public Result<AdminManualArticle> update(@PathVariable Integer id, @RequestBody AdminManualArticle article) {
        article.setId(id);
        boolean success = adminManualArticleService.updateById(article);
        if (success) {
            return Result.success(article);
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @DeleteMapping("/admin/manual-articles/{id}")
    @Operation(summary = "删除手册文章")
    public Result<Void> delete(@PathVariable Integer id) {
        boolean success = adminManualArticleService.removeById(id);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.DELETE_FAILED);
    }
}
