package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

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
    public String world() {
        return "Hello from SpringBoot!";
    }


    @Operation(summary = "测试资源受限方法")
    @GetMapping("/download")
    @PreAuthorize("hasRole('ROLE_USER')")
    public String download() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        if (securityContext.getAuthentication() != null) {
            User user = (User) securityContext.getAuthentication().getPrincipal();
            return "Hello " + user.getUsername() + "!";
        }
        return "Hello Download!";
    }


    @PostMapping ("/greet")
    public String world(@RequestBody Map<String, String> request) {
        String name = request.get("name");
        return "hello " + name;
    }

}
