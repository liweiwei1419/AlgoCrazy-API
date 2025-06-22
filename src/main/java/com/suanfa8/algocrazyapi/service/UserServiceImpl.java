package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.suanfa8.algocrazyapi.config.CustomMd5PasswordEncoder;
import com.suanfa8.algocrazyapi.dto.UserLoginDTO;
import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.dto.UserResetPasswordDTO;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.UserMapper;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

@Service
public class UserServiceImpl implements IUserService {

    @Resource
    private UserMapper userMapper;

    @Resource
    private CustomMd5PasswordEncoder passwordEncoder;

    @Resource
    private AuthenticationManager authenticationManager;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Override
    public User register(UserRegisterDTO userRegisterDTO) {
        // 检查用户名是否已存在
        User existingUser = userMapper.selectOne(new QueryWrapper<User>().eq("username", userRegisterDTO.getUsername()));
        if (existingUser != null) {
            throw new RuntimeException("用户名已存在");
        }
        User user = new User();
        BeanUtils.copyProperties(userRegisterDTO, user);
        user.setPassword(passwordEncoder.passwordEncrypt(userRegisterDTO.getPassword(), userRegisterDTO.getUsername()));
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());
        user.setRoleId(0);
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
        String username = userResetPasswordDTO.getEmail();
        String code = userResetPasswordDTO.getCode();
        String newPassword = userResetPasswordDTO.getNewPassword();
        String storedCode = redisTemplate.opsForValue().get("verification_code:" + username);
        if (storedCode == null || !storedCode.equals(code)) {
            throw new RuntimeException("验证码无效或已过期");
        }
        // 根据用户名查询用户，orElseThrow，帮我写
        User user = userMapper.selectByUsername(username);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        user.setPassword(passwordEncoder.encode(newPassword));
        // 加强测试
        userMapper.updateById(user);
        redisTemplate.delete("verification_code:" + username);
    }


    @Override
    public void sendVerificationCode(String username) {
        // 验证码是 5 分钟
        String code = generateVerificationCode();
        redisTemplate.opsForValue().set("verification_code:" + username, code, 5, TimeUnit.MINUTES);
        // 这里可以集成邮件服务发送验证码，当前简单打印日志
        System.out.println("用户 " + username + " 的验证码是: " + code);
    }

    private String generateVerificationCode() {
        Random random = new Random();
        return String.format("%06d", random.nextInt(1000000));
    }

    @Override
    public Map<Long, User> getUserMapByIds(List<Long> userIds) {
        if (userIds.isEmpty()) {
            return new HashMap<>();
        }
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        // 只查询 id、nickname 和 avatar 字段
        queryWrapper.select(User::getId, User::getNickname, User::getAvatar)
                .in(User::getId, userIds);
        List<User> users = userMapper.selectList(queryWrapper);
        Map<Long, User> userMap = new HashMap<>(userIds.size());
        for (User user : users) {
            userMap.put(user.getId(), user);
        }
        return userMap;
    }

}