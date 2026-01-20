package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

@Data
@Accessors(chain = true)
@TableName("leetcode_problems")
public class LeetCodeProblems {

    @TableId
    private Integer id;
    private String title;
    private String titleSlug;
    private DifficultyEnum difficulty;
    private Boolean paidOnly;
    private String url;

    @TableField("created_time")
    private LocalDateTime createdTime;

    @TableField("updated_time")
    private LocalDateTime updatedTime;
}
