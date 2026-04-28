package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.dto.ChapterInfo;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;
import com.suanfa8.algocrazyapi.service.IArticleService;
import com.suanfa8.algocrazyapi.service.IExerciseSolutionService;
import com.suanfa8.algocrazyapi.utils.TextFormatter;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.ParseException;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Comparator;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/exercise-solutions")
@Tag(name = "习题解答管理", description = "习题解答相关接口")
@CacheConfig(cacheNames = "exercise-solutions")
@Slf4j
public class ExerciseSolutionController {

    @Resource
    private IExerciseSolutionService exerciseSolutionService;

    @Resource
    private IArticleService articleService;

    @GetMapping("/chapters")
    @Operation(summary = "获取章节列表", description = "获取指定父结点下的章节列表")
    @Cacheable(key = "'chapters'")
    public Result<List<ChapterInfo>> chapters(){
        // 查询 parent_id 在 (204,203,206,205) 的文章
        List<Integer> parentIds = List.of(204, 203, 206, 205);
        
        // 使用 MyBatis-Plus 查询条件：parent_id 在指定列表中
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(Article::getParentId, parentIds)
                   .eq(Article::getIsDeleted, false)
                   .orderByAsc(Article::getDisplayOrder);
        
        List<Article> articles = articleService.list(queryWrapper);
        
        // 提取章节信息并按 ID 排序
        List<ChapterInfo> chapterInfos = articles.stream()
                .map(article -> {
                    String title = article.getTitle();
                    // 从标题中提取数字作为ID，并提取章节名称
                    Integer chapterId = extractChapterId(title);
                    String chapterName = extractChapterName(title);
                    return new ChapterInfo(chapterId, chapterName);
                })
                .sorted(Comparator.comparingInt(ChapterInfo::getId)) // 按照 ID 升序排序
                .toList();
        
        return Result.success(chapterInfos);
    }

    /**
     * 从标题中提取章节ID（数字）
     * 格式如："第1章：数组" -> 1
     * "第2章：链表" -> 2
     */
    private Integer extractChapterId(String title) {
        if (title == null || title.trim().isEmpty()) {
            return 0;
        }
        
        // 使用正则表达式提取数字
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("\\d+");
        java.util.regex.Matcher matcher = pattern.matcher(title);
        
        if (matcher.find()) {
            try {
                return Integer.parseInt(matcher.group());
            } catch (NumberFormatException e) {
                return 0;
            }
        }
        
        return 0;
    }

    /**
     * 从标题中提取核心章节名称
     * 提取"章"之后、"："之前的内容
     * 格式如："第 13 章 动态规划：其实就是表格法" -> "动态规划"
     * "第1章：数组" -> "数组"
     */
    private String extractChapterName(String title) {
        if (title == null || title.trim().isEmpty()) {
            return "未知章节";
        }
        
        // 查找"章"的位置
        int chapterIndex = title.indexOf("章");
        if (chapterIndex != -1) {
            // 查找"："的位置
            int colonIndex = title.indexOf("：");
            if (colonIndex != -1 && colonIndex > chapterIndex) {
                // 提取"章"之后、"："之前的文本
                return title.substring(chapterIndex + 1, colonIndex).trim();
            } else {
                // 如果没有"："，提取"章"之后的所有文本
                return title.substring(chapterIndex + 1).trim();
            }
        }
        
        // 如果没有"章"，查找"："的位置
        int colonIndex = title.indexOf("：");
        if (colonIndex != -1) {
            // 提取"："之前的文本
            return title.substring(0, colonIndex).trim();
        }
        
        // 如果都没有，返回原标题
        return title;
    }


