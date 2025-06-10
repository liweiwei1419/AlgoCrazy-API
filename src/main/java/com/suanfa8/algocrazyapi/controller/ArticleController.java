package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
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
        return articleService.articleCreate(article) == 1;
    }

    @Operation(summary = "分页查询文章列表")
    @Parameter(name = "current", description = "当前页")
    @Parameter(name = "size", description = "每页显示条数")
    @GetMapping("/page")
    public Result<IPage<Article>> getArticlePage(@RequestParam(defaultValue = "1") Integer current, @RequestParam(defaultValue = "10") Integer size) {
        log.info("current => {}", current);
        log.info("size => {}", size);
        // 创建分页对象
        Page<Article> page = new Page<>(current, size);
        // 执行分页查询
        IPage<Article> articlePage = articleService.page(page, new QueryWrapper<Article>().select("id", "title", "url", "category", "author", "created_at", "updated_at").orderByDesc("updated_at"));
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

        Article article = new Article();
        article.setId(Long.parseLong(articleUpdateDto.getId()));
        article.setAuthor(articleUpdateDto.getAuthor());
        article.setTitle(articleUpdateDto.getTitle());
        article.setCategory(articleUpdateDto.getCategory());
        article.setContent(articleUpdateDto.getContent());
        article.setParentId(Long.parseLong(articleUpdateDto.getParentId()));
        article.setSourceUrl(articleUpdateDto.getSourceUrl());
        return Result.success(articleService.update(article) == 1);
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
    public Result<ArticleDetailDto> queryByUrl(@PathVariable String url){
        Article article = articleService.queryByUrl(url);
        ArticleDetailDto articleDetailDto = new ArticleDetailDto();
        articleDetailDto.setId(article.getId());
        articleDetailDto.setContent(article.getContent());
        articleDetailDto.setTitle(article.getTitle());
        articleDetailDto.setAuthor(article.getAuthor());
        articleDetailDto.setSourceUrl(article.getSourceUrl());
        articleDetailDto.setCreatedAt(article.getCreatedAt());
        articleDetailDto.setUpdatedAt(article.getUpdatedAt());
        articleDetailDto.setLikeCount(article.getLikeCount());
        articleDetailDto.setViewCount(article.getViewCount());
        return Result.success(articleDetailDto);
    }

}
