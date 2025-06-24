package com.suanfa8.algocrazyapi.dto.article;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

import java.time.LocalDateTime;

@Data
// 驼峰转下划线
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ArticleDetailDto {

    private Integer id;

    private String author;

    private String content;

    private String title;

    private String category;

    private String sourceUrl;

    private String solutionUrl;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private Integer likeCount = 0;

    private Integer viewCount = 0;

}
