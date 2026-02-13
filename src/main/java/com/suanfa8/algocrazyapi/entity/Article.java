package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.SqlCondition;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Accessors(chain = true)
@TableName("articles")
// 驼峰转下划线
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class Article {

    @TableId(type = IdType.AUTO)
    private Integer id;

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

    /**
     * 文章关联的标签列表（非数据库字段）
     */
    @TableField(exist = false)
    private List<Label> tagList;

    @TableField("url")
    private String url;

    @TableField("source_url")
    private String sourceUrl;

    @TableField("solution_url")
    private String solutionUrl;

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

    @TableField("like_count")
    private Integer likeCount = 0;

    @TableField("view_count")
    private Integer viewCount = 0;

    @TableField("is_deleted")
    @TableLogic
    private Boolean isDeleted = false;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField("deleted_at")
    private LocalDateTime deletedAt;

    /**
     * 新增树形结构字段
     */
    @TableField("parent_id")
    private Integer parentId;

    @TableField("display_order")
    private Integer displayOrder;

    @TableField("path")
    private String path;

    @TableField("is_folder")
    private Boolean isFolder;

    @TableField("book_check")
    private Boolean bookCheck;

    @TableField("suggestion")
    private String suggestion;

    // 一句话题解
    @TableField("one_sentence_solution")
    private String oneSentenceSolution;

}