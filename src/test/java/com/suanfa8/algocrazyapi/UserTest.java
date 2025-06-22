package com.suanfa8.algocrazyapi;

import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.service.IUserService;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class UserTest {

    @Resource
    private IUserService userService;

    @Test
    public void testRegister() {
        UserRegisterDTO userRegisterDTO = new UserRegisterDTO();
        userRegisterDTO.setUsername("zhouguang");
        userRegisterDTO.setPassword("123456");
        userRegisterDTO.setNickname("guang");
        userRegisterDTO.setEmail("zhouguang@163.com");
        userService.register(userRegisterDTO);
    }
}
