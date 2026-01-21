package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.entity.LeetCodeProblems;
import com.suanfa8.algocrazyapi.service.ILeetCodeProblemsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "LeetCode 题目")
@RequestMapping("/leetcode/problems")
@RestController
@Slf4j
public class LeetCodeProblemsController {

    @Resource
    private ILeetCodeProblemsService leetCodeProblemsService;

    @Operation(summary = "分页查询LeetCode题目列表")
    @Parameter(name = "current", description = "当前页")
    @Parameter(name = "size", description = "每页显示条数")
    @Parameter(name = "title", required = false, description = "题目名称搜索关键字")
    @GetMapping("/page")
    public Result<IPage<LeetCodeProblems>> getLeetCodeProblemsPage(
            @RequestParam(defaultValue = "1") Integer current,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String title) {
        
        log.info("分页查询LeetCode题目列表，当前页：{}", current);
        log.info("分页查询LeetCode题目列表，每页显示条数：{}", size);
        log.info("分页查询LeetCode题目列表，搜索关键字：{}", title);
        
        // 创建分页对象
        Page<LeetCodeProblems> page = new Page<>(current, size);
        
        // 创建查询条件
        QueryWrapper<LeetCodeProblems> queryWrapper = new QueryWrapper<>();
        
        // 如果传入了title参数，则添加模糊查询条件
        if (StringUtils.isNotBlank(title)) {
            queryWrapper.like("title", title);
        }
        
        // 按ID升序排序
        queryWrapper.orderByAsc("id");
        
        // 执行分页查询
        IPage<LeetCodeProblems> problemsPage = leetCodeProblemsService.page(page, queryWrapper);
        
        return Result.success(problemsPage);
    }
}
