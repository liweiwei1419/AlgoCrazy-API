package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.ExerciseVideoDanmu;
import com.suanfa8.algocrazyapi.mapper.ExerciseVideoDanmuMapper;
import com.suanfa8.algocrazyapi.service.IExerciseVideoDanmuService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExerciseVideoDanmuServiceImpl extends ServiceImpl<ExerciseVideoDanmuMapper, ExerciseVideoDanmu> implements IExerciseVideoDanmuService {

    @Override
    public List<ExerciseVideoDanmu> getByExerciseVideoId(Integer exerciseVideoId) {
        LambdaQueryWrapper<ExerciseVideoDanmu> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseVideoDanmu::getExerciseVideoId, exerciseVideoId)
                .eq(ExerciseVideoDanmu::getIsDeleted, false)
                .orderByAsc(ExerciseVideoDanmu::getTimeMs)
                .orderByAsc(ExerciseVideoDanmu::getId);
        return list(queryWrapper);
    }
}
