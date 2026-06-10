package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.ExerciseVideo;
import com.suanfa8.algocrazyapi.mapper.ExerciseVideoMapper;
import com.suanfa8.algocrazyapi.service.IExerciseVideoService;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ExerciseVideoServiceImpl extends ServiceImpl<ExerciseVideoMapper, ExerciseVideo> implements IExerciseVideoService {

    @Override
    public List<ExerciseVideo> getByExerciseSolutionId(Integer exerciseSolutionId, boolean publishedOnly) {
        LambdaQueryWrapper<ExerciseVideo> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseVideo::getExerciseSolutionId, exerciseSolutionId)
                .eq(ExerciseVideo::getIsDeleted, false)
                .orderByAsc(ExerciseVideo::getSortOrder)
                .orderByAsc(ExerciseVideo::getId);
        if (publishedOnly) {
            queryWrapper.eq(ExerciseVideo::getIsPublished, true);
        }
        return list(queryWrapper);
    }

    @Override
    public Set<Integer> getExerciseIdsWithPublishedVideos(List<Integer> exerciseSolutionIds) {
        if (exerciseSolutionIds == null || exerciseSolutionIds.isEmpty()) {
            return Collections.emptySet();
        }

        LambdaQueryWrapper<ExerciseVideo> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(ExerciseVideo::getExerciseSolutionId, exerciseSolutionIds)
                .eq(ExerciseVideo::getIsDeleted, false)
                .eq(ExerciseVideo::getIsPublished, true)
                .select(ExerciseVideo::getExerciseSolutionId);

        return list(queryWrapper).stream()
                .map(ExerciseVideo::getExerciseSolutionId)
                .collect(Collectors.toSet());
    }

    @Override
    public boolean softDelete(Integer id) {
        ExerciseVideo video = getById(id);
        if (video == null) {
            return false;
        }
        video.setIsDeleted(true);
        return updateById(video);
    }
}
