package com.suanfa8.algocrazyapi.dto.problemreview;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ProblemReviewSubmitDTO {

    private Integer recommendScore;

    private Integer thinkingScore;

    private String stuckPoint;

    private String shortComment;

    private String guestNickname;

    private Boolean anonymous;
}
