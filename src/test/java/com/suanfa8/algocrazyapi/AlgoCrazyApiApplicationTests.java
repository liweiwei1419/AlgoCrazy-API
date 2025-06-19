package com.suanfa8.algocrazyapi;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.UserMapper;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class AlgoCrazyApiApplicationTests {

    @Resource
    private UserMapper userMapper;

    @Test
    void contextLoads() {
        String username = "liweiwei1419";
        User user = userMapper.selectOne(new QueryWrapper<User>().eq("username", username));
        System.out.println(user);
    }

}
