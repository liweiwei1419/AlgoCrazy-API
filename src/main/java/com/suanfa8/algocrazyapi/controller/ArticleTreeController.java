package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.ArticleTreeNode;
import com.suanfa8.algocrazyapi.dto.BookTreeNode;
import com.suanfa8.algocrazyapi.service.IArticleTreeService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Slf4j
@RestController
@RequestMapping("/tree")
public class ArticleTreeController {

    @Resource
    private IArticleTreeService articleTreeService;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    private static final String CACHE_KEY = "article:fullTree";
    private static final String BOOK_CACHE_KEY = "book:fullTree";
    private static final long CACHE_EXPIRE_HOURS = 1;

    // 获取完整树形结构，用于测试
    @GetMapping("/all")
    public Result<List<ArticleTreeNode>> getArticleTree() {
        // 尝试从缓存获取
        List<ArticleTreeNode> cached = getFromCache();
        if (cached != null) {
            return Result.success(cached);
        }
        // 从数据库获取
        List<ArticleTreeNode> tree = articleTreeService.getFullTree();
        List<ArticleTreeNode> result = tree != null ? tree : Collections.emptyList();
        // 存入缓存
        saveToCache(result);
        return Result.success(result);
    }

    // 用于书本目录
    @GetMapping("/book")
    public Result<List<BookTreeNode>> getBookTree() {
        // 尝试从缓存获取
        List<BookTreeNode> cached = getFromCacheBook();
        if (cached != null) {
            return Result.success(cached);
        }
        // 从数据库获取
        List<BookTreeNode> tree = articleTreeService.getBookTree();
        List<BookTreeNode> result = tree != null ? tree : Collections.emptyList();
        // 存入缓存
        saveToCacheBook(result);
        return Result.success(result);
    }

    private List<BookTreeNode> getFromCacheBook() {
        try {
            return (List<BookTreeNode>) redisTemplate.opsForValue().get(BOOK_CACHE_KEY);
        } catch (Exception e) {
            // 缓存获取失败时直接返回null，走数据库查询
            return null;
        }
    }

    private List<ArticleTreeNode> getFromCache() {
        try {
            return (List<ArticleTreeNode>) redisTemplate.opsForValue().get(CACHE_KEY);
        } catch (Exception e) {
            // 缓存获取失败时直接返回null，走数据库查询
            return null;
        }
    }

    private void saveToCache(List<ArticleTreeNode> tree) {
        try {
            redisTemplate.opsForValue().set(CACHE_KEY, tree, CACHE_EXPIRE_HOURS, TimeUnit.HOURS);
        } catch (Exception e) {
            // 缓存失败不影响主流程
        }
    }
    private void saveToCacheBook(List<BookTreeNode> tree) {
        try {
            redisTemplate.opsForValue().set(BOOK_CACHE_KEY, tree, CACHE_EXPIRE_HOURS, TimeUnit.HOURS);
        } catch (Exception e) {
            // 缓存失败不影响主流程
        }
    }

    // 当数据更新时清除缓存
    public void clearCache() {
        try {
            redisTemplate.delete(CACHE_KEY);
        } catch (Exception e) {
            // 清除缓存失败不影响主流程
        }
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