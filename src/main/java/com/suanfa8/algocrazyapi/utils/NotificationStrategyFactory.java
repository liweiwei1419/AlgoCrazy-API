package com.suanfa8.algocrazyapi.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 通知策略工厂类
 */
@Component
public class NotificationStrategyFactory {

    @Value("${notification.type:DINGTALK}")
    private String notificationType;

    private final DingTalkGroupNotificationUtil dingTalkGroupNotificationUtil;
    private final FeiShuGroupNotificationUtil feiShuGroupNotificationUtil;

    public NotificationStrategyFactory(DingTalkGroupNotificationUtil dingTalkGroupNotificationUtil,
                                       FeiShuGroupNotificationUtil feiShuGroupNotificationUtil) {
        this.dingTalkGroupNotificationUtil = dingTalkGroupNotificationUtil;
        this.feiShuGroupNotificationUtil = feiShuGroupNotificationUtil;
    }

    /**
     * 根据配置获取当前通知策略
     */
    public NotificationStrategy getNotificationStrategy() {
        NotificationType type = NotificationType.valueOf(notificationType.toUpperCase());
        return switch (type) {
            case DINGTALK -> dingTalkGroupNotificationUtil;
            case FEISHU -> feiShuGroupNotificationUtil;
        };
    }

    /**
     * 根据指定类型获取通知策略（用于动态切换）
     */
    public NotificationStrategy getNotificationStrategy(NotificationType type) {
        return switch (type) {
            case DINGTALK -> dingTalkGroupNotificationUtil;
            case FEISHU -> feiShuGroupNotificationUtil;
        };
    }
}