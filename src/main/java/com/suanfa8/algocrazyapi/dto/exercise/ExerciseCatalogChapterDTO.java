package com.suanfa8.algocrazyapi.dto.exercise;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ExerciseCatalogChapterDTO {

    private Integer id;

    private String number;

    private String title;

    private String name;

    private Integer exerciseCount;

    private Map<String, Integer> difficultyCounts;

    private List<ExerciseCatalogItemDTO> exercises;
}
