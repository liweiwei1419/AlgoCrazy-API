package com.suanfa8.algocrazyapi;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@MapperScan("com.suanfa8.algocrazyapi.mapper")
@SpringBootApplication
public class AlgoCrazyApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(AlgoCrazyApiApplication.class, args);
    }

}
