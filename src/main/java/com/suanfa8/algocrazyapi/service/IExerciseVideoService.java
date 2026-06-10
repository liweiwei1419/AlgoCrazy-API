package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.ExerciseVideo;

import java.util.List;
import java.util.Set;

public interface IExerciseVideoService extends IService<ExerciseVideo> {

    List<ExerciseVideo> getByExerciseSolutionId(Integer exerciseSolutionId, boolean publishedOnly);

    Set<Integer> getExerciseIdsWithPublishedVideos(List<Integer> exerciseSolutionIds);

    boolean softDelete(Integer id);
}
