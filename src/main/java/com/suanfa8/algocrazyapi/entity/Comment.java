package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
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
    private Long id;

    @TableField("target_type")
    private String targetType;

    @TableField("target_id")
    private Long targetId;

    @TableField("content")
    private String content;

    @TableField("parent_id")
    private Long parentId;

    @TableField("reply_to_comment_id")
    private Long replyToCommentId;

    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @TableField("user_id")
    private Long userId;

    @TableField("author_type")
    private String authorType;

    @TableField("guest_nickname")
    private String guestNickname;

    @TableField("guest_email")
    private String guestEmail;

    @TableField("is_anonymous")
    private Boolean anonymous = false;

    @TableField("display_nickname")
    private String displayNickname;

    @TableField("display_avatar")
    private String displayAvatar;

    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @TableField("reply_to_user_id")
    private Long replyToUserId;

    @TableField("reply_to_nickname")
    private String replyToNickname;

    @TableField("reply_count")
    private Integer replyCount = 0;

    @TableField("like_count")
    private Integer likeCount = 0;

    @TableField("status")
    private String status;

    @TableField("ip_hash")
    private String ipHash;

    @TableField("user_agent_hash")
    private String userAgentHash;

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

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField("deleted_at")
    private LocalDateTime deletedAt;

    /**
     * 二级评论列表（非数据库字段）
     */
    @TableField(exist = false)
    private List<Comment> replies;

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
