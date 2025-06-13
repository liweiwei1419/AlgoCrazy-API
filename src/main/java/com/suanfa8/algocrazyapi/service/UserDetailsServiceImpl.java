package com.suanfa8.algocrazyapi.service;

import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userMapper.selectByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }
        return org.springframework.security.core.userdetails.User.builder().username(user.getUsername()).password(user.getPassword()).roles("USER") // 这里简单设置角色为 USER，可根据 role_id 动态设置
                .build();
    }

}
