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
    private Long targetId;

    private String content;

    private Long parentId;

    private Long replyToCommentId;

    private String guestNickname;

    private String guestEmail;

    private Boolean anonymous;

    /**
     * 兼容旧前端字段，后续不再使用。
     */
    private Integer parentCommentId;

    private Long replyToUserId;

}
