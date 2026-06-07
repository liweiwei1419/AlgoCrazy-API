package com.suanfa8.algocrazyapi.dto.comment;


import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class CommentDeleteDto {

    private Long commentId;

    private Long parentCommentId;

}
