package com.suanfa8.algocrazyapi.dto;

import com.suanfa8.algocrazyapi.entity.Article;
import lombok.Data;
import lombok.ToString;

import java.util.List;

// 树结点 DTO
@Data
@ToString(callSuper = true)
public class ArticleTreeNode extends Article {
    
    private List<ArticleTreeNode> children;

}