package com.suanfa8.algocrazyapi.config;

import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.http.HttpProtocol;
import com.qcloud.cos.region.Region;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CosConfig {

    @Value("${tencent.cos.secretId}")
    private String secretId;

    @Value("${tencent.cos.secretKey}")
    private String secretKey;

    @Value("${tencent.cos.region}")
    private String regionName;

    @Bean
    public COSCredentials cosCredentials() {
        return new BasicCOSCredentials(secretId, secretKey);
    }

    @Bean
    public Region region() {
        return new Region(regionName);
    }

    @Bean
    public ClientConfig clientConfig(Region region) {
        ClientConfig clientConfig = new ClientConfig(region);
        clientConfig.setHttpProtocol(HttpProtocol.https);
        return clientConfig;
    }

    @Bean(destroyMethod = "shutdown")
    public COSClient cosClient(COSCredentials cosCredentials, ClientConfig clientConfig) {
        return new COSClient(cosCredentials, clientConfig);
    }
}