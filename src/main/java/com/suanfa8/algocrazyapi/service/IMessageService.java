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

    /**
     * 获取树形结构的留言列表
     * @return 树形结构的留言列表
     */
    List<Message> getMessageTree();

    /**
     * 获取指定留言的所有子回复
     * @param parentId 父留言ID
     * @return 子回复列表
     */
    List<Message> getRepliesByParentId(Long parentId);

    /**
     * 添加回复（支持多级回复）
     * @param parentId 父留言ID
     * @param message 回复信息
     * @return 添加后的回复
     */
    Message addReplyMessage(Long parentId, Message message);
}