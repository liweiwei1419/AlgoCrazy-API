package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;

public enum DifficultyEnum {
    EASY("easy", "简单"),
    MEDIUM("medium", "中等"),
    HARD("hard", "困难");

    @EnumValue
    private final String code;

    @JsonValue
    private final String name;

    DifficultyEnum(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    /**
     * 根据中文名称获取枚举值
     */
    public static DifficultyEnum getByName(String name) {
        for (DifficultyEnum difficulty : DifficultyEnum.values()) {
            if (difficulty.getName().equals(name)) {
                return difficulty;
            }
        }
        return null;
    }

    /**
     * 根据英文代码获取枚举值
     */
    public static DifficultyEnum getByCode(String code) {
        for (DifficultyEnum difficulty : DifficultyEnum.values()) {
            if (difficulty.getCode().equals(code)) {
                return difficulty;
            }
        }
        return null;
    }
}