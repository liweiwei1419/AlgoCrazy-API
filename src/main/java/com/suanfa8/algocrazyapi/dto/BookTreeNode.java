package com.suanfa8.algocrazyapi.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;
import lombok.ToString;

import java.util.List;

// 树结点 DTO
@Data
// 驼峰转下划线
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@ToString
public class BookTreeNode  {

    private String index;

    private String title;

    private String url;

    private Boolean isFolder;

    private List<BookTreeNode> children;
    
}