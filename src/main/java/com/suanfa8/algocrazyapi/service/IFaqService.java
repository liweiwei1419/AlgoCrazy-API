package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.Faq;

import java.util.List;

public interface IFaqService extends IService<Faq> {

    List<Faq> getPublishedList();

    List<Faq> getAdminList(String keyword);
}
