package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.AdminManualArticle;
import com.suanfa8.algocrazyapi.mapper.AdminManualArticleMapper;
import com.suanfa8.algocrazyapi.service.IAdminManualArticleService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminManualArticleServiceImpl extends ServiceImpl<AdminManualArticleMapper, AdminManualArticle> implements IAdminManualArticleService {

    @Override
    public List<AdminManualArticle> getAdminList(String keyword) {
        LambdaQueryWrapper<AdminManualArticle> queryWrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            String trimmedKeyword = keyword.trim();
            queryWrapper.and(wrapper -> wrapper
                    .like(AdminManualArticle::getTitle, trimmedKeyword)
                    .or()
                    .like(AdminManualArticle::getContent, trimmedKeyword));
        }
        queryWrapper.eq(AdminManualArticle::getIsDeleted, false)
                .orderByAsc(AdminManualArticle::getSortOrder)
                .orderByDesc(AdminManualArticle::getUpdatedAt);
        return list(queryWrapper);
    }
}
