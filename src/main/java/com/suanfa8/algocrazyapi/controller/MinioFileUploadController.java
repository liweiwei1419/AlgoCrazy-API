package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.config.MinioConfig;
import com.suanfa8.algocrazyapi.utils.MinioUtils;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * @Description minio 文件上传控制器
 */
@CrossOrigin
@RestController
@RequestMapping("/file")
public class MinioFileUploadController {

    @Resource
    private MinioConfig minioConfig;

    @Autowired
    private MinioUtils minioUtils;

    /**
     * @param file     文件
     * @param fileName 文件名称
     * @Description 上传文件
     */
    @PostMapping("/upload")
    public String uploadFile(@RequestParam("file") MultipartFile file) {
        // @RequestParam("fileName") String fileName
        String fileName = file.getOriginalFilename();
        fileName = UUID.randomUUID() + fileName.substring(fileName.lastIndexOf("."));
        minioUtils.upload(file, fileName);
        return minioConfig.getUrl() + "/" + minioConfig.getBucketName() + "/" + fileName;
    }

    /**
     * @param fileName 文件名称
     * @Description download 文件
     */
    @GetMapping("/download")
    public ResponseEntity downloadFile(@RequestParam("fileName") String fileName) {
        return minioUtils.download(fileName);
    }

    /**
     * @param fileName 文件名称
     * @Description 得到文件url
     */
    @GetMapping("/getUrl")
    public Result<Map<String, String>> getFileUrl(@RequestParam("fileName") String fileName) {
        Map<String, String> map = new HashMap<>();
        map.put("FileUrl", minioUtils.getFileUrl(fileName));
        return Result.success(map);
    }

}
