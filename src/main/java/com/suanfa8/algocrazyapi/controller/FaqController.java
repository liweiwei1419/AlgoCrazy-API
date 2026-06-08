package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.entity.Faq;
import com.suanfa8.algocrazyapi.service.IFaqService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Tag(name = "常见问答管理", description = "常见问答相关接口")
public class FaqController {

    @Resource
    private IFaqService faqService;

    @GetMapping("/faqs/published")
    @Operation(summary = "获取已发布常见问答", description = "用于前台展示的常见问答列表")
    public Result<List<Faq>> getPublishedList() {
        return Result.success(faqService.getPublishedList());
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping("/admin/faqs")
    @Operation(summary = "获取常见问答列表", description = "后台管理使用的常见问答列表")
    public Result<List<Faq>> getAdminList(@Parameter(description = "搜索关键词") @RequestParam(required = false) String keyword) {
        return Result.success(faqService.getAdminList(keyword));
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping("/admin/faqs/{id}")
    @Operation(summary = "根据 ID 获取常见问答")
    public Result<Faq> getById(@PathVariable Integer id) {
        Faq faq = faqService.getById(id);
        if (faq == null || Boolean.TRUE.equals(faq.getIsDeleted())) {
            return Result.fail(ResultCode.FAILED);
        }
        return Result.success(faq);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PostMapping("/admin/faqs")
    @Operation(summary = "创建常见问答")
    public Result<Faq> create(@RequestBody Faq faq) {
        boolean success = faqService.save(faq);
        if (success) {
            return Result.success(faq);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PutMapping("/admin/faqs/{id}")
    @Operation(summary = "更新常见问答")
    public Result<Faq> update(@PathVariable Integer id, @RequestBody Faq faq) {
        faq.setId(id);
        boolean success = faqService.updateById(faq);
        if (success) {
            return Result.success(faq);
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @DeleteMapping("/admin/faqs/{id}")
    @Operation(summary = "删除常见问答", description = "根据 ID 软删除常见问答")
    public Result<Void> delete(@PathVariable Integer id) {
        boolean success = faqService.removeById(id);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.DELETE_FAILED);
    }
}
