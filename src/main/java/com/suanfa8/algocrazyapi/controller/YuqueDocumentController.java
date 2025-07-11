package com.suanfa8.algocrazyapi.controller;


import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "语雀文档")
@RequestMapping("/yuque/document")
@RestController
@Slf4j
public class YuqueDocumentController {

    @Value("${yuque.auth.token}")
    private String yuqueAuthToken;


    @Operation(summary = "根据知识库 ID 获取知识库目录")
    @Parameter(name = "repo_id", required = true, description = "知识库 ID", in = ParameterIn.PATH)
    @RequestMapping("/getTree/{repo_id}")
    public String getTree(@PathVariable("repo_id") String repoId) {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            // 发起 HTTP 请求获取知识库目录
            HttpGet httpGet = new HttpGet("https://www.yuque.com/api/v2/repos/" + repoId + "/toc");
            httpGet.setHeader("X-Auth-Token", yuqueAuthToken);
            // 执行请求
            try (CloseableHttpResponse response = httpClient.execute(httpGet)) {
                // 获取响应状态码
                int statusCode = response.getStatusLine().getStatusCode();
                log.info("Status code: {}", statusCode);
                // 获取响应内容
                HttpEntity entity = response.getEntity();
                if (entity != null) {
                    String result = EntityUtils.toString(entity);
                    log.info("Response content: {}", result);
                    // 确保实体被完全消费
                    EntityUtils.consume(entity);
                    return result;
                }
            }
        } catch (Exception e) {
            log.error("Error occurred while getting Yuque document tree for repo_id: {}", repoId, e);
        }
        return "Failed to get tree";
    }


    @Operation(summary = "根据知识库 ID 和文档 ID 获取文档内容")
    @Parameter(name = "repo_id", required = true, description = "知识库 ID", in = ParameterIn.PATH)
    @Parameter(name = "doc_id", required = true, description = "文档 ID", in = ParameterIn.PATH)
    @RequestMapping("/detail/{repo_id}/{doc_id}")
    public String getDocument(@PathVariable("repo_id") String repoId, @PathVariable("doc_id") String docId) {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            // 发起 HTTP 请求获取文档详情
            HttpGet httpGet = new HttpGet("https://www.yuque.com/api/v2/repos/" + repoId + "/docs/" + docId);
            httpGet.setHeader("X-Auth-Token", yuqueAuthToken);

            // 执行请求
            try (CloseableHttpResponse response = httpClient.execute(httpGet)) {
                // 获取响应状态码
                int statusCode = response.getStatusLine().getStatusCode();
                log.info("Status code: {}", statusCode);

                // 获取响应内容
                HttpEntity entity = response.getEntity();
                if (entity != null) {
                    String result = EntityUtils.toString(entity);
                    log.info("Response content: {}", result);
                    // 确保实体被完全消费
                    EntityUtils.consume(entity);
                    return result;
                }
            }
        } catch (Exception e) {
            log.error("Error occurred while getting Yuque document detail for repo_id: {} and doc_id: {}", repoId, docId, e);
        }
        return "Failed to get document detail";
    }
}
