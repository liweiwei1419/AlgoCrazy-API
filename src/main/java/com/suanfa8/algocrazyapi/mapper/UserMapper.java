package com.suanfa8.algocrazyapi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.suanfa8.algocrazyapi.entity.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {

    User selectByUsername(String username);

}
