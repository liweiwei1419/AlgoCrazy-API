package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@TableName("comments")
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class Comment {

    @TableId(type = IdType.AUTO)
    private Integer id;

    // 解决返回给前端精度丢失的问题
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @TableField("user_id")
    private Long userId;

    @TableField("content")
    private String content;

    @TableField("parent_comment_id")
    private Integer parentCommentId;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value = "created_at", fill = FieldFill.INSERT)
    private LocalDateTime createdAt;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value = "updated_at", fill = FieldFill.UPDATE)
    private LocalDateTime updatedAt;

    /**
     * 评论用户头像（非数据库字段）
     */
    @TableField(exist = false)
    private String userAvatar;

    @TableField("user_nickname")
    private String userNickname;

    /**
     * 二级评论列表（非数据库字段）
     */
    @TableField(exist = false)
    private List<Comment> replies;

    @TableField("is_guest")
    private boolean isGuest;

    @TableField("is_deleted")
    @TableLogic
    private Boolean isDeleted = false;

    @TableField("like_count")
    private Integer likeCount = 0;

    @TableField("reply_count")
    private Integer replyCount = 0;

    @TableField("reply_to_comment_id")
    private Integer replyToCommentId;

    @TableField("reply_to_user_id")
    private Long replyToUserId;

    @TableField(exist = false)
    private String replyToUserNickname;

    /**
     * 目标类型：ARTICLE（文章）、EXERCISE（练习）等
     */
    @TableField("target_type")
    private String targetType;

    /**
     * 目标ID
     */
    @TableField("target_id")
    private Integer targetId;

    /**
     * 目标标题（非数据库字段）
     */
    @TableField(exist = false)
    private String targetTitle;

    /**
     * 目标URL（非数据库字段）
     */
    @TableField(exist = false)
    private String targetUrl;

}
