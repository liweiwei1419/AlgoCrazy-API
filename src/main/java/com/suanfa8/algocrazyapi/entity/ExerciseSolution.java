package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
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

@Data
@Accessors(chain = true)
@TableName("exercise_solutions")
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ExerciseSolution {

    @TableId(type = IdType.AUTO)
    private Integer id;

    @TableField("parent_id")
    private Integer parentId;

    @TableField("title")
    private String title;

    @TableField("description")
    private String description;

    @TableField("solution")
    private String solution;

    @TableField("source")
    private String source = "text";

    @TableField("sort_order")
    private Integer sortOrder = 0;

    @TableField("difficulty_level")
    private String difficultyLevel = "medium";

    @TableField("category")
    private String category;

    @TableField("chapter_number")
    private String chapterNumber;

    @TableField("leetcode_number")
    private String leetcodeNumber;

    @TableField("video_reference")
    private String videoReference;

    @TableField("web_reference")
    private String webReference;

    @TableField("document_reference")
    private String documentReference;

    @TableField("remark")
    private String remark = "";

    @TableField("learning_tip")
    private String learningTip;

    @TableField("is_published")
    private Boolean isPublished = false;

    @TableField("created_by")
    private String createdBy;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value = "created_at", fill = FieldFill.INSERT)
    private LocalDateTime createdAt;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value = "updated_at", fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;

    @TableField("url")
    private String url;

    @TableField("is_deleted")
    @TableLogic
    private Boolean isDeleted = false;
}
