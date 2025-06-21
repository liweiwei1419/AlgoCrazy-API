package com.suanfa8.algocrazyapi.dto.comment;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CommentAddDto {

    private Integer article_id;

    private String content;

    private String user_id;

}
