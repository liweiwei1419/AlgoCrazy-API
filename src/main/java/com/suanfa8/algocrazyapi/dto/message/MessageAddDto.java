package com.suanfa8.algocrazyapi.dto.message;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class MessageAddDto {
    private String nickname;
    private String email;
    private String avatar;
    private String content;
}