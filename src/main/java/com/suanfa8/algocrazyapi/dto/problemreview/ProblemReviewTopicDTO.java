package com.suanfa8.algocrazyapi.dto.problemreview;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.suanfa8.algocrazyapi.entity.ProblemReview;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ProblemReviewTopicDTO {

    private Long id;

    private Integer exerciseId;

    private String title;

    private String category;

    private String difficultyLevel;

    private String chapterNumber;

    private String leetcodeNumber;

    private String url;

    private String reviewTag;

    private String whyTypical;

    private String siteReview;

    private Integer sortOrder;

    private ProblemReviewStatsDTO stats = new ProblemReviewStatsDTO();

    private List<ProblemReview> recentReviews = new ArrayList<>();
}
