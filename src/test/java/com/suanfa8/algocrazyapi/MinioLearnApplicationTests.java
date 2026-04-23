package com.suanfa8.algocrazyapi;


import com.suanfa8.algocrazyapi.utils.MinioUtils;
import io.minio.MinioClient;
import io.minio.errors.ErrorResponseException;
import io.minio.errors.InsufficientDataException;
import io.minio.errors.InternalException;
import io.minio.errors.InvalidResponseException;
import io.minio.errors.ServerException;
import io.minio.errors.XmlParserException;
import io.minio.messages.Bucket;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@SpringBootTest
class MinioLearnApplicationTests {

    @Resource
    private MinioUtils minioUtils;

    @Autowired
    private MinioClient minioClient;


    /**
     * 查询所有存储桶
     *
     * @throws ServerException
     * @throws InsufficientDataException
     * @throws ErrorResponseException
     * @throws IOException
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeyException
     * @throws InvalidResponseException
     * @throws XmlParserException
     * @throws InternalException
     */
    @Test
    void testListBuckets() throws ServerException, InsufficientDataException, ErrorResponseException, IOException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        List<Bucket> buckets = minioClient.listBuckets();
        for (Bucket bucket : buckets) {
            System.out.println(bucket.name());
        }
    }


    @Test
    void contextLoads() {
        boolean crazy = minioUtils.existBucket("crazy");
        System.out.println(crazy);
    }



    @Test
    void downloadAllFiles() throws ServerException, InsufficientDataException, ErrorResponseException, IOException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        String bucketName = "videos"; // 指定要下载的存储桶名称
        String localDirectory = "./downloads/"; // 本地保存目录

        // 创建本地目录
        File dir = new File(localDirectory);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 列出存储桶中的所有对象
        Iterable<io.minio.Result<io.minio.messages.Item>> results = minioClient.listObjects(io.minio.ListObjectsArgs.builder().bucket(bucketName).recursive(true).build());

        // 遍历并下载每个对象
        for (io.minio.Result<io.minio.messages.Item> result : results) {
            io.minio.messages.Item item = result.get();
            String objectName = item.objectName();
            String localFilePath = localDirectory + objectName;

            // 创建父目录
            File file = new File(localFilePath);
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }

            // 下载对象到本地文件
            try (InputStream inputStream = minioClient.getObject(io.minio.GetObjectArgs.builder().bucket(bucketName).object(objectName).build()); OutputStream outputStream = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            } catch (Exception e) {
                System.err.println("下载文件失败: " + objectName);
                e.printStackTrace();
            }

            System.out.println("下载完成: " + objectName + " -> " + localFilePath);
        }

        System.out.println("所有文件下载完成！");
    }

}