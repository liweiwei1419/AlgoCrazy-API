package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.service.IArticleService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;


@CrossOrigin
@RequestMapping("/article")
@RestController
@Slf4j
public class ArticleController {

    @Resource
    private IArticleService articleService;

    @GetMapping("/hello")
    public String articleCreate() {
        return "1";
    }

    @PostMapping("/create")
    public Boolean articleCreate(@RequestBody Article article) {
        log.info("创建文章 => {}", article);
        return articleService.save(article);
    }

    /**
     * 分页查询文章列表
     *
     * @param current 当前页
     * @param size    每页显示条数
     * @return 分页结果
     */
    @GetMapping("/page")
    public Map<String, Object> getArticlePage(@RequestParam(defaultValue = "1") Integer current, @RequestParam(defaultValue = "10") Integer size) {
        // 创建分页对象
        Page<Article> page = new Page<>(current, size);
        // 执行分页查询
        IPage<Article> articlePage = articleService.page(page, new QueryWrapper<Article>().orderByDesc("create_time"));
        // 封装返回数据
        Map<String, Object> res = new HashMap<>();
        res.put("total", articlePage.getTotal());      // 总记录数
        res.put("current", articlePage.getCurrent());  // 当前页
        res.put("size", articlePage.getSize());        // 每页条数
        res.put("pages", articlePage.getPages());     // 总页数
        res.put("records", articlePage.getRecords());  // 数据列表
        return res;
    }

}
