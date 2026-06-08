package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.Faq;
import com.suanfa8.algocrazyapi.mapper.FaqMapper;
import com.suanfa8.algocrazyapi.service.IFaqService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FaqServiceImpl extends ServiceImpl<FaqMapper, Faq> implements IFaqService {

    @Override
    public List<Faq> getPublishedList() {
        LambdaQueryWrapper<Faq> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Faq::getIsDeleted, false)
                .eq(Faq::getIsPublished, true)
                .orderByAsc(Faq::getSortOrder)
                .orderByDesc(Faq::getUpdatedAt);
        return list(queryWrapper);
    }

    @Override
    public List<Faq> getAdminList(String keyword) {
        LambdaQueryWrapper<Faq> queryWrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            String trimmedKeyword = keyword.trim();
            queryWrapper.and(wrapper -> wrapper
                    .like(Faq::getQuestion, trimmedKeyword)
                    .or()
                    .like(Faq::getAnswer, trimmedKeyword));
        }
        queryWrapper.eq(Faq::getIsDeleted, false)
                .orderByAsc(Faq::getSortOrder)
                .orderByDesc(Faq::getUpdatedAt);
        return list(queryWrapper);
    }
}
