package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;

import java.util.List;

public interface IExerciseSolutionService extends IService<ExerciseSolution> {

    /**
     * 根据父ID获取子习题列表
     */
    List<ExerciseSolution> getChildrenByParentId(Integer parentId);

    /**
     * 根据难度级别获取习题列表
     */
    List<ExerciseSolution> getByDifficulty(String difficulty);

    /**
     * 根据分类获取习题列表
     */
    List<ExerciseSolution> getByCategory(String category);

    /**
     * 根据章节序号获取习题列表
     */
    List<ExerciseSolution> getByChapterNumber(String chapterNumber);

    /**
     * 根据力扣题号获取习题
     */
    ExerciseSolution getByLeetcodeNumber(String leetcodeNumber);

    /**
     * 分页查询习题列表
     */
    IPage<ExerciseSolution> getPageList(Integer page, Integer size, String keyword, String difficulty, String category, String chapterNumber);

    /**
     * 获取树形结构的习题列表
     */
    List<ExerciseSolution> getTreeList();

    /**
     * 获取某个节点的所有子节点（包括孙子节点）
     */
    List<ExerciseSolution> getAllChildren(Integer parentId);
}