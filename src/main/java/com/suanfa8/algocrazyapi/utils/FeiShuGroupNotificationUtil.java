package com.suanfa8.algocrazyapi.utils;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

/**
 * 飞书群通知工具类
 */
@Component
public class FeiShuGroupNotificationUtil implements NotificationStrategy {

    @Value("${feishu.webhook-url}")
    private String webhookUrl;

    @Value("${feishu.secret}")
    private String secret;

    @Value("${feishu.user-id}")
    private String userId;

    private final RestTemplate restTemplate = new RestTemplate();

    @Override
    public void sendNotification(String message) {
        try {
            Long timestamp = System.currentTimeMillis() / 1000;
            String stringToSign = timestamp + "\n" + secret;
            Mac mac = Mac.getInstance("HmacSHA256");
            // 飞书签名：将 stringToSign 作为密钥，对空数据进行签名
            mac.init(new SecretKeySpec(stringToSign.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
            byte[] signData = mac.doFinal(new byte[]{});
            // 使用标准 Base64 编码（飞书要求）
            String sign = new String(Base64.encodeBase64(signData));

            String url = buildSignedWebhookUrl(timestamp, sign);

            Map<String, Object> body = new HashMap<>();
            body.put("msg_type", "text");

            Map<String, Object> content = new HashMap<>();
            content.put("text", message + "\n<at user_id=\"" + userId + "\"></at>");
            body.put("content", content);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

            ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);
            System.out.println("飞书通知响应: " + response.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("发送飞书通知失败", e);
        }
    }

    private String buildSignedWebhookUrl(Long timestamp, String sign) {
        String separator = webhookUrl.contains("?") ? "&" : "?";
        String encodedSign = URLEncoder.encode(sign, StandardCharsets.UTF_8);
        return webhookUrl + separator + "timestamp=" + timestamp + "&sign=" + encodedSign;
    }

    @Override
    public void sendNewCommentNotification(String userNickname, Integer articleId, String content) {
        String message = userNickname + "在文章 " + articleId + " 下发表了新的评论。\n" + "评论内容：\n" + content + "\n";
        sendNotification(message);
    }

    @Override
    public void sendNewReplyNotification(String userNickname, Integer articleId, String content) {
        sendNotification("有新的回复，请及时查看！");
    }
}
