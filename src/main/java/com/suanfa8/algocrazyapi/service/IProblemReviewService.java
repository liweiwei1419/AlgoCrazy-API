package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.dto.problemreview.ProblemReviewSubmitDTO;
import com.suanfa8.algocrazyapi.dto.problemreview.ProblemReviewTopicDTO;
import com.suanfa8.algocrazyapi.entity.ProblemReview;
import com.suanfa8.algocrazyapi.entity.User;

import java.util.List;

public interface IProblemReviewService extends IService<ProblemReview> {

    List<ProblemReviewTopicDTO> listEnabledTopics();

    ProblemReviewTopicDTO getTopicDetail(Long topicId);

    ProblemReview submitReview(Long topicId, ProblemReviewSubmitDTO submitDTO, User currentUser);
}
