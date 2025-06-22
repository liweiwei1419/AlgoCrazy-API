package com.suanfa8.algocrazyapi.service;

import com.suanfa8.algocrazyapi.dto.UserLoginDTO;
import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.dto.UserResetPasswordDTO;
import com.suanfa8.algocrazyapi.entity.User;

import java.util.List;
import java.util.Map;

public interface IUserService {

    User register(UserRegisterDTO userRegisterDTO);

    String login(UserLoginDTO userLoginDTO);

    void resetPassword(UserResetPasswordDTO userResetPasswordDTO);

    void sendVerificationCode(String username);

    Map<Long, User> getUserMapByIds(List<Long> userIds);

    // 新增方法，根据 userId 查询用户名
    String getNicknameById(Long userId);

}