package com.suanfa8.algocrazyapi.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.suanfa8.algocrazyapi.entity.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.Optional;

@Mapper
public interface UserMapper extends BaseMapper<User> {
    // 原有方法
    User selectByUsername(String username);
    // 新增方法，根据用户名或邮箱查询用户
    default Optional<User> findByUsernameOrEmail(String usernameOrEmail) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUsername, usernameOrEmail)
                   .or()
                   .eq(User::getEmail, usernameOrEmail);
        return Optional.ofNullable(selectOne(queryWrapper));
    }

}
