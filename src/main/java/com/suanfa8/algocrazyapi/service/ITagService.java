package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.Label;

import java.util.List;

public interface ITagService extends IService<Label> {

    /**
     * 获取所有标签列表（按创建时间倒序）
     * @return 标签列表
     */
    List<Label> getAllTags();

    /**
     * 分页获取标签列表
     * @param pageNum 页码
     * @param pageSize 每页数量
     * @return 分页后的标签列表
     */
    IPage<Label> listTags(Integer pageNum, Integer pageSize);

    /**
     * 根据ID获取标签
     * @param id 标签ID
     * @return 标签信息
     */
    Label getTagById(Integer id);

    /**
     * 根据名称获取标签
     * @param name 标签名称
     * @return 标签信息
     */
    Label getTagByName(String name);

    /**
     * 创建标签
     * @param tag 标签信息
     * @return 创建后的标签
     */
    Label createTag(Label tag);

    /**
     * 更新标签
     * @param tag 标签信息
     * @return 更新后的标签
     */
    Label updateTag(Label tag);

    /**
     * 删除标签
     * @param id 标签ID
     * @return 删除结果
     */
    boolean deleteTag(Integer id);

    /**
     * 批量删除标签
     * @param ids 标签ID列表
     * @return 删除结果
     */
    boolean deleteTags(List<Integer> ids);

    /**
     * 为文章添加标签
     * @param articleId 文章ID
     * @param tagIds 标签ID列表
     * @return 添加结果
     */
    boolean addTagsToArticle(Integer articleId, List<Integer> tagIds);

    /**
     * 更新文章的标签
     * @param articleId 文章ID
     * @param tagIds 新的标签ID列表
     * @return 更新结果
     */
    boolean updateArticleTags(Integer articleId, List<Integer> tagIds);

    /**
     * 移除文章的标签
     * @param articleId 文章ID
     * @param tagId 标签ID
     * @return 移除结果
     */
    boolean removeTagFromArticle(Integer articleId, Integer tagId);

    /**
     * 获取文章的标签列表
     * @param articleId 文章ID
     * @return 标签列表
     */
    List<Label> getTagsByArticleId(Integer articleId);

    /**
     * 获取标签下的文章ID列表
     * @param tagId 标签ID
     * @return 文章ID列表
     */
    List<Integer> getArticleIdsByTagId(Integer tagId);
}