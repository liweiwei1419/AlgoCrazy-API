package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.ArticleTreeNode;
import com.suanfa8.algocrazyapi.service.IArticleTreeService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/tree")
public class ArticleTreeController {

    @Resource
    private IArticleTreeService articleTreeService;

    // 获取完整树形结构
    @GetMapping("/all")
    public Result<List<ArticleTreeNode>> getArticleTree() {
        return Result.success(articleTreeService.getFullTree());
    }

    // 移动结点
    @PostMapping("/{id}/move")
    public Result<Void> moveArticle(@PathVariable Long id, @RequestParam Long newParentId) {
        articleTreeService.moveNode(id, newParentId);
        return Result.success();
    }

    // 调整顺序
    @PostMapping("/{id}/reorder")
    public Result<Void> reorderArticle(@PathVariable Long id, @RequestParam Integer newOrder) {
        articleTreeService.reorderNode(id, newOrder);
        return Result.success();
    }

}