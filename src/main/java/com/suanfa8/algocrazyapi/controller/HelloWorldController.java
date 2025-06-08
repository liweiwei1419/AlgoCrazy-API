package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.entity.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RequestMapping("/hello")
@RestController
public class HelloWorldController {

    // http://localhost:8888/api/v1/hello/world

    @GetMapping("/world")
    public User world() {
        System.out.println("123456");
        return new User(1419L, "liweiwei1419", "123456");
    }

}
