package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.Message;
import com.suanfa8.algocrazyapi.mapper.MessageMapper;
import com.suanfa8.algocrazyapi.service.IMessageService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements IMessageService {

    @Autowired
    private MessageMapper messageMapper;

    @Override
    public List<Message> getAllMessages() {
        LambdaQueryWrapper<Message> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Message::getIsDeleted, false)
                    .orderByDesc(Message::getCreatedAt);
        return messageMapper.selectList(queryWrapper);
    }

    @Override
    public IPage<Message> listMessages(Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize <= 0) {
            pageSize = 10;
        }

        Page<Message> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<Message> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Message::getIsDeleted, false)
                    .eq(Message::getParentId, 0) // 只获取顶层留言
                    .orderByDesc(Message::getCreatedAt);

        return messageMapper.selectPage(page, queryWrapper);
    }

    @Override
    public Message addMessage(Message message) {
        message.setStatus(0); // 初始状态为待回复
        message.setCreatedAt(LocalDateTime.now());
        message.setUpdatedAt(LocalDateTime.now());
        message.setIsDeleted(false);
        
        // 处理多级回复
        if (message.getParentId() == null || message.getParentId() == 0) {
            message.setParentId(0L);
            message.setLevel(0);
        } else {
            // 获取父留言的层级，当前层级为父层级+1
            Message parentMessage = messageMapper.selectById(message.getParentId());
            if (parentMessage != null) {
                message.setLevel(parentMessage.getLevel() + 1);
            } else {
                // 如果父留言不存在，默认为顶层
                message.setParentId(0L);
                message.setLevel(0);
            }
        }
        
        messageMapper.insert(message);
        return message;
    }

    @Override
    public boolean updateMessageStatus(Long id, Integer status) {
        LambdaUpdateWrapper<Message> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Message::getId, id)
                    .eq(Message::getIsDeleted, false)
                    .set(Message::getStatus, status)
                    .set(Message::getUpdatedAt, LocalDateTime.now());
        return messageMapper.update(null, updateWrapper) > 0;
    }

    @Override
    public boolean addReply(Long id, String replyContent) {
        LambdaUpdateWrapper<Message> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Message::getId, id)
                    .eq(Message::getIsDeleted, false)
                    .set(Message::getReplyContent, replyContent)
                    .set(Message::getReplyTime, LocalDateTime.now())
                    .set(Message::getStatus, 1) // 标记为已回复
                    .set(Message::getUpdatedAt, LocalDateTime.now());
        return messageMapper.update(null, updateWrapper) > 0;
    }

    @Override
    public boolean deleteMessage(Long id) {
        LambdaUpdateWrapper<Message> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Message::getId, id)
                    .set(Message::getIsDeleted, true)
                    .set(Message::getUpdatedAt, LocalDateTime.now());
        return messageMapper.update(null, updateWrapper) > 0;
    }

    @Override
    public List<Message> getMessagesByStatus(Integer status) {
        LambdaQueryWrapper<Message> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Message::getIsDeleted, false)
                    .eq(Message::getStatus, status)
                    .orderByDesc(Message::getCreatedAt);
        return messageMapper.selectList(queryWrapper);
    }

    @Override
    public List<Message> getMessageTree() {
        // 先获取所有顶层留言
        LambdaQueryWrapper<Message> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Message::getIsDeleted, false)
                    .eq(Message::getParentId, 0)
                    .orderByDesc(Message::getCreatedAt);
        List<Message> topLevelMessages = messageMapper.selectList(queryWrapper);
        
        // 递归添加子回复
        for (Message message : topLevelMessages) {
            addRepliesToMessage(message);
        }
        
        return topLevelMessages;
    }



    @Override
    public List<Message> getRepliesByParentId(Long parentId) {
        LambdaQueryWrapper<Message> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Message::getIsDeleted, false)
                    .eq(Message::getParentId, parentId)
                    .orderByAsc(Message::getCreatedAt);
        return messageMapper.selectList(queryWrapper);
    }

    @Override
    public Message addReplyMessage(Long parentId, Message message) {
        Message parentMessage = messageMapper.selectById(parentId);
        if (parentMessage == null || parentMessage.getIsDeleted()) {
            throw new RuntimeException("父留言不存在");
        }
        
        message.setParentId(parentId);
        message.setLevel(parentMessage.getLevel() + 1);
        message.setStatus(0);
        message.setCreatedAt(LocalDateTime.now());
        message.setUpdatedAt(LocalDateTime.now());
        message.setIsDeleted(false);
        
        messageMapper.insert(message);
        return message;
    }

    /**
     * 递归添加子回复到留言对象
     */
    private void addRepliesToMessage(Message parentMessage) {
        List<Message> replies = getRepliesByParentId(parentMessage.getId());
        if (!replies.isEmpty()) {
            parentMessage.setChildren(replies);
            for (Message reply : replies) {
                addRepliesToMessage(reply);
            }
        }
    }

}