package com.suanfa8.algocrazyapi.utils;

/**
 * 通知策略接口
 */
public interface NotificationStrategy {

    /**
     * 发送通知
     *
     * @param message 通知消息内容
     */
    void sendNotification(String message);

    /**
     * 有新评论时发送通知
     */
    void sendNewCommentNotification(String userNickname, Integer articleId, String content);

    /**
     * 有新回复时发送通知
     */
    void sendNewReplyNotification(String userNickname, Integer articleId, String content);
}
