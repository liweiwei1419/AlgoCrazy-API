package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.suanfa8.algocrazyapi.dto.UserLoginDTO;
import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.dto.UserResetPasswordDTO;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.UserMapper;
import com.suanfa8.algocrazyapi.service.UserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Override
    public User register(UserRegisterDTO userRegisterDTO) {
        // 检查用户名是否已存在
        User existingUser = userMapper.selectOne(new QueryWrapper<User>().eq("username", userRegisterDTO.getUsername()));
        if (existingUser != null) {
            throw new RuntimeException("用户名已存在");
        }

        User user = new User();
        BeanUtils.copyProperties(userRegisterDTO, user);
        user.setPassword(passwordEncoder.encode(userRegisterDTO.getPassword()));
        user.setCreateTime(LocalDateTime.now());
        user.setUpdateTime(LocalDateTime.now());
        userMapper.insert(user);
        return user;
    }

    @Override
    public String login(UserLoginDTO userLoginDTO) {
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(userLoginDTO.getUsername(), userLoginDTO.getPassword()));
        // 这里需要集成 JWT 生成 token，假设已经有 JwtUtil 类
        // return JwtUtil.generateToken(authentication.getName());
        return "mock_token";
    }

    @Override
    public void resetPassword(UserResetPasswordDTO userResetPasswordDTO) {
        User user = userMapper.selectOne(new QueryWrapper<User>().eq("email", userResetPasswordDTO.getEmail()));
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        user.setPassword(passwordEncoder.encode(userResetPasswordDTO.getNewPassword()));
        user.setUpdateTime(LocalDateTime.now());
        userMapper.updateById(user);
    }
}