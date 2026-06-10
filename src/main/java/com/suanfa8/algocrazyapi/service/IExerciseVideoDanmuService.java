package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.ExerciseVideoDanmu;

import java.util.List;

public interface IExerciseVideoDanmuService extends IService<ExerciseVideoDanmu> {

    List<ExerciseVideoDanmu> getByExerciseVideoId(Integer exerciseVideoId);
}
