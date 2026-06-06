package com.suanfa8.algocrazyapi.dto.exercise;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ExerciseCatalogDTO {

    private List<ExerciseCatalogModuleDTO> modules;

    private Integer moduleCount;

    private Integer chapterCount;

    private Integer exerciseCount;

    private List<String> categories;

    private Map<String, Integer> difficultyCounts;
}
