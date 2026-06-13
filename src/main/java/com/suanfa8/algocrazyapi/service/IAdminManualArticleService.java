package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.AdminManualArticle;

import java.util.List;

public interface IAdminManualArticleService extends IService<AdminManualArticle> {

    List<AdminManualArticle> getAdminList(String keyword);
}
