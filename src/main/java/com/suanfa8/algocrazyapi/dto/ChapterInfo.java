package com.suanfa8.algocrazyapi.dto;

import lombok.Data;

@Data
public class ChapterInfo {
    private Integer id;
    private String name;
    
    public ChapterInfo() {}
    
    public ChapterInfo(Integer id, String name) {
        this.id = id;
        this.name = name;
    }
}