    @GetMapping
    @Operation(summary = "获取习题解答列表", description = "分页获取习题解答列表")
    public Result<IPage<ExerciseSolution>> getList(
            @Parameter(description = "页码") @RequestParam(defaultValue = "1") Integer page,
            @Parameter(description = "每页大小") @RequestParam(defaultValue = "10") Integer size,
            @Parameter(description = "搜索关键词") @RequestParam(required = false) String keyword,
            @Parameter(description = "难度级别") @RequestParam(required = false) String difficulty,
            @Parameter(description = "分类") @RequestParam(required = false) String category,
            @Parameter(description = "章节序号") @RequestParam(required = false) String chapterNumber,
            @Parameter(description = "LeetCode题号") @RequestParam(required = false) String leetcodeNumber,
            @Parameter(description = "发布状态") @RequestParam(required = false) Boolean isPublished) {

        log.info("获取习题解答列表，参数：{}",
                new Object[]{page, size, keyword, difficulty, category, chapterNumber, leetcodeNumber, isPublished});


        IPage<ExerciseSolution> pageList = exerciseSolutionService.getPageList(page, size, keyword, difficulty, category, chapterNumber, leetcodeNumber, isPublished);
        return Result.success(pageList);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @GetMapping("/{id}")
    @Operation(summary = "根据 ID 获取习题解答", description = "根据 ID 获取习题解答详情")
    public Result<ExerciseSolution> getById(@PathVariable Integer id) {
        ExerciseSolution exerciseSolution = exerciseSolutionService.getById(id);
        if (exerciseSolution == null || exerciseSolution.getIsDeleted()) {
            return Result.fail(ResultCode.EXERCISE_SOLUTION_NOT_FOUND);
        }
        return Result.success(exerciseSolution);
    }


    @GetMapping("/url/**")
    @Operation(summary = "根据 URL 获取习题解答", description = "根据 URL 获取习题解答详情，URL 格式如 chapter02/leetcode/0493-reverse-pairs")
    public Result<ExerciseSolution> getByUrl(HttpServletRequest request) {
        // 提取 URL 路径（取 /exercise-solutions/url/ 后面的字符串）
        String requestUri = request.getRequestURI();
        String prefix = "/exercise-solutions/url/";
        String url = requestUri.substring(requestUri.indexOf(prefix) + prefix.length());
        ExerciseSolution exerciseSolution = exerciseSolutionService.getByUrl(url);
        if (exerciseSolution == null) {
            return Result.fail(ResultCode.EXERCISE_SOLUTION_NOT_FOUND);
        }
        return Result.success(exerciseSolution);
    }

    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PostMapping
    @Operation(summary = "创建习题解答", description = "创建新的习题解答")
    public Result<ExerciseSolution> create(@RequestBody ExerciseSolution exerciseSolution) {
        boolean success = exerciseSolutionService.save(exerciseSolution);
        if (success) {
            return Result.success(exerciseSolution);
        }
        return Result.fail(ResultCode.CREATE_FAILED);
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新习题解答", description = "根据 ID 更新习题解答")
    public Result<ExerciseSolution> update(@PathVariable Integer id, @RequestBody ExerciseSolution exerciseSolution) {
        exerciseSolution.setId(id);
        boolean success = exerciseSolutionService.updateById(exerciseSolution);
        if (success) {
            return Result.success(exerciseSolution);
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除习题解答", description = "根据ID删除习题解答（软删除）")
    public Result<Void> delete(@PathVariable Integer id) {
        ExerciseSolution exerciseSolution = exerciseSolutionService.getById(id);
        if (exerciseSolution == null) {
            return Result.fail(ResultCode.EXERCISE_SOLUTION_NOT_FOUND);
        }
        exerciseSolution.setIsDeleted(true);
        boolean success = exerciseSolutionService.updateById(exerciseSolution);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.DELETE_FAILED);
    }

    @GetMapping("/parent/{parentId}")
    @Operation(summary = "根据父 ID 获取子习题列表", description = "获取指定父结点下的所有子习题")
    public Result<List<ExerciseSolution>> getChildrenByParentId(@PathVariable Integer parentId) {
        List<ExerciseSolution> children = exerciseSolutionService.getChildrenByParentId(parentId);
        return Result.success(children);
    }

    @GetMapping("/difficulty/{difficulty}")
    @Operation(summary = "根据难度级别获取习题列表", description = "获取指定难度级别的习题列表")
    public Result<List<ExerciseSolution>> getByDifficulty(@PathVariable String difficulty) {
        List<ExerciseSolution> list = exerciseSolutionService.getByDifficulty(difficulty);
        return Result.success(list);
    }

    @GetMapping("/category/{category}")
    @Operation(summary = "根据分类获取习题列表", description = "获取指定分类的习题列表")
    public Result<List<ExerciseSolution>> getByCategory(@PathVariable String category) {
        List<ExerciseSolution> list = exerciseSolutionService.getByCategory(category);
        return Result.success(list);
    }

    @GetMapping("/chapter/{chapterNumber}")
    @Operation(summary = "根据章节序号获取习题列表", description = "获取指定章节序号的习题列表")
    public Result<List<ExerciseSolution>> getByChapterNumber(@PathVariable String chapterNumber) {
        List<ExerciseSolution> list = exerciseSolutionService.getByChapterNumber(chapterNumber);
        return Result.success(list);
    }

    @GetMapping("/leetcode/{leetcodeNumber}")
    @Operation(summary = "根据「力扣」题号获取习题", description = "根据「力扣」题号获取习题详情")
    public Result<ExerciseSolution> getByLeetcodeNumber(@PathVariable String leetcodeNumber) {
        ExerciseSolution exerciseSolution = exerciseSolutionService.getByLeetcodeNumber(leetcodeNumber);
        if (exerciseSolution == null) {
            return Result.fail(ResultCode.EXERCISE_SOLUTION_NOT_FOUND);
        }
        return Result.success(exerciseSolution);
    }

    @GetMapping("/old-content/leetcode/{leetcodeNumber}")
    @Operation(summary = "获取旧文章", description = "根据力扣题号获取旧文章内容")
    public Result<Object> getOldArticle(@PathVariable String leetcodeNumber) {
        try {
            String url = "https://old-suanfa8-api.dance8.fun/api/v2/article/content/leetcode/" + leetcodeNumber;
            
            // 使用 Apache HttpClient 5 发送 HTTP 请求
            try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
                HttpGet httpGet = new HttpGet(url);
                try (CloseableHttpResponse response = httpClient.execute(httpGet)) {
                    String responseBody = EntityUtils.toString(response.getEntity());
                    ObjectMapper mapper = new ObjectMapper();
                    // 先解析为 Map
                    Map<?, ?> responseMap = mapper.readValue(responseBody, Map.class);
                    // 提取 data 部分
                    Object data = responseMap.get("data");
                    if (data instanceof java.util.Map) {
                        // 提取 content 字段
                        java.util.Map<?, ?> dataMap = (java.util.Map<?, ?>) data;
                        Object content = dataMap.get("content");
                        if (content != null) {
                            return Result.success(content);
                        }
                    }
                    // 如果没有 content 字段，返回空
                    return Result.success("");
                }
            } catch (ParseException e) {
                e.printStackTrace();
                return Result.fail(ResultCode.GET_OLD_ART_FAILED);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(ResultCode.GET_OLD_ART_FAILED);
        }
    }

    @PostMapping("/format-text")
    @Operation(summary = "格式化文本", description = "根据指定规则格式化文本内容")
    public Result<String> formatText(@Parameter(description = "待格式化的文本") @RequestBody String text) {
        String formattedText = TextFormatter.formatText(text);
        return Result.success(formattedText);
    }


    @GetMapping("/tree")
    @Operation(summary = "获取树形结构的习题列表", description = "获取完整的树形结构习题列表")
    public Result<List<ExerciseSolution>> getTreeList() {
        List<ExerciseSolution> treeList = exerciseSolutionService.getTreeList();
        return Result.success(treeList);
    }


    @GetMapping("/children/{parentId}")
    @Operation(summary = "获取所有子结点", description = "获取指定结点的所有子结点（包括孙子结点）")
    public Result<List<ExerciseSolution>> getAllChildren(@PathVariable Integer parentId) {
        List<ExerciseSolution> children = exerciseSolutionService.getAllChildren(parentId);
        return Result.success(children);
    }

    @GetMapping("/published/{isPublished}")
    @Operation(summary = "根据发布状态获取习题列表", description = "获取指定发布状态的习题列表")
    public Result<List<ExerciseSolution>> getByPublishStatus(@PathVariable Boolean isPublished) {
        List<ExerciseSolution> list = exerciseSolutionService.getByPublishStatus(isPublished);
        return Result.success(list);
    }

    @PutMapping("/publish/batch")
    @Operation(summary = "批量更新发布状态", description = "批量更新习题的发布状态")
    public Result<Void> batchUpdatePublishStatus(@RequestBody Map<String, Object> request) {
        List<Integer> ids = (List<Integer>) request.get("ids");
        Boolean isPublished = (Boolean) request.get("isPublished");
        
        if (ids == null || ids.isEmpty()) {
            return Result.fail(ResultCode.PARAM_ERROR);
        }
        
        boolean success = exerciseSolutionService.batchUpdatePublishStatus(ids, isPublished);
        if (success) {
            return Result.success();
        }
        return Result.fail(ResultCode.UPDATE_FAILED);
    }


    @PutMapping("/replace-images/{id}")
    @Operation(summary = "替换图片", description = "将 Markdown 中的图片上传到 MinIO 并替换为本站链接")
    public Result<Void> replaceImages(@PathVariable Integer id) {
        try {
            boolean success = exerciseSolutionService.replaceImages(id);
            if (success) {
                return Result.success();
            }
            return Result.fail(ResultCode.UPDATE_FAILED);
        } catch (Exception e) {
            log.error("替换图片失败", e);
            return Result.fail(ResultCode.FAILED);
        }
    }

}