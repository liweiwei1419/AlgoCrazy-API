package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.AlgorithmCategory;
import com.suanfa8.algocrazyapi.mapper.AlgorithmCategoryMapper;
import com.suanfa8.algocrazyapi.service.IAlgorithmCategoryService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AlgorithmCategoryServiceImpl extends ServiceImpl<AlgorithmCategoryMapper, AlgorithmCategory> implements IAlgorithmCategoryService {

    @Autowired
    private AlgorithmCategoryMapper algorithmCategoryMapper;

    @Override
    public List<AlgorithmCategory> getAllCategories() {
        LambdaQueryWrapper<AlgorithmCategory> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AlgorithmCategory::getIsDeleted, false)
                .orderByAsc(AlgorithmCategory::getValue);
        return algorithmCategoryMapper.selectList(queryWrapper);
    }

    @Override
    public IPage<AlgorithmCategory> listCategories(Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize <= 0) {
            pageSize = 10;
        }

        Page<AlgorithmCategory> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<AlgorithmCategory> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AlgorithmCategory::getIsDeleted, false)
                .orderByAsc(AlgorithmCategory::getValue);

        return algorithmCategoryMapper.selectPage(page, queryWrapper);
    }

    @Override
    public AlgorithmCategory getCategoryById(Integer id) {
        LambdaQueryWrapper<AlgorithmCategory> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AlgorithmCategory::getId, id)
                .eq(AlgorithmCategory::getIsDeleted, false);
        return algorithmCategoryMapper.selectOne(queryWrapper);
    }

    @Override
    public AlgorithmCategory getCategoryByValue(Integer value) {
        LambdaQueryWrapper<AlgorithmCategory> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AlgorithmCategory::getValue, value)
                .eq(AlgorithmCategory::getIsDeleted, false);
        return algorithmCategoryMapper.selectOne(queryWrapper);
    }

    @Override
    public AlgorithmCategory getCategoryByLabel(String label) {
        LambdaQueryWrapper<AlgorithmCategory> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AlgorithmCategory::getLabel, label)
                .eq(AlgorithmCategory::getIsDeleted, false);
        return algorithmCategoryMapper.selectOne(queryWrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AlgorithmCategory createCategory(AlgorithmCategory category) {
        // 检查value是否已存在
        AlgorithmCategory existingCategory = getCategoryByValue(category.getValue());
        if (existingCategory != null) {
            throw new IllegalArgumentException("算法分类值已存在：" + category.getValue());
        }

        // 检查label是否已存在
        existingCategory = getCategoryByLabel(category.getLabel());
        if (existingCategory != null) {
            throw new IllegalArgumentException("算法分类标签已存在：" + category.getLabel());
        }

        category.setCreatedAt(LocalDateTime.now());
        category.setUpdatedAt(LocalDateTime.now());
        category.setIsDeleted(false);
        algorithmCategoryMapper.insert(category);
        return category;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AlgorithmCategory updateCategory(AlgorithmCategory category) {
        LambdaUpdateWrapper<AlgorithmCategory> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(AlgorithmCategory::getId, category.getId())
                .eq(AlgorithmCategory::getIsDeleted, false)
                .set(AlgorithmCategory::getValue, category.getValue())
                .set(AlgorithmCategory::getLabel, category.getLabel())
                .set(AlgorithmCategory::getUpdatedAt, LocalDateTime.now());
        algorithmCategoryMapper.update(null, updateWrapper);
        return getCategoryById(category.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteCategory(Integer id) {
        LambdaUpdateWrapper<AlgorithmCategory> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(AlgorithmCategory::getId, id)
                .set(AlgorithmCategory::getIsDeleted, true)
                .set(AlgorithmCategory::getUpdatedAt, LocalDateTime.now());
        return algorithmCategoryMapper.update(null, updateWrapper) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteCategories(List<Integer> ids) {
        LambdaUpdateWrapper<AlgorithmCategory> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.in(AlgorithmCategory::getId, ids)
                .set(AlgorithmCategory::getIsDeleted, true)
                .set(AlgorithmCategory::getUpdatedAt, LocalDateTime.now());
        return algorithmCategoryMapper.update(null, updateWrapper) > 0;
    }
}