package com.suanfa8.algocrazyapi.dto.comment;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;
import lombok.ToString;

// 评论与回复共用
@Data
@ToString
// 驼峰转下划线
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class CommentAddDto {

    /**
     * 目标类型：ARTICLE（文章）、EXERCISE（练习）等
     */
    private String targetType;

    /**
     * 目标ID
     */
    private Integer targetId;

    private String content;

    private String userId;

    // 回复才有
    private Integer parentCommentId;
    // 回复才有
    private Long replyToUserId;
    // 回复才有
    private Integer replyToCommentId;

}
