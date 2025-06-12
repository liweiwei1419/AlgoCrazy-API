package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.ArticleAddDto;
import com.suanfa8.algocrazyapi.dto.ArticleDetailDto;
import com.suanfa8.algocrazyapi.dto.ArticleUpdateDto;
import com.suanfa8.algocrazyapi.dto.TitleAndIdSelectDto;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.service.IArticleService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Tag(name = "文章")
@CrossOrigin
@RequestMapping("/article")
@RestController
@Slf4j
public class ArticleController {

    @Resource
    private IArticleService articleService;

    @Operation(summary = "创建文章")
    @Parameter(name = "article", description = "文章对象", required = true)
    @PostMapping("/create")
    public Boolean articleCreate(@RequestBody ArticleAddDto articleAddDto) {
        log.info("创建文章 => {}", articleAddDto);

        Article article = new Article();
        article.setAuthor(articleAddDto.getAuthor());
        article.setTitle(articleAddDto.getTitle());
        article.setCategory(articleAddDto.getCategory());
        article.setContent(articleAddDto.getContent());
        article.setParentId(Long.parseLong(articleAddDto.getParentId()));
        article.setSourceUrl(articleAddDto.getSourceUrl());
        article.setSolutionUrl(articleAddDto.getSolutionUrl());
        return articleService.articleCreate(article) == 1;
    }

    @Operation(summary = "分页查询文章列表")
    @Parameter(name = "current", description = "当前页")
    @Parameter(name = "size", description = "每页显示条数")
    @Parameter(name = "keyword", required = false, description = "搜索关键字")
    @GetMapping("/page")
    public Result<IPage<Article>> getArticlePage(@RequestParam(defaultValue = "1") Integer current, @RequestParam(defaultValue = "10") Integer size, @RequestParam("title") String keyword) {
        log.info("current => {}", current);
        log.info("size => {}", size);
        log.info("keyword => {}", keyword);
        // 创建分页对象
        Page<Article> page = new Page<>(current, size);
        // 创建查询条件
        QueryWrapper<Article> queryWrapper = new QueryWrapper<Article>().select("id", "title", "url", "category", "created_at", "updated_at", "view_count", "like_count").eq("is_folder", false).eq("like_count", 0).orderByDesc("updated_at");
        // 如果传入了 title 参数，则添加模糊查询条件
        if (StringUtils.isNotBlank(keyword)) {
            queryWrapper.like("title", keyword);
        }
        // 执行分页查询
        IPage<Article> articlePage = articleService.page(page, queryWrapper);
        return Result.success(articlePage);
    }


    @Operation(summary = "根据 ID 查询单个文章")
    @Parameter(name = "id", required = true, description = "文章 ID", in = ParameterIn.PATH)
    @GetMapping("/{id}")
    public Result<Article> getArticleById(@PathVariable Long id) {
        log.info("查询文章 => {}", id);
        // 先增加阅读量
        articleService.lambdaUpdate().eq(Article::getId, id).setSql("view_count = view_count + 1").update();
        // 再查询文章
        Article article = articleService.getById(id);
        if (article == null) {
            return Result.fail(500, "文章不存在");
        }
        return Result.success(article);
    }


    @Operation(summary = "更新文章")
    @Parameter(name = "article", description = "文章对象", required = true)
    @PutMapping("/update")
    public Result<Boolean> updateArticle(@RequestBody ArticleUpdateDto articleUpdateDto) {
        log.info("更新文章 => {}", articleUpdateDto);
        LambdaUpdateWrapper<Article> lambdaUpdateWrapper = Wrappers.<Article>lambdaUpdate().eq(Article::getId, Long.parseLong(articleUpdateDto.getId()))
                // 仅当 DTO 字段非空时更新
                .set(StringUtils.isNotBlank(articleUpdateDto.getTitle()), Article::getTitle, articleUpdateDto.getTitle())
                // 更新 content
                .set(StringUtils.isNotBlank(articleUpdateDto.getContent()), Article::getContent, articleUpdateDto.getContent())
                // 更新作者
                .set(StringUtils.isNotBlank(articleUpdateDto.getAuthor()), Article::getAuthor, articleUpdateDto.getAuthor())
                // 更新分类
                .set(StringUtils.isNotBlank(articleUpdateDto.getCategory()), Article::getCategory, articleUpdateDto.getCategory())
                // 更新父结点 id
                .set(StringUtils.isNotBlank(articleUpdateDto.getParentId()), Article::getParentId, Long.parseLong(articleUpdateDto.getParentId()))
                // 更新原题链接
                .set(StringUtils.isNotBlank(articleUpdateDto.getSourceUrl()), Article::getSourceUrl, articleUpdateDto.getSourceUrl())
                // 更新题解链接
                .set(StringUtils.isNotBlank(articleUpdateDto.getSolutionUrl()), Article::getSolutionUrl, articleUpdateDto.getSolutionUrl())
                // 更新时间一直都要更新
                .set(true, Article::getUpdatedAt, LocalDateTime.now());
        return Result.success(articleService.update(lambdaUpdateWrapper));

    }


