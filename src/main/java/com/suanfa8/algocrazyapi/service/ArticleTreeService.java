package com.suanfa8.algocrazyapi.service;

import com.suanfa8.algocrazyapi.dto.ArticleTreeNode;
import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.mapper.ArticleMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class ArticleTreeService {

    private final ArticleMapper articleMapper;

    // 获取完整树形结构
    public List<ArticleTreeNode> getFullTree() {
        // 1. 一次性查询所有结点（不包含 content 大字段）
        List<Article> allArticles = articleMapper.selectAllWithoutContent();

        // 2. 构建 ID 到结点的映射
        Map<Long, ArticleTreeNode> nodeMap = new HashMap<>();
        allArticles.forEach(article -> {
            ArticleTreeNode node = new ArticleTreeNode();
            BeanUtils.copyProperties(article, node);
            nodeMap.put(article.getId(), node);
        });

        // 3. 构建树结构
        List<ArticleTreeNode> roots = new ArrayList<>();
        for (Article article : allArticles) {
            ArticleTreeNode node = nodeMap.get(article.getId());
            if (Objects.isNull(article.getParentId())) {
                continue;
            }

            if (article.getParentId() == 0L) {
                roots.add(node);
            } else {
                ArticleTreeNode parent = nodeMap.get(article.getParentId());
                // 确保children列表已初始化
                if (parent.getChildren() == null) {
                    parent.setChildren(new ArrayList<>());
                }
                parent.getChildren().add(node);
            }
        }
        return roots;
    }

    // 移动结点
    @Transactional
    public void moveNode(Long id, Long newParentId) {
        Article article = articleMapper.selectById(id);
        if (article == null) {
            throw new RuntimeException("Article not found");
        }

        Article newParent = articleMapper.selectById(newParentId);
        if (newParent == null && newParentId != 0L) { // 0表示根节点
            throw new RuntimeException("New parent not found");
        }

        // 检查是否会产生循环引用
        if (newParent != null && newParent.getPath().contains(article.getId().toString())) {
            throw new RuntimeException("Cannot move to descendant node");
        }

        String oldPath = article.getPath();
        String newPath = newParentId == 0L ? String.valueOf(id) : newParent.getPath() + "," + id;

        // 更新当前节点
        article.setParentId(newParentId);
        article.setPath(newPath);
        articleMapper.updateById(article);

        // 更新所有子节点的路径
        if (!oldPath.equals(newPath)) {
            articleMapper.updatePath(oldPath + ",", newPath + ",");
        }
    }

    // 调整顺序
    @Transactional
    public void reorderNode(Long id, Integer newOrder) {
        Article article = articleMapper.selectById(id);
        if (article == null) {
            throw new RuntimeException("Article not found");
        }

        // 获取所有兄弟节点
        List<Article> siblings = articleMapper.selectChildren(article.getParentId());

        // 确保新顺序在有效范围内
        newOrder = Math.max(0, Math.min(newOrder, siblings.size() - 1));

        // 更新顺序
        article.setDisplayOrder(newOrder);
        articleMapper.updateById(article);

        // 调整其他兄弟节点的顺序
        int currentOrder = 0;
        for (Article sibling : siblings) {
            if (sibling.getId().equals(id)) continue;
            if (currentOrder == newOrder) currentOrder++;
            sibling.setDisplayOrder(currentOrder);
            articleMapper.updateById(sibling);
            currentOrder++;
        }
    }
}

