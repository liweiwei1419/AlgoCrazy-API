package com.suanfa8.algocrazyapi.dto.problemreview;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ProblemReviewStatsDTO {

    private Long reviewCount = 0L;

    private Double averageRecommendScore = 0D;

    private Double averageThinkingScore = 0D;

    private String topStuckPoint;

    private List<StuckPointStatDTO> stuckPointStats = new ArrayList<>();
}
