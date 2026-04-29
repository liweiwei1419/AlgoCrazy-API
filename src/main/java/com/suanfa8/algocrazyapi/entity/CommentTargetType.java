package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Getter;

/**
 * 评论目标类型枚举
 */
@Getter
public enum CommentTargetType {
    
    /**
     * 文章
     */
    ARTICLE("ARTICLE", "文章"),
    
    /**
     * 练习
     */
    EXERCISE("EXERCISE", "练习");
    
    /**
     * 数据库存储值
     */
    @EnumValue
    private final String code;
    
    /**
     * 显示名称
     */
    private final String name;
    
    CommentTargetType(String code, String name) {
        this.code = code;
        this.name = name;
    }
    
    /**
     * 序列化时返回的值
     */
    @JsonValue
    public String getCode() {
        return code;
    }
    
    /**
     * 根据code获取枚举
     */
    public static CommentTargetType fromCode(String code) {
        for (CommentTargetType type : values()) {
            if (type.code.equals(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("未知的评论目标类型: " + code);
    }
}