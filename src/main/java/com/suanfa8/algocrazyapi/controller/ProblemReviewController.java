package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.problemreview.ProblemReviewSubmitDTO;
import com.suanfa8.algocrazyapi.dto.problemreview.ProblemReviewTopicDTO;
import com.suanfa8.algocrazyapi.entity.ProblemReview;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.IProblemReviewService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.annotation.security.PermitAll;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/problem-reviews")
@Tag(name = "题目点评", description = "精选题点评、评分和卡点统计")
public class ProblemReviewController {

    @Resource
    private IProblemReviewService problemReviewService;

    @PermitAll
    @GetMapping("/topics")
    @Operation(summary = "获取已开放点评的精选题")
    public Result<List<ProblemReviewTopicDTO>> listTopics() {
        return Result.success(problemReviewService.listEnabledTopics());
    }

    @PermitAll
    @GetMapping("/topics/{topicId}")
    @Operation(summary = "获取精选题点评详情")
    public Result<ProblemReviewTopicDTO> getTopicDetail(@PathVariable Long topicId) {
        return Result.success(problemReviewService.getTopicDetail(topicId));
    }

    @PermitAll
    @PostMapping("/topics/{topicId}/reviews")
    @Operation(summary = "提交题目点评")
    public Result<ProblemReview> submitReview(@PathVariable Long topicId, @RequestBody ProblemReviewSubmitDTO submitDTO) {
        return Result.success(problemReviewService.submitReview(topicId, submitDTO, getCurrentUserOrNull()));
    }

    private User getCurrentUserOrNull() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !(authentication.getPrincipal() instanceof User user)) {
            return null;
        }
        return user;
    }
}
