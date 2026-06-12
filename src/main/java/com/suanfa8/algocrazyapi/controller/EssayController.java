package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.entity.Essay;
import com.suanfa8.algocrazyapi.service.IEssayService;
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
@Tag(name = "随笔管理", description = "独立补充文章相关接口")
public class EssayController {

    @Resource
    private IEssayService essayService;

    @GetMapping("/essays/published")
    @Operation(summary = "获取已发布随笔列表", description = "用于前台展示的随笔列表")
    public Result<List<Essay>> getPublishedList() {
        return Result.success(essayService.getPublishedList());
    }

    @GetMapping("/essays/{id}")
    @Operation(summary = "获取已发布随笔详情")
    public Result<Essay> getPublishedDetail(@PathVariable Integer id) {
        Essay essay = essayService.getPublishedDetail(id);
        if (essay == null) {
            return Result.fail(ResultCode.FAILED);
        }
        essayService.incrementViewCount(id);
        essay.setViewCount((essay.getViewCount() == null ? 0 : essay.getViewCount()) + 1);
        return Result.success(essay);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping("/admin/essays")
    @Operation(summary = "获取随笔列表", description = "后台管理使用的随笔列表")
    public Result<List<Essay>> getAdminList(@Parameter(description = "搜索关键词") @RequestParam(required = false) String keyword) {
        return Result.success(essayService.getAdminList(keyword));
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping("/admin/essays/{id}")
    @Operation(summary = "根据 ID 获取随笔")
    public Result<Essay> getById(@PathVariable Integer id) {
        Essay essay = essayService.getById(id);
        if (essay == null || Boolean.TRUE.equals(essay.getIsDeleted())) {
            return Result.fail(ResultCode.FAILED);
        }
        return Result.success(essay);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PostMapping("/admin/essays")
    @Operation(summary = "创建随笔")
    public Result<Essay> create(@RequestBody Essay essay) {
        boolean success = essayService.save(essay);
        if (success) {
            return Result.success(essay);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PutMapping("/admin/essays/{id}")
    @Operation(summary = "更新随笔")
    public Result<Essay> update(@PathVariable Integer id, @RequestBody Essay essay) {
        essay.setId(id);
        boolean success = essayService.updateById(essay);
        if (success) {
            return Result.success(essay);
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @DeleteMapping("/admin/essays/{id}")
    @Operation(summary = "删除随笔", description = "根据 ID 软删除随笔")
    public Result<Void> delete(@PathVariable Integer id) {
        boolean success = essayService.removeById(id);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.DELETE_FAILED);
    }
}
