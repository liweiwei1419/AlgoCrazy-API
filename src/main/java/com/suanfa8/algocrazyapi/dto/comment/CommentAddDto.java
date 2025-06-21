package com.suanfa8.algocrazyapi.dto.comment;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
// 驼峰转下划线
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class CommentAddDto {

    private Integer articleId;

    private String content;

    private String userId;

    private Integer parentCommentId;

    private Long replyToUserId;

    private Integer replyToCommentId;

}
