package com.suanfa8.algocrazyapi;

import com.suanfa8.algocrazyapi.dto.ArticleTreeNode;
import com.suanfa8.algocrazyapi.service.ArticleTreeServiceImpl;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class ArticleTreeServiceTest {

    @Resource
    private ArticleTreeServiceImpl articleTreeService;

    @Test
    public void test(){
        List<ArticleTreeNode> fullTree = articleTreeService.getFullTree();
        System.out.println(fullTree);
    }

}
