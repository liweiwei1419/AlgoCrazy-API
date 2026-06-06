package com.suanfa8.algocrazyapi.dto.exercise;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

import java.util.List;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ExerciseCatalogModuleDTO {

    private Integer id;

    private String title;

    private String label;

    private Integer chapterCount;

    private Integer exerciseCount;

    private List<ExerciseCatalogChapterDTO> chapters;
}
