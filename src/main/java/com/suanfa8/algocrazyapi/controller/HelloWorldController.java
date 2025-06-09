package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "项目测试")
@RequestMapping("/hello")
@RestController
public class HelloWorldController {

    // http://localhost:8888/api/v1/hello/world
    // http://110.42.230.190:8888/api/v1/hello/world
    // 文档页面：http://localhost:8888/api/v1/doc.html
    // https://algocrazy-api.dance8.fun/api/v1/hello/world
    // https://algocrazy-api.dance8.fun/api/v1/doc.html#/home

    @Operation(summary = "测试 hello world")
    @GetMapping("/world")
    public User world() {
        System.out.println("123456");
        return new User(1419L, "liweiwei1419", "123456");
    }

}
