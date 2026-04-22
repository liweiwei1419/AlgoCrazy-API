package com.suanfa8.algocrazyapi.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@Tag(name = "项目测试")
@RequestMapping("/hello")
@RestController
@Slf4j
public class HelloWorldController {

    // http://localhost:8890/api/v1/hello/world
    // http://106.14.3.104:8890/api/v1/hello/world
    // https://api.suanfa8.com/api/v1/hello/world


    // 文档页面：http://localhost:8888/api/v1/doc.html
    // https://crazy-
    // https://algocrazy-api.dance8.fun/api/v1/doc.html#/home

    @Operation(summary = "测试 hello world")
    @GetMapping("/world")
    public String world() {
        // 打印出当前时间
        log.info("测试，当前时间：" + LocalDateTime.now());
        return "Hello suanfa8!";
    }

}
