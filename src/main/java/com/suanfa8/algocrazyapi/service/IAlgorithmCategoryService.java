package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.AlgorithmCategory;

import java.util.List;

public interface IAlgorithmCategoryService extends IService<AlgorithmCategory> {

    /**
     * 获取所有算法分类列表（按value升序排列）
     * @return 算法分类列表
     */
    List<AlgorithmCategory> getAllCategories();

    /**
     * 分页获取算法分类列表
     * @param pageNum 页码
     * @param pageSize 每页数量
     * @return 分页后的算法分类列表
     */
    IPage<AlgorithmCategory> listCategories(Integer pageNum, Integer pageSize);

    /**
     * 根据ID获取算法分类
     * @param id 分类ID
     * @return 算法分类信息
     */
    AlgorithmCategory getCategoryById(Integer id);

    /**
     * 根据value获取算法分类
     * @param value 分类值
     * @return 算法分类信息
     */
    AlgorithmCategory getCategoryByValue(Integer value);

    /**
     * 根据label获取算法分类
     * @param label 分类标签
     * @return 算法分类信息
     */
    AlgorithmCategory getCategoryByLabel(String label);

    /**
     * 创建算法分类
     * @param category 算法分类信息
     * @return 创建后的算法分类
     */
    AlgorithmCategory createCategory(AlgorithmCategory category);

    /**
     * 更新算法分类
     * @param category 算法分类信息
     * @return 更新后的算法分类
     */
    AlgorithmCategory updateCategory(AlgorithmCategory category);

    /**
     * 删除算法分类
     * @param id 分类ID
     * @return 删除结果
     */
    boolean deleteCategory(Integer id);

    /**
     * 批量删除算法分类
     * @param ids 分类ID列表
     * @return 删除结果
     */
    boolean deleteCategories(List<Integer> ids);

}