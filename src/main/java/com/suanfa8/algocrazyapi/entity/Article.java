package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.SqlCondition;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Accessors(chain = true)
@TableName("articles")
public class Article {

    @TableId(type = IdType.AUTO)
    private Long id;

    @TableField("author")
    private String author;

    @TableField(value = "title", condition = SqlCondition.LIKE)
    private String title;

    @TableField("content")
    private String content;

    @TableField("category")
    private String category;

    @TableField("tags")
    private List<String> tags;

    @TableField("url")
    private String url;

    @TableField(value = "created_at", fill = FieldFill.INSERT)
    private LocalDateTime createdAt;

    @TableField(value = "updated_at", fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;

    @TableField("like_count")
    private Integer likeCount = 0;

    @TableField("view_count")
    private Integer viewCount = 0;

    @TableField("is_deleted")
    @TableLogic
    private Boolean isDeleted = false;

    @TableField("deleted_at")
    private LocalDateTime deletedAt;
}