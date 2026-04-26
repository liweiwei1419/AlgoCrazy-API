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

    /**
     * 分页查询用户列表
     * @param page 当前页码
     * @param size 每页大小
     * @param keyword 搜索关键词（可选）
     * @return 分页结果
     */
    com.baomidou.mybatisplus.core.metadata.IPage<User> getUserList(int page, int size, String keyword);

}