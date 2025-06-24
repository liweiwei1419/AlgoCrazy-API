package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.IArticleLikeRecordService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "文章")
@RequestMapping("/article/like")
@RestController
@Slf4j
public class ArticleLikeRecordController {

    @Resource
    private IArticleLikeRecordService articleLikeRecordService;


    @GetMapping("/hasArticleLike")
    public Result<Boolean> hasArticleLike(Integer articleId) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = user.getId();
        return Result.success(articleLikeRecordService.hasUserLikedArticle(userId, articleId));
    }

}
