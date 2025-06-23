package com.suanfa8.algocrazyapi.entity;

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

    @TableField("article_id")
    private Integer articleId;

    @TableField(exist = false)
    private String articleTitle;
    @TableField(exist = false)
    private String articleUrl;

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
    @TableField("created_at")
    private LocalDateTime createdAt;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField("updated_at")
    private LocalDateTime updatedAt;

    /**
     * 评论用户信息
     */
    @TableField(exist = false)
    private String userAvatar;

    // todo 这个字段可以不存
    @TableField("user_nickname")
    private String userNickname;

    /**
     * 二级评论列表
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

}