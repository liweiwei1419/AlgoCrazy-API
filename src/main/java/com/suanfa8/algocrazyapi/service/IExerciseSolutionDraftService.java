package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.ExerciseSolutionDraft;

/**
 * 练习草稿 Service 接口
 */
public interface IExerciseSolutionDraftService extends IService<ExerciseSolutionDraft> {

    /**
     * 根据练习解答ID获取草稿
     * @param exerciseSolutionId 练习解答ID
     * @return 草稿实体
     */
    ExerciseSolutionDraft getByExerciseSolutionId(Integer exerciseSolutionId);

    /**
     * 保存或更新草稿
     * @param exerciseSolutionId 练习解答ID
     * @param draftContent 草稿内容
     * @return 是否成功
     */
    boolean saveOrUpdateDraft(Integer exerciseSolutionId, String draftContent);

    /**
     * 根据练习解答ID删除草稿
     * @param exerciseSolutionId 练习解答ID
     * @return 是否成功
     */
    boolean deleteByExerciseSolutionId(Integer exerciseSolutionId);
}