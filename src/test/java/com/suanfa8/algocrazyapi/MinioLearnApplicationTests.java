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

    /**
     * 根据存储桶名称列出所有文件
     *
     * @param bucketName 存储桶名称
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
    void testListFilesInBucket() throws ServerException, InsufficientDataException, ErrorResponseException, IOException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        String bucketName = "crazy"; // 指定要列出文件的存储桶名称

        // 列出存储桶中的所有对象
        Iterable<io.minio.Result<io.minio.messages.Item>> results = minioClient.listObjects(
                io.minio.ListObjectsArgs.builder().bucket(bucketName).recursive(true).build());

        System.out.println("存储桶 " + bucketName + " 中的文件列表:");
        // 遍历并打印每个对象
        for (io.minio.Result<io.minio.messages.Item> result : results) {
            io.minio.messages.Item item = result.get();
            String objectName = item.objectName();
            long size = item.size();
            String lastModified = item.lastModified().toString();

            System.out.println("文件: " + objectName + ", 大小: " + size + " bytes, 修改时间: " + lastModified);
        }
        System.out.println("文件列表输出完成！");
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

    /**
     * 根据路径前缀下载存储桶中指定路径下的所有文件
     *
     * @param bucketName 存储桶名称
     * @param prefix     文件路径前缀
     * @param localDirectory 本地保存目录
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
    void downloadFilesByPath() throws ServerException, InsufficientDataException, ErrorResponseException, IOException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        String bucketName = "crazy"; // 指定存储桶名称
        String prefix = "exercises/chapter06/0147-unknown/"; // 指定要下载的路径前缀
        String localDirectory = "./downloads/" + prefix; // 本地保存目录

        // 创建本地目录
        File dir = new File(localDirectory);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 列出存储桶中指定路径下的所有对象
        Iterable<io.minio.Result<io.minio.messages.Item>> results = minioClient.listObjects(
                io.minio.ListObjectsArgs.builder()
                        .bucket(bucketName)
                        .prefix(prefix)
                        .recursive(true)
                        .build());

        int count = 0;
        // 遍历并下载每个对象
        for (io.minio.Result<io.minio.messages.Item> result : results) {
            io.minio.messages.Item item = result.get();
            String objectName = item.objectName();
            String localFilePath = localDirectory + objectName.substring(prefix.length());

            // 创建父目录
            File file = new File(localFilePath);
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }

            // 下载对象到本地文件
            try (InputStream inputStream = minioClient.getObject(
                    io.minio.GetObjectArgs.builder().bucket(bucketName).object(objectName).build());
                 OutputStream outputStream = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            } catch (Exception e) {
                System.err.println("下载文件失败: " + objectName);
                e.printStackTrace();
                continue;
            }

            System.out.println("下载完成: " + objectName + " -> " + localFilePath);
            count++;
        }
        System.out.println("路径 " + prefix + " 下的文件下载完成！共下载 " + count + " 个文件。");
    }

    /**
     * MinIO文件重命名（移动）：将原始路径下的所有文件下载到本地，上传到新路径，然后删除原始路径下的文件
     *
     * @param bucketName     存储桶名称
     * @param sourcePrefix   原始路径前缀
     * @param targetPrefix   新路径前缀
     * @param localTempDir   本地临时目录（用于存放下载的文件）
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
    void renameFilesInMinio() throws ServerException, InsufficientDataException, ErrorResponseException, IOException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        String bucketName = "crazy"; // 固定存储桶名称
        String sourcePrefix = "exercises/chapter15/0802-unknown/"; // 原始路径前缀
        String targetPrefix = "exercises/chapter15/0802-find-eventual-safe-states/"; // 新路径前缀
        String localTempDir = "./temp_downloads/" + sourcePrefix; // 本地临时目录

        // 创建本地临时目录
        File tempDir = new File(localTempDir);
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }

        // 步骤1：列出原始路径下的所有文件
        Iterable<io.minio.Result<io.minio.messages.Item>> results = minioClient.listObjects(
                io.minio.ListObjectsArgs.builder()
                        .bucket(bucketName)
                        .prefix(sourcePrefix)
                        .recursive(true)
                        .build());

        int downloadCount = 0;
        int uploadCount = 0;
        int deleteCount = 0;

        // 步骤2：遍历并下载每个文件到本地
        System.out.println("========== 开始下载原始路径下的文件 ==========");
        for (io.minio.Result<io.minio.messages.Item> result : results) {
            io.minio.messages.Item item = result.get();
            String objectName = item.objectName();
            String localFilePath = localTempDir + objectName.substring(sourcePrefix.length());

            // 创建父目录
            File file = new File(localFilePath);
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }

            // 下载文件
            try (InputStream inputStream = minioClient.getObject(
                    io.minio.GetObjectArgs.builder().bucket(bucketName).object(objectName).build());
                 OutputStream outputStream = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            } catch (Exception e) {
                System.err.println("下载文件失败: " + objectName);
                e.printStackTrace();
                continue;
            }

            System.out.println("下载完成: " + objectName);
            downloadCount++;
        }

        // 步骤3：上传文件到新路径
        System.out.println("\n========== 开始上传文件到新路径 ==========");
        File[] localFiles = tempDir.listFiles();
        if (localFiles != null) {
            for (File localFile : localFiles) {
                if (localFile.isFile()) {
                    String relativePath = localFile.getName();
                    String targetObjectName = targetPrefix + relativePath;

                    try (InputStream inputStream = new java.io.FileInputStream(localFile)) {
                        minioClient.putObject(
                                io.minio.PutObjectArgs.builder()
                                        .bucket(bucketName)
                                        .object(targetObjectName)
                                        .stream(inputStream, localFile.length(), -1)
                                        .build());
                    } catch (Exception e) {
                        System.err.println("上传文件失败: " + targetObjectName);
                        e.printStackTrace();
                        continue;
                    }

                    System.out.println("上传完成: " + targetObjectName);
                    uploadCount++;
                }
            }
        }

        // 步骤4：删除原始路径下的所有文件
        System.out.println("\n========== 开始删除原始路径下的文件 ==========");
        results = minioClient.listObjects(
                io.minio.ListObjectsArgs.builder()
                        .bucket(bucketName)
                        .prefix(sourcePrefix)
                        .recursive(true)
                        .build());

        for (io.minio.Result<io.minio.messages.Item> result : results) {
            io.minio.messages.Item item = result.get();
            String objectName = item.objectName();

            try {
                minioClient.removeObject(
                        io.minio.RemoveObjectArgs.builder()
                                .bucket(bucketName)
                                .object(objectName)
                                .build());
            } catch (Exception e) {
                System.err.println("删除文件失败: " + objectName);
                e.printStackTrace();
                continue;
            }

            System.out.println("删除完成: " + objectName);
            deleteCount++;
        }

        System.out.println("\n========== 操作完成！ ==========");
        System.out.println("下载文件数: " + downloadCount);
        System.out.println("上传文件数: " + uploadCount);
        System.out.println("删除文件数: " + deleteCount);
        System.out.println("提示：本地临时文件保存在 " + localTempDir + "，请手动删除。");
    }

}