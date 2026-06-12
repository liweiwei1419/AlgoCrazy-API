package com.suanfa8.algocrazyapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.suanfa8.algocrazyapi.entity.Essay;

import java.util.List;
import java.util.Map;

public interface IEssayService extends IService<Essay> {

    List<Essay> getPublishedList();

    List<Essay> getAdminList(String keyword);

    Essay getPublishedDetail(Integer id);

    boolean incrementViewCount(Integer id);

    Map<Integer, Essay> getEssayMapByIds(List<Integer> essayIds);
}
