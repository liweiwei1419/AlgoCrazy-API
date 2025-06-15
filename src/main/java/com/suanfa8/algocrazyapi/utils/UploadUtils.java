package com.suanfa8.algocrazyapi.utils;

import com.qcloud.cos.COSClient;
import com.qcloud.cos.model.PutObjectRequest;
import com.qcloud.cos.model.PutObjectResult;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

@Slf4j
@Component
public class UploadUtils {

    private final COSClient cosClient;

    @Value("${tencent.cos.bucketName}")
    private String bucketName;

    @Value("${tencent.cos.prefix}")
    private String prefix;

    @Resource
    private MinioUtils minioUtils;

    public UploadUtils(COSClient cosClient) {
        this.cosClient = cosClient;
    }


    public String upload(String localFilePath) {
        File localFile = new File(localFilePath);
        String uuidName = localFilePath.substring(localFilePath.lastIndexOf("/") + 1);
        String key = "suanfa8/" + uuidName;
        PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, key, localFile);
        PutObjectResult putObjectResult = cosClient.putObject(putObjectRequest);
        // log.info("上传结果 => {}" , putObjectResult);
        return prefix + uuidName;
    }

    /**
     * 通过 URL 下载图片并上传到腾讯云
     *
     * @param imageUrl 图片的 URL 地址
     * @return 腾讯云存储的图片 URL
     * @throws IOException 下载图片或上传文件时发生 IO 异常
     */
    public String uploadByUrl(String imageUrl) throws IOException {
        // 创建临时文件
        File tempFile = File.createTempFile("temp-image", getFileExtension(imageUrl));
        tempFile.deleteOnExit();
        // 下载图片到临时文件
        downloadImageFromUrl(imageUrl, tempFile);
        // 调用现有的上传方法
        return upload(tempFile.getAbsolutePath());
    }

    /**
     * 通过 URL 下载图片并上传到 MinIO
     *
     * @param imageUrl 图片的 URL 地址
     * @return MinIO 存储的图片 URL
     * @throws 下载图片或上传文件时发生 IO 异常
     */
    public String uploadByUrlToMinio(String prefix, String imageUrl) throws IOException {
        // 创建临时文件
        File tempFile = File.createTempFile("temp-image", getFileExtension(imageUrl));
        tempFile.deleteOnExit();
        // 下载图片到临时文件
        downloadImageFromUrl(imageUrl, tempFile);
        // 处理 prefix，确保以 / 结尾
        if (!prefix.endsWith("/")) {
            prefix = prefix + "/";
        }
        // 调用 MinioUtils 的上传方法
        String objectName = prefix + tempFile.getName();
        return minioUtils.upload(tempFile, objectName);
    }


    /**
     * 从 URL 下载图片到指定文件
     *
     * @param imageUrl   图片的 URL 地址
     * @param targetFile 目标文件
     * @throws IOException 下载图片时发生 IO 异常
     */
    private void downloadImageFromUrl(String imageUrl, File targetFile) throws IOException {
        URL url = new URL(imageUrl);
        URLConnection connection = url.openConnection();
        try (InputStream in = connection.getInputStream(); FileOutputStream out = new FileOutputStream(targetFile)) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }

    /**
     * 获取文件扩展名
     *
     * @param url 文件的 URL 地址
     * @return 文件扩展名
     */
    private String getFileExtension(String url) {
        int lastIndex = url.lastIndexOf('.');
        if (lastIndex != -1) {
            return url.substring(lastIndex);
        }
        return ".jpg"; // 默认扩展名
    }
}