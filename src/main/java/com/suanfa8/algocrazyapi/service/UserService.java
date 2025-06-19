package com.suanfa8.algocrazyapi.service;

import com.suanfa8.algocrazyapi.dto.UserLoginDTO;
import com.suanfa8.algocrazyapi.dto.UserRegisterDTO;
import com.suanfa8.algocrazyapi.dto.UserResetPasswordDTO;
import com.suanfa8.algocrazyapi.entity.User;

public interface UserService {

    User register(UserRegisterDTO userRegisterDTO);

    String login(UserLoginDTO userLoginDTO);

    void resetPassword(UserResetPasswordDTO userResetPasswordDTO);

    void sendVerificationCode(String username);

}