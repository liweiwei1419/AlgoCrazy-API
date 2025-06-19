package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.dto.UserLoginDTO;
import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.dto.UserResetPasswordDTO;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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


    @PostMapping("/send-verification-code")
    public ResponseEntity<?> sendVerificationCode(String username) {
        userService.sendVerificationCode(username);
        return ResponseEntity.ok("验证码已发送");
    }


    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody UserResetPasswordDTO userResetPasswordDTO) {
        try {
            userService.resetPassword(userResetPasswordDTO);
            return ResponseEntity.ok("密码重置成功");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}