package com.suanfa8.algocrazyapi.utils;

import com.dingtalk.api.DefaultDingTalkClient;
import com.dingtalk.api.DingTalkClient;
import com.dingtalk.api.request.OapiRobotSendRequest;
import com.dingtalk.api.response.OapiRobotSendResponse;
import com.taobao.api.ApiException;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

@Component
public class DingTalkGroupNotificationUtil {

    @Value("${dingtalk.custom-robot-token}")
    private String customRobotToken;

    @Value("${dingtalk.user-id}")
    private String userId;

    @Value("${dingtalk.secret}")
    private String secret;

    /**
     * 发送钉钉群通知
     *
     * @param message 通知消息内容
     */
    public void sendNotification(String message) {
        try {
            Long timestamp = System.currentTimeMillis();
            String stringToSign = timestamp + "\n" + secret;
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
            byte[] signData = mac.doFinal(stringToSign.getBytes(StandardCharsets.UTF_8));
            String sign = URLEncoder.encode(new String(Base64.encodeBase64(signData)), "UTF-8");

            DingTalkClient client = new DefaultDingTalkClient("https://oapi.dingtalk.com/robot/send?sign=" + sign + "&timestamp=" + timestamp);
            OapiRobotSendRequest req = new OapiRobotSendRequest();

            // 定义文本内容
            OapiRobotSendRequest.Text text = new OapiRobotSendRequest.Text();
            text.setContent(message);

            // 定义 @ 对象
            OapiRobotSendRequest.At at = new OapiRobotSendRequest.At();
            at.setAtMobiles(Arrays.asList(userId));

            // 设置消息类型
            req.setMsgtype("text");
            req.setText(text);
            req.setAt(at);

            OapiRobotSendResponse rsp = client.execute(req, customRobotToken);
            System.out.println(rsp.getBody());
        } catch (ApiException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeyException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 有新评论时发送通知
     */
    public void sendNewCommentNotification(String userNickname, Integer articleId, String content) {
        String stringBuilder = userNickname + "在文章 " + articleId + " 下发表了新的评论。\n" + "评论内容：\n" + content + "\n";
        sendNotification(stringBuilder);
    }

    /**
     * 有新回复时发送通知
     */
    public void sendNewReplyNotification(String userNickname, Integer articleId, String content) {
        sendNotification("有新的回复，请及时查看！");
    }
}