package com.baizhi.zbl.service;

import com.baizhi.zbl.entity.Banner;
import org.apache.ibatis.annotations.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2018/10/24 0024.
 */
public interface BannerService {
    List<Banner> queryAll();
    List<Banner>queryByPage(@Param("page") Integer page, @Param("rows") Integer rows);
    void insert(Banner banner);
    void delete(Integer id, HttpServletRequest request);
    void update(Banner banner);
    Banner queryById(Integer id);
}
