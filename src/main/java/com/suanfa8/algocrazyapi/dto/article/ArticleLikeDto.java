package com.suanfa8.algocrazyapi.dto.article;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

@Data
// 驼峰转下划线
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ArticleLikeDto {

    private Integer articleId;

}
