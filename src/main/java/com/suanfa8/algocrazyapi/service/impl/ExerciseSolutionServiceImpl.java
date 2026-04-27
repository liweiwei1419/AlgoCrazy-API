package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;
import com.suanfa8.algocrazyapi.mapper.ExerciseSolutionMapper;
import com.suanfa8.algocrazyapi.service.IExerciseSolutionService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ExerciseSolutionServiceImpl extends ServiceImpl<ExerciseSolutionMapper, ExerciseSolution> implements IExerciseSolutionService {

    @Resource
    private ExerciseSolutionMapper exerciseSolutionMapper;

    @Override
    public List<ExerciseSolution> getChildrenByParentId(Integer parentId) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getParentId, parentId)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public List<ExerciseSolution> getByDifficulty(String difficulty) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getDifficultyLevel, difficulty)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public List<ExerciseSolution> getByCategory(String category) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getCategory, category)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public List<ExerciseSolution> getByChapterNumber(String chapterNumber) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getChapterNumber, chapterNumber)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public ExerciseSolution getByLeetcodeNumber(String leetcodeNumber) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getLeetcodeNumber, leetcodeNumber)
                   .eq(ExerciseSolution::getIsDeleted, false);
        return exerciseSolutionMapper.selectOne(queryWrapper);
    }

    @Override
    public ExerciseSolution getByUrl(String url) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getUrl, url)
                   .eq(ExerciseSolution::getIsDeleted, false);
        return exerciseSolutionMapper.selectOne(queryWrapper);
    }

    @Override
    public IPage<ExerciseSolution> getPageList(Integer page, Integer size, String keyword, String difficulty, String category, String chapterNumber, String leetcodeNumber, Boolean isPublished) {
        Page<ExerciseSolution> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        
        // 构建 OR 关系的查询条件
        boolean hasCondition = false;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            queryWrapper.like(ExerciseSolution::getTitle, keyword)
                       .or()
                       .like(ExerciseSolution::getDescription, keyword);
            hasCondition = true;
        }
        
        if (difficulty != null && !difficulty.trim().isEmpty()) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getDifficultyLevel, difficulty);
            hasCondition = true;
        }
        
        if (category != null && !category.trim().isEmpty()) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getCategory, category);
            hasCondition = true;
        }
        
        if (chapterNumber != null && !chapterNumber.trim().isEmpty()) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getChapterNumber, chapterNumber);
            hasCondition = true;
        }
        
        if (leetcodeNumber != null && !leetcodeNumber.trim().isEmpty()) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getLeetcodeNumber, leetcodeNumber);
            hasCondition = true;
        }
        
        if (isPublished != null) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getIsPublished, isPublished);
            hasCondition = true;
        }
        
        queryWrapper.eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder)
                   .orderByDesc(ExerciseSolution::getUpdatedAt);
        
        return exerciseSolutionMapper.selectPage(pageParam, queryWrapper);
    }

    @Override
    public List<ExerciseSolution> getByPublishStatus(Boolean isPublished) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getIsPublished, isPublished)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder)
                   .orderByDesc(ExerciseSolution::getUpdatedAt);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public boolean batchUpdatePublishStatus(List<Integer> ids, Boolean isPublished) {
        ExerciseSolution updateEntity = new ExerciseSolution();
        updateEntity.setIsPublished(isPublished);
        
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(ExerciseSolution::getId, ids);
        
        return exerciseSolutionMapper.update(updateEntity, queryWrapper) > 0;
    }

    @Override
    public List<ExerciseSolution> getTreeList() {
        // 获取所有根节点（parent_id为null或0）
        LambdaQueryWrapper<ExerciseSolution> rootQuery = new LambdaQueryWrapper<>();
        rootQuery.and(wrapper -> wrapper.isNull(ExerciseSolution::getParentId)
                                .or().eq(ExerciseSolution::getParentId, 0))
                .eq(ExerciseSolution::getIsDeleted, false)
                .orderByAsc(ExerciseSolution::getSortOrder);
        
        List<ExerciseSolution> roots = exerciseSolutionMapper.selectList(rootQuery);
        
        // 为每个根节点递归获取子节点
        List<ExerciseSolution> treeList = new ArrayList<>();
        for (ExerciseSolution root : roots) {
            ExerciseSolution treeNode = buildTree(root);
            treeList.add(treeNode);
        }
        
        return treeList;
    }

    @Override
    public List<ExerciseSolution> getAllChildren(Integer parentId) {
        List<ExerciseSolution> allChildren = new ArrayList<>();
        getChildrenRecursive(parentId, allChildren);
        return allChildren;
    }

    /**
     * 递归构建树形结构
     */
    private ExerciseSolution buildTree(ExerciseSolution node) {
        List<ExerciseSolution> children = getChildrenByParentId(node.getId());
        if (!children.isEmpty()) {
            List<ExerciseSolution> childNodes = new ArrayList<>();
            for (ExerciseSolution child : children) {
                childNodes.add(buildTree(child));
            }
            // 这里可以添加children字段，但需要修改实体类
            // 或者使用DTO来返回树形结构
        }
        return node;
    }

    /**
     * 递归获取所有子节点
     */
    private void getChildrenRecursive(Integer parentId, List<ExerciseSolution> result) {
        List<ExerciseSolution> children = getChildrenByParentId(parentId);
        result.addAll(children);
        
        for (ExerciseSolution child : children) {
            getChildrenRecursive(child.getId(), result);
        }
    }
}