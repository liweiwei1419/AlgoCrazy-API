package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.dto.UserLoginDTO;
import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.dto.UserResetPasswordDTO;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public User register(@RequestBody UserRegisterDTO userRegisterDTO) {
        return userService.register(userRegisterDTO);
    }

    @PostMapping("/login")
    public String login(@RequestBody UserLoginDTO userLoginDTO) {
        return userService.login(userLoginDTO);
    }

    @PostMapping("/resetPassword")
    public void resetPassword(@RequestBody UserResetPasswordDTO userResetPasswordDTO) {
        userService.resetPassword(userResetPasswordDTO);
    }
}