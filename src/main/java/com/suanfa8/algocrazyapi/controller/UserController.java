package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;


    @PostMapping("/register")
    public User register(@RequestBody UserRegisterDTO userRegisterDTO) {
        return userService.register(userRegisterDTO);
    }


    /**
     * 登录后修改密码
     * @param request 包含原始密码和新密码的请求体
     * @return 响应实体
     */
    @PostMapping("/change-password")
    public ResponseEntity<?> changePassword(@RequestBody Map<String, String> request) {
        // 从安全上下文中获取认证信息
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        String oldPassword = request.get("oldPassword");
        String newPassword = request.get("newPassword");

        if (oldPassword == null || newPassword == null) {
            return ResponseEntity.badRequest().body("原始密码和新密码不能为空");
        }

        try {
            userService.changePassword(username, oldPassword, newPassword);
            return ResponseEntity.ok().body("密码修改成功");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }


    @PostMapping("/forgot-password")
    public ResponseEntity<?> forgotPassword(@RequestBody Map<String, String> body) {
        String usernameOrEmail = body.get("usernameOrEmail");
        userService.sendResetPasswordEmail(usernameOrEmail);
        return ResponseEntity.ok().build();
    }


    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody Map<String, String> body) {
        String token = body.get("token");
        String newPassword = body.get("newPassword");
        userService.resetPassword(token, newPassword);
        return ResponseEntity.ok().build();
    }

    /**
     * 根据用户名查询用户信息，不返回密码，用于展示用户主页
     * @param username 用户名
     * @return 用户信息
     */
    @GetMapping("/homepage/{username}")
    public Result<User> getUserByUsername(@PathVariable String username) {
        User user = userService.getUserByUsernameWithoutPassword(username);
        if (user == null) {
            return Result.fail(ResultCode.USER_NOT_FOUND);
        }
        return Result.success(user);
    }

}