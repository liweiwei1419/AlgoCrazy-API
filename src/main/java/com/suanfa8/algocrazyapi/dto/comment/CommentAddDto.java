package com.suanfa8.algocrazyapi.dto.comment;

import com.baomidou.mybatisplus.annotation.TableField;
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

    private Integer articleId;

    private String content;

    private String userId;

    // 回复才有
    private Integer parentCommentId;
    // 回复才有
    private Long replyToUserId;
    // 回复才有
    private Integer replyToCommentId;

}
