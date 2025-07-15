package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.article.ArticleLikeInfoDto;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.IArticleLikeRecordService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Tag(name = "用户点赞")
@RestController
@RequestMapping("/user/like")
public class UserLikeController {

    @Resource
    private IArticleLikeRecordService articleLikeRecordService;

    @GetMapping("/list")
    public Result<List<ArticleLikeInfoDto>> getLikedArticles() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = user.getId();
        List<ArticleLikeInfoDto> likedArticles = articleLikeRecordService.getLikedArticlesByUserId(userId);
        return Result.success(likedArticles);
    }

}
