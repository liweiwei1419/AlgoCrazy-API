package com.suanfa8.algocrazyapi.service;

import com.suanfa8.algocrazyapi.dto.ArticleTreeNode;
import com.suanfa8.algocrazyapi.dto.BookTreeNode;

import java.util.List;

public interface IArticleTreeService {

    List<ArticleTreeNode> getFullTree();

    List<BookTreeNode> getBookTree();

    void moveNode(Long id, Long newParentId);

    void reorderNode(Long id, Integer newOrder);

}
