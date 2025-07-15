package com.suanfa8.algocrazyapi.service;

import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.entity.User;

import java.util.List;
import java.util.Map;

public interface IUserService {

    User register(UserRegisterDTO userRegisterDTO);

    void changePassword(String username, String oldPassword, String newPassword);

    void sendResetPasswordEmail(String usernameOrEmail);

    void resetPassword(String token, String newPassword);

    Map<Long, User> getUserMapByIds(List<Long> userIds);

    // 新增方法，根据 userId 查询用户名
    String getNicknameById(Long userId);

    User getUserByUsernameWithoutPassword(String username);

}