package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.ExerciseSolutionDraft;
import com.suanfa8.algocrazyapi.mapper.ExerciseSolutionDraftMapper;
import com.suanfa8.algocrazyapi.service.IExerciseSolutionDraftService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 练习草稿 Service 实现类
 */
@Service
@Slf4j
public class ExerciseSolutionDraftServiceImpl extends ServiceImpl<ExerciseSolutionDraftMapper, ExerciseSolutionDraft> 
        implements IExerciseSolutionDraftService {

    @Resource
    private ExerciseSolutionDraftMapper exerciseSolutionDraftMapper;

    @Override
    public ExerciseSolutionDraft getByExerciseSolutionId(Integer exerciseSolutionId) {
        LambdaQueryWrapper<ExerciseSolutionDraft> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolutionDraft::getExerciseSolutionId, exerciseSolutionId)
                   .eq(ExerciseSolutionDraft::getIsDeleted, false);
        return exerciseSolutionDraftMapper.selectOne(queryWrapper);
    }

    @Override
    public boolean saveOrUpdateDraft(Integer exerciseSolutionId, String draftContent) {
        // 先查询是否已存在草稿
        ExerciseSolutionDraft existingDraft = getByExerciseSolutionId(exerciseSolutionId);
        
        if (existingDraft != null) {
            // 更新现有草稿
            existingDraft.setDraftContent(draftContent);
            return updateById(existingDraft);
        } else {
            // 创建新草稿
            ExerciseSolutionDraft newDraft = new ExerciseSolutionDraft();
            newDraft.setExerciseSolutionId(exerciseSolutionId);
            newDraft.setDraftContent(draftContent);
            return save(newDraft);
        }
    }

    @Override
    public boolean deleteByExerciseSolutionId(Integer exerciseSolutionId) {
        ExerciseSolutionDraft draft = getByExerciseSolutionId(exerciseSolutionId);
        if (draft != null) {
            draft.setIsDeleted(true);
            return updateById(draft);
        }
        return false;
    }
}