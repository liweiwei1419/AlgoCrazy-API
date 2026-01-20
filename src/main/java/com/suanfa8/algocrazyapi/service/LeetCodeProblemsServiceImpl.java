package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.entity.LeetCodeProblems;
import com.suanfa8.algocrazyapi.mapper.LeetCodeProblemsMapper;
import org.springframework.stereotype.Service;

@Service
public class LeetCodeProblemsServiceImpl extends ServiceImpl<LeetCodeProblemsMapper, LeetCodeProblems> implements ILeetCodeProblemsService {
}