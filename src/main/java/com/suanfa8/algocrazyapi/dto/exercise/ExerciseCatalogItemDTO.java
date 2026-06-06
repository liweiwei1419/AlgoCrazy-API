package com.suanfa8.algocrazyapi.dto.exercise;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ExerciseCatalogItemDTO {

    private Integer id;

    private String title;

    private Integer sortOrder;

    private String difficultyLevel;

    private String category;

    private String chapterNumber;

    private String leetcodeNumber;

    private String url;

    private Boolean hasWebReference;

    private Boolean hasDocument;

    private Boolean hasVideo;
}
