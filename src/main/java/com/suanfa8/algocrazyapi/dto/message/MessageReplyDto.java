package com.suanfa8.algocrazyapi.dto.message;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class MessageReplyDto {
    private Long id;
    private String replyContent;
}