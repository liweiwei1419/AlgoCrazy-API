package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.Message;

import java.util.List;

public interface IMessageService extends IService<Message> {

    /**
     * 获取所有留言列表（按创建时间倒序）
     * @return 留言列表
     */
    List<Message> getAllMessages();

    /**
     * 分页获取留言列表
     * @param pageNum 页码
     * @param pageSize 每页数量
     * @return 分页后的留言列表
     */
    IPage<Message> listMessages(Integer pageNum, Integer pageSize);

    /**
     * 添加留言
     * @param message 留言信息
     * @return 添加后的留言
     */
    Message addMessage(Message message);

    /**
     * 更新留言状态
     * @param id 留言ID
     * @param status 状态：0-待回复，1-已回复
     * @return 更新结果
     */
    boolean updateMessageStatus(Long id, Integer status);

    /**
     * 添加回复内容
     * @param id 留言ID
     * @param replyContent 回复内容
     * @return 更新结果
     */
    boolean addReply(Long id, String replyContent);

    /**
     * 删除留言
     * @param id 留言ID
     * @return 删除结果
     */
    boolean deleteMessage(Long id);

    /**
     * 按状态获取留言列表
     * @param status 状态：0-待回复，1-已回复
     * @return 留言列表
     */
    List<Message> getMessagesByStatus(Integer status);
}