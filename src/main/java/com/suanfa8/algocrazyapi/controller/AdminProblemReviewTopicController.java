package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.problemreview.ProblemReviewTopicDTO;
import com.suanfa8.algocrazyapi.entity.ProblemReviewTopic;
import com.suanfa8.algocrazyapi.service.IProblemReviewService;
import io.swagger.v3.oas.annotations.Operation;
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
@RequestMapping("/admin/problem-review-topics")
@Tag(name = "题目点评 Topic 管理", description = "题目点评精选题管理")
public class AdminProblemReviewTopicController {

    @Resource
    private IProblemReviewService problemReviewService;

    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping
    @Operation(summary = "获取题目点评 topic 列表")
    public Result<List<ProblemReviewTopicDTO>> listTopics(@RequestParam(required = false) String keyword) {
        return Result.success(problemReviewService.listAdminTopics(keyword));
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping("/{topicId}")
    @Operation(summary = "获取题目点评 topic")
    public Result<ProblemReviewTopic> getTopic(@PathVariable Long topicId) {
        return Result.success(problemReviewService.getAdminTopic(topicId));
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PostMapping
    @Operation(summary = "创建题目点评 topic")
    public Result<ProblemReviewTopic> createTopic(@RequestBody ProblemReviewTopic topic) {
        return Result.success(problemReviewService.createTopic(topic));
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PutMapping("/{topicId}")
    @Operation(summary = "更新题目点评 topic")
    public Result<ProblemReviewTopic> updateTopic(@PathVariable Long topicId, @RequestBody ProblemReviewTopic topic) {
        return Result.success(problemReviewService.updateTopic(topicId, topic));
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @DeleteMapping("/{topicId}")
    @Operation(summary = "删除题目点评 topic")
    public Result<Boolean> deleteTopic(@PathVariable Long topicId) {
        return Result.success(problemReviewService.deleteTopic(topicId));
    }
}
