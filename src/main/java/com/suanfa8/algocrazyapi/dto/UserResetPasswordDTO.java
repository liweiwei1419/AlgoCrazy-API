package com.suanfa8.algocrazyapi.dto;

import lombok.Data;

@Data
public class UserResetPasswordDTO {
    private String email;
    private String newPassword;
}