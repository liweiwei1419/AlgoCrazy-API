package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.suanfa8.algocrazyapi.config.CustomMd5PasswordEncoder;
import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.UserMapper;
import com.suanfa8.algocrazyapi.service.IUserService;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CustomMd5PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    @Value("${frontend.url}") // 你的前端地址
    private String frontendUrl;

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
    public void changePassword(String username, String oldPassword, String newPassword) {
        // 根据用户名查询用户
        User user = userMapper.selectOne(new QueryWrapper<User>().eq("username", username));
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        // 验证原始密码
        if (!passwordEncoder.passwordEncrypt(oldPassword, username).equals(user.getPassword())) {
            throw new RuntimeException("原始密码错误");
        }

        // 加密新密码并更新
        String encryptedNewPassword = passwordEncoder.passwordEncrypt(newPassword, username);
        user.setPassword(encryptedNewPassword);
        user.setUpdatedAt(LocalDateTime.now());
        userMapper.updateById(user);
    }

    @Override
    public void sendResetPasswordEmail(String usernameOrEmail) {
        User user = userMapper.findByUsernameOrEmail(usernameOrEmail).orElseThrow(() -> new RuntimeException("用户不存在"));
        String token = UUID.randomUUID().toString().replace("-", "");
        // 存入 Redis，5 分钟有效
        redisTemplate.opsForValue().set("reset:token:" + token, user.getId().toString(), 5, TimeUnit.MINUTES);

        String resetLink = frontendUrl + "/reset-password?token=" + token;
        String content = "请点击以下链接重置密码（5分钟内有效）：\n" + resetLink;

        emailService.sendSimpleEmail(user.getEmail(), "重置密码", content);
    }

    @Override
    public void resetPassword(String token, String newPassword) {
        String key = "reset:token:" + token;
        String userId = redisTemplate.opsForValue().get(key);
        if (userId == null) {
            throw new RuntimeException("重置链接已失效或不存在");
        }
        // 修改为使用 userMapper
        User user = userMapper.selectById(Long.valueOf(userId));
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        // 密码加密
        String password = passwordEncoder.passwordEncrypt(newPassword, user.getUsername());
        user.setPassword(password);

        // 使用 userMapper 更新用户信息
        userMapper.updateById(user);
        // 使 token 失效
        redisTemplate.delete(key);
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
        queryWrapper.select(User::getId, User::getNickname, User::getAvatar).in(User::getId, userIds);
        List<User> users = userMapper.selectList(queryWrapper);
        Map<Long, User> userMap = new HashMap<>(userIds.size());
        for (User user : users) {
            userMap.put(user.getId(), user);
        }
        return userMap;
    }

    @Override
    public String getNicknameById(Long userId) {
        if (userId == null) {
            return null;
        }
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        // 只查询 nickname 字段
        queryWrapper.select(User::getNickname).eq(User::getId, userId);
        User user = userMapper.selectOne(queryWrapper);
        return user != null ? user.getNickname() : null;
    }

    @Override
    public User getUserByUsernameWithoutPassword(String username) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        // 排除密码字段
        queryWrapper.select(User.class, info -> !"password".equals(info.getColumn())).eq(User::getUsername, username);
        return userMapper.selectOne(queryWrapper);
    }

}