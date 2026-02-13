package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.dto.OneSentenceSolutionUpdateDto;
import com.suanfa8.algocrazyapi.dto.SuggestionUpdateDto;
import com.suanfa8.algocrazyapi.dto.TitleAndIdSelectDto;
import com.suanfa8.algocrazyapi.dto.article.ArticleAddDto;
import com.suanfa8.algocrazyapi.dto.article.ArticleDetailDto;
import com.suanfa8.algocrazyapi.dto.article.ArticleLikeDto;
import com.suanfa8.algocrazyapi.dto.article.ArticleUpdateDto;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.IArticleService;
import com.suanfa8.algocrazyapi.utils.UploadUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
@Tag(name = "文章")
@RequestMapping("/article")
@RestController
public class ArticleController {

    @Resource
    private IArticleService articleService;

    @Resource
    private UploadUtils uploadUtils;

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

        // 处理 parentId，为空时设置为 null
        if (StringUtils.isEmpty(articleAddDto.getParentId())) {
            article.setParentId(null);
        } else {
            article.setParentId(Integer.parseInt(articleAddDto.getParentId()));
        }

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
    public Result<Article> getArticleById(@PathVariable Integer id) {
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

    @Operation(summary = "供单选框使用，获得所有文章的标题和 id")
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
    @PostMapping("/incrementLikeCount")
    public Result<Boolean> incrementLikeCount(@RequestBody ArticleLikeDto articleLikeDto) {
        Integer articleId = articleLikeDto.getArticleId();
        log.info("文章点赞 => {}", articleId);
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = user.getId();
        return Result.success(articleService.likeArticle(userId, articleId));
    }

    @GetMapping("/{id}/download")
    public ResponseEntity<InputStreamResource> downloadArticleAsMarkdown(@PathVariable Long id) {
        Article article = articleService.getOptById(id).orElseThrow(() -> new RuntimeException("Article not found with id: " + id));
        return articleService.downloadArticleAsMarkdown(article);
    }

    @Operation(summary = "获得所有二级目录，在「审核进度」页面")
    @GetMapping("/chapters")
    // @Cacheable(value = "articleChapters", key = "'article:chapters:list'")
    public Result<List<Article>> chapters() {
        log.info("查询数据库，获得所有二级目录，在「审核进度」页面");
        QueryWrapper<Article> queryWrapper = new QueryWrapper<>();
        // parent_id 不等于 0，parent_id = 0 是一级目录
        // is_folder 等于 true，is_folder 等于 false 是文章
        queryWrapper.ne("parent_id", 0).eq("is_folder", true).orderByAsc("id");
        List<Article> articleList = articleService.list(queryWrapper);
        return Result.success(articleList);
    }

    @GetMapping("/chapter/{id}")
    public Result<List<Article>> chapters(@PathVariable("id") Long id) {
        // 缓存未命中或类型不匹配，查询数据库
        QueryWrapper<Article> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("id", "title", "author", "parent_id", "display_order", "created_at", "updated_at", "view_count", "like_count", "book_check", "suggestion", "one_sentence_solution", "source_url", "solution_url").eq("parent_id", id).eq("is_folder", false).orderByAsc("display_order");
        List<Article> articleList = articleService.list(queryWrapper);
        return Result.success(articleList);
    }

    @GetMapping("/toggleBookCheck/{id}")
    public Result<Boolean> toggleBookCheck(@PathVariable("id") Long id) {
        // 先获取当前文章的 book_check 状态
        Article article = articleService.getById(id);
        // 切换 book_check 状态
        boolean newBookCheck = !article.getBookCheck();
        // 更新数据库
        // 3. 使用 LambdaUpdateWrapper 仅更新 book_check 字段
        boolean isUpdated = articleService.lambdaUpdate().eq(Article::getId, id).set(Article::getBookCheck, newBookCheck).update();
        return isUpdated ? Result.success(newBookCheck) : Result.fail(ResultCode.FAILED);
    }

    @PostMapping("/suggestion/")
    public Result<Boolean> updateSuggestion(@RequestBody SuggestionUpdateDto suggestionUpdateDto) {
        // 标准 update 方法，只修改一个字段
        boolean isUpdated = articleService.lambdaUpdate().eq(Article::getId, suggestionUpdateDto.getId()).set(Article::getSuggestion, suggestionUpdateDto.getSuggestion()).update();
        return isUpdated ? Result.success(isUpdated) : Result.fail(ResultCode.FAILED);
    }

    @PostMapping("/oneSentenceSolution/")
    public Result<Boolean> updateOneSentenceSolution(@RequestBody OneSentenceSolutionUpdateDto oneSentenceSolutionUpdateDto) {
        // 标准 update 方法，只修改一个字段
        boolean isUpdated = articleService.lambdaUpdate().eq(Article::getId, oneSentenceSolutionUpdateDto.getId()).set(Article::getOneSentenceSolution, oneSentenceSolutionUpdateDto.getOneSentenceSolution()).update();
        return isUpdated ? Result.success(isUpdated) : Result.fail(ResultCode.FAILED);
    }

    @GetMapping("/uploadLeetcodeImageToCOS/{id}")
    public Result<Boolean> uploadLeetcodeImageToCOS(@PathVariable Long id) {
        // 先根据 id 查询 Article 的文章内容
        Article article = articleService.getById(id);

        if (article == null) {
            return Result.fail(500, "文章不存在");
        }
        String content = article.getContent();
        if (content == null) {
            return Result.success(true);
        }

        // 用于存储替换后的新内容
        StringBuilder newContentBuilder = new StringBuilder();
        // 正则表达式匹配 Markdown 图片链接
        Pattern pattern = Pattern.compile("!\\[[^\\]]*\\]\\(([^)]+)\\)");
        Matcher matcher = pattern.matcher(content);
        int lastIndex = 0;

        while (matcher.find()) {
            // 提取匹配到的图片链接
            String oldUrl = matcher.group(1);
            // 将匹配到的链接之前的内容添加到新内容中
            newContentBuilder.append(content, lastIndex, matcher.start(1));

            try {
                String prefix = article.getUrl();
                // 调用上传工具类将图片上传到 COS
                String newUrl = uploadUtils.uploadByUrlToMinio(prefix, oldUrl);
                // 将新链接添加到新内容中
                newContentBuilder.append(newUrl);
            } catch (Exception e) {
                log.error("图片上传失败，链接: {}", oldUrl, e);
                // 上传失败则保留原链接
                newContentBuilder.append(oldUrl);
            }
            // 更新 lastIndex 为匹配到的链接之后的位置
            lastIndex = matcher.end(1);
        }
        // 添加剩余的内容
        newContentBuilder.append(content.substring(lastIndex));

        // 获取替换后的新内容
        String newContent = newContentBuilder.toString();
        // 更新 Article 的 content 为新的 content
        article.setContent(newContent);
        boolean isUpdated = articleService.updateById(article);
        return isUpdated ? Result.success(true) : Result.fail(500, "文章内容更新失败");
    }

}
