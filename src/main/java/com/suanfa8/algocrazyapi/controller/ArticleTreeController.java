package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.ArticleTreeNode;
import com.suanfa8.algocrazyapi.dto.BookTreeNode;
import com.suanfa8.algocrazyapi.service.IArticleTreeService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/tree")
public class ArticleTreeController {

    @Resource
    private IArticleTreeService articleTreeService;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    private static final String CACHE_KEY = "article:fullTree";

    // 获取完整树形结构，用于测试
    @GetMapping("/all")
    @Cacheable(value = "articleFullTree", key = "'article:fullTree'", unless = "#result == null")
    public Result<List<ArticleTreeNode>> getArticleTree() {
        List<ArticleTreeNode> tree = articleTreeService.getFullTree();
        List<ArticleTreeNode> result = tree != null ? tree : Collections.emptyList();
        return Result.success(result);
    }


    // 用于书本目录
    @GetMapping("/book")
    @Cacheable(value = "bookFullTree", key = "'book:fullTree'", unless = "#result == null")
    public Result<List<BookTreeNode>> getBookTree() {
        List<BookTreeNode> tree = articleTreeService.getBookTree();
        List<BookTreeNode> result = tree != null ? tree : Collections.emptyList();
        return Result.success(result);
    }


    // 当数据更新时清除缓存
    @CacheEvict(value = {"articleFullTree", "bookFullTree"}, key = "'article:fullTree', 'book:fullTree'")
    public void clearCache() {
        try {
            redisTemplate.delete(CACHE_KEY);
        } catch (Exception e) {
            // 清除缓存失败不影响主流程
        }
    }

    // 移动结点
    @PostMapping("/{id}/move")
    @CacheEvict(value = {"articleFullTree", "bookFullTree"}, key = "'article:fullTree', 'book:fullTree'")
    public Result<Void> moveArticle(@PathVariable Integer id, @RequestParam Integer newParentId) {
        articleTreeService.moveNode(id, newParentId);
        return Result.success();
    }


    // 调整顺序
    @CacheEvict(value = {"articleFullTree", "bookFullTree"}, key = "'article:fullTree', 'book:fullTree'")
    @PostMapping("/{id}/reorder")
    public Result<Void> reorderArticle(@PathVariable Integer id, @RequestParam Integer newOrder) {
        articleTreeService.reorderNode(id, newOrder);
        return Result.success();
    }

}