    @Operation(summary = "删除文章")
    @Parameter(name = "id", required = true, description = "文章 ID", in = ParameterIn.PATH)
    @DeleteMapping("/{id}")
    public Result<Boolean> deleteArticle(@PathVariable Long id) {
        log.info("删除文章 => {}", id);
        boolean result = articleService.removeById(id);
        return Result.success(result);
    }


    @GetMapping("/articles")
    public Result<List<TitleAndIdSelectDto>> getTitleAndIdSelect() {
        List<Article> titleAndIdSelect = articleService.getTitleAndIdSelect();
        List<TitleAndIdSelectDto> titleAndIdSelectDtos = new ArrayList<>();
        for (Article article : titleAndIdSelect) {
            TitleAndIdSelectDto titleAndIdSelectDto = new TitleAndIdSelectDto();
            titleAndIdSelectDto.setId(article.getId().toString());
            titleAndIdSelectDto.setTitle(article.getTitle());
            titleAndIdSelectDtos.add(titleAndIdSelectDto);
        }
        return Result.success(titleAndIdSelectDtos);
    }

    @GetMapping("/book/{url}")
    public Result<ArticleDetailDto> queryByUrl(@PathVariable String url) {
        articleService.lambdaUpdate().eq(Article::getUrl, url).setSql("view_count = view_count + 1").update();
        Article article = articleService.queryByUrl(url);
        ArticleDetailDto articleDetailDto = new ArticleDetailDto();
        articleDetailDto.setId(article.getId());
        articleDetailDto.setContent(article.getContent());
        articleDetailDto.setTitle(article.getTitle());
        articleDetailDto.setAuthor(article.getAuthor());
        articleDetailDto.setSourceUrl(article.getSourceUrl());
        articleDetailDto.setSolutionUrl(article.getSolutionUrl());
        articleDetailDto.setCreatedAt(article.getCreatedAt());
        articleDetailDto.setUpdatedAt(article.getUpdatedAt());
        articleDetailDto.setLikeCount(article.getLikeCount());
        articleDetailDto.setViewCount(article.getViewCount());
        return Result.success(articleDetailDto);
    }


    @Operation(summary = "文章点赞")
    @Parameter(name = "id", required = true, description = "文章 ID", in = ParameterIn.PATH)
    @PostMapping("/{id}/like")
    public Result<Boolean> incrementLikeCount(@PathVariable Long id) {
        log.info("文章点赞 => {}", id);
        boolean result = articleService.incrementLikeCount(id);
        return Result.success(result);
    }

    @GetMapping("/{id}/download")
    public ResponseEntity<InputStreamResource> downloadArticleAsMarkdown(@PathVariable Long id) {
        Article article = articleService.getOptById(id).orElseThrow(() -> new RuntimeException("Article not found with id: " + id));
        return articleService.downloadArticleAsMarkdown(article);
    }

    @GetMapping("/chapters")
    public Result<List<Article>> chapters() {
        QueryWrapper<Article> queryWrapper = new QueryWrapper<>();
        queryWrapper.ne("parent_id", 0).eq("is_folder", true).orderByAsc("id");
        List<Article> articleList = articleService.list(queryWrapper);
        return Result.success(articleList);
    }

    @GetMapping("/chapter/{id}")
    public Result<List<Article>> chapters(@PathVariable("id") Long id) {
        QueryWrapper<Article> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("id", "title", "author", "parent_id", "display_order", "created_at", "updated_at", "view_count", "like_count").eq("parent_id", id).eq("is_folder", false).orderByAsc("display_order");
        List<Article> articleList = articleService.list(queryWrapper);
        return Result.success(articleList);
    }

}
