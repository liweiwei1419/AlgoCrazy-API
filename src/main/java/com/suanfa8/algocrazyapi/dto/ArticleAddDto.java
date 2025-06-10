package com.suanfa8.algocrazyapi.dto;

import lombok.Data;

@Data
public class ArticleAddDto {

    private String author;

    private String category;

    private String content;

    private String parentId;

    private String sourceUrl;

    private String title;

}
