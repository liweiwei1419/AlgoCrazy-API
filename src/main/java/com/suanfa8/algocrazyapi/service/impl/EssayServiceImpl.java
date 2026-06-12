package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.Essay;
import com.suanfa8.algocrazyapi.mapper.EssayMapper;
import com.suanfa8.algocrazyapi.service.IEssayService;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class EssayServiceImpl extends ServiceImpl<EssayMapper, Essay> implements IEssayService {

    @Override
    public List<Essay> getPublishedList() {
        LambdaQueryWrapper<Essay> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Essay::getIsDeleted, false)
                .eq(Essay::getIsPublished, true)
                .orderByAsc(Essay::getSortOrder)
                .orderByDesc(Essay::getUpdatedAt);
        return list(queryWrapper);
    }

    @Override
    public List<Essay> getAdminList(String keyword) {
        LambdaQueryWrapper<Essay> queryWrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            String trimmedKeyword = keyword.trim();
            queryWrapper.and(wrapper -> wrapper
                    .like(Essay::getTitle, trimmedKeyword)
                    .or()
                    .like(Essay::getContent, trimmedKeyword));
        }
        queryWrapper.eq(Essay::getIsDeleted, false)
                .orderByAsc(Essay::getSortOrder)
                .orderByDesc(Essay::getUpdatedAt);
        return list(queryWrapper);
    }

    @Override
    public Essay getPublishedDetail(Integer id) {
        LambdaQueryWrapper<Essay> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Essay::getId, id)
                .eq(Essay::getIsDeleted, false)
                .eq(Essay::getIsPublished, true);
        return getOne(queryWrapper);
    }

    @Override
    public boolean incrementViewCount(Integer id) {
        return lambdaUpdate()
                .eq(Essay::getId, id)
                .setSql("view_count = view_count + 1")
                .update();
    }

    @Override
    public Map<Integer, Essay> getEssayMapByIds(List<Integer> essayIds) {
        if (essayIds == null || essayIds.isEmpty()) {
            return Collections.emptyMap();
        }
        return listByIds(essayIds).stream()
                .collect(Collectors.toMap(Essay::getId, Function.identity(), (left, right) -> left));
    }
}
