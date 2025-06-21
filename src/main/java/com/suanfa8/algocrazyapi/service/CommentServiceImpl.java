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
    private  CommentMapper commentsMapper;

    @Override
    public List<Comment> getCommentsByArticleId(Long articleId) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getArticleId, articleId)
                .isNull(Comment::getParentCommentId);
        List<Comment> comments = commentsMapper.selectList(queryWrapper);
        return comments;
    }

    @Override
    public Comment addComment(Comment comment) {
        commentsMapper.insert(comment);
        return comment;
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