package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.ArticleTag;
import com.suanfa8.algocrazyapi.entity.Label;
import com.suanfa8.algocrazyapi.mapper.ArticleTagMapper;
import com.suanfa8.algocrazyapi.mapper.TagMapper;
import com.suanfa8.algocrazyapi.service.ITagService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TagServiceImpl extends ServiceImpl<TagMapper, Label> implements ITagService {

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private ArticleTagMapper articleTagMapper;

    @Override
    public List<Label> getAllTags() {
        LambdaQueryWrapper<Label> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Label::getIsDeleted, false)
                .orderByDesc(Label::getCreatedAt);
        return tagMapper.selectList(queryWrapper);
    }

    @Override
    public IPage<Label> listTags(Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize <= 0) {
            pageSize = 10;
        }

        Page<Label> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<Label> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Label::getIsDeleted, false)
                .orderByDesc(Label::getCreatedAt);

        return tagMapper.selectPage(page, queryWrapper);
    }

    @Override
    public Label getTagById(Integer id) {
        LambdaQueryWrapper<Label> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Label::getId, id)
                .eq(Label::getIsDeleted, false);
        return tagMapper.selectOne(queryWrapper);
    }

    @Override
    public Label getTagByName(String name) {
        LambdaQueryWrapper<Label> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Label::getName, name)
                .eq(Label::getIsDeleted, false);
        return tagMapper.selectOne(queryWrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Label createTag(Label tag) {
        // 检查标签是否已存在
        Label existingTag = getTagByName(tag.getName());
        if (existingTag != null) {
            return existingTag;
        }

        tag.setCreatedAt(LocalDateTime.now());
        tag.setUpdatedAt(LocalDateTime.now());
        tag.setIsDeleted(false);
        tagMapper.insert(tag);
        return tag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Label updateTag(Label tag) {
        LambdaUpdateWrapper<Label> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Label::getId, tag.getId())
                .eq(Label::getIsDeleted, false)
                .set(Label::getName, tag.getName())
                .set(Label::getDescription, tag.getDescription())
                .set(Label::getUpdatedAt, LocalDateTime.now());
        tagMapper.update(null, updateWrapper);
        return getTagById(tag.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteTag(Integer id) {
        LambdaUpdateWrapper<Label> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Label::getId, id)
                .set(Label::getIsDeleted, true)
                .set(Label::getUpdatedAt, LocalDateTime.now());
        return tagMapper.update(null, updateWrapper) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteTags(List<Integer> ids) {
        LambdaUpdateWrapper<Label> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.in(Label::getId, ids)
                .set(Label::getIsDeleted, true)
                .set(Label::getUpdatedAt, LocalDateTime.now());
        return tagMapper.update(null, updateWrapper) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addTagsToArticle(Integer articleId, List<Integer> tagIds) {
        // 过滤掉已存在的标签关联
        List<Integer> existingTagIds = articleTagMapper.selectTagIdsByArticleId(articleId);
        List<Integer> newTagIds = tagIds.stream()
                .filter(tagId -> !existingTagIds.contains(tagId))
                .collect(Collectors.toList());

        if (newTagIds.isEmpty()) {
            return true;
        }

        // 批量插入新的标签关联
        List<ArticleTag> articleTags = newTagIds.stream()
                .map(tagId -> {
                    ArticleTag articleTag = new ArticleTag();
                    articleTag.setArticleId(articleId);
                    articleTag.setTagId(tagId);
                    articleTag.setCreatedAt(LocalDateTime.now());
                    return articleTag;
                })
                .collect(Collectors.toList());

        return articleTags.stream().allMatch(articleTag -> articleTagMapper.insert(articleTag) > 0);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateArticleTags(Integer articleId, List<Integer> tagIds) {
        // 删除旧的标签关联
        articleTagMapper.deleteByArticleId(articleId);

        // 如果没有新标签，直接返回
        if (tagIds == null || tagIds.isEmpty()) {
            return true;
        }

        // 批量插入新的标签关联
        List<ArticleTag> articleTags = tagIds.stream()
                .map(tagId -> {
                    ArticleTag articleTag = new ArticleTag();
                    articleTag.setArticleId(articleId);
                    articleTag.setTagId(tagId);
                    articleTag.setCreatedAt(LocalDateTime.now());
                    return articleTag;
                })
                .collect(Collectors.toList());

        return articleTags.stream().allMatch(articleTag -> articleTagMapper.insert(articleTag) > 0);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeTagFromArticle(Integer articleId, Integer tagId) {
        LambdaUpdateWrapper<ArticleTag> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(ArticleTag::getArticleId, articleId)
                .eq(ArticleTag::getTagId, tagId);
        return articleTagMapper.delete(updateWrapper) > 0;
    }

    @Override
    public List<Label> getTagsByArticleId(Integer articleId) {
        List<Integer> tagIds = articleTagMapper.selectTagIdsByArticleId(articleId);
        if (tagIds.isEmpty()) {
            return List.of();
        }

        LambdaQueryWrapper<Label> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(Label::getId, tagIds)
                .eq(Label::getIsDeleted, false)
                .orderByDesc(Label::getCreatedAt);
        return tagMapper.selectList(queryWrapper);
    }

    @Override
    public List<Integer> getArticleIdsByTagId(Integer tagId) {
        return articleTagMapper.selectArticleIdsByTagId(tagId);
    }
}