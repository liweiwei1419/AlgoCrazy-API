package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.dto.exercise.ExerciseSolutionListDTO;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
     * 根据 URL 获取习题解答
     */
    ExerciseSolution getByUrl(String url);

    /**
     * 分页查询习题列表（返回完整实体）
     */
    IPage<ExerciseSolution> getPageList(Integer page, Integer size, String keyword, String difficulty, String category, String chapterNumber, String leetcodeNumber, Boolean isPublished);

    /**
     * 分页查询习题列表（返回部分字段）
     */
    IPage<ExerciseSolutionListDTO> getPageListWithPartialFields(Integer page, Integer size, String keyword, String difficulty, String category, String chapterNumber, String leetcodeNumber, Boolean isPublished);

    /**
     * 根据发布状态获取习题列表
     */
    List<ExerciseSolution> getByPublishStatus(Boolean isPublished);

    /**
     * 批量更新发布状态
     */
    boolean batchUpdatePublishStatus(List<Integer> ids, Boolean isPublished);

    /**
     * 获取树形结构的习题列表
     */
    List<ExerciseSolution> getTreeList();

    /**
     * 获取某个节点的所有子节点（包括孙子节点）
     */
    List<ExerciseSolution> getAllChildren(Integer parentId);

    /**
     * 替换 Markdown 中的图片并更新到 MinIO
     *
     * @param id 习题解答ID
     * @return 是否成功
     */
    boolean replaceImages(Integer id);


    /**
     * 根据ID列表批量获取习题
     */
    Map<Integer, ExerciseSolution> getExerciseMapByIds(List<Integer> ids);

    /**
     * 根据ID修改备注
     *
     * @param id     习题ID
     * @param remark 备注内容
     * @return 是否成功
     */
    boolean updateRemarkById(Integer id, String remark);


}