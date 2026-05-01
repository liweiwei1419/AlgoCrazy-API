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
    private Long parentId; // 父留言ID，0或null表示顶层留言
    private String replyToNickname; // 回复对象的昵称
}