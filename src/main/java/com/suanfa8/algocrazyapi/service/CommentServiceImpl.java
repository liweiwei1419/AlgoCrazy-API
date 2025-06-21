package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.Comment;
import com.suanfa8.algocrazyapi.mapper.CommentMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Resource
    private CommentMapper commentsMapper;

    @Override
    public List<Comment> getCommentsByArticleId(Integer articleId) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getArticleId, articleId).isNull(Comment::getParentCommentId).orderByDesc(Comment::getCreatedAt);
        return commentsMapper.selectList(queryWrapper);
    }

    @Override
    public Comment addComment(Comment comment) {
        // 执行插入操作，insert 返回插入成功的记录数
        int insert = commentsMapper.insert(comment);
        // 插入成功后，comment 对象已经包含数据库生成的新值，如自增主键
        if (insert > 0) {
            return comment;
        }
        // 插入失败返回 null
        return null;
    }


    @Override
    public boolean incrementLikeCount(Long id) {
        return baseMapper.incrementLikeCount(id);
    }

    @Override
    public boolean deleteComment(Long id) {
        return removeById(id);
    }

    @Override
    public boolean updateComment(Comment comment) {
        return updateById(comment);
    }
}