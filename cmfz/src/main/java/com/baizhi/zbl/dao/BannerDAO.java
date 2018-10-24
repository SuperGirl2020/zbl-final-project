package com.baizhi.zbl.dao;

import com.baizhi.zbl.entity.Banner;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2018/10/24 0024.
 */
public interface BannerDAO {
    List<Banner>queryAll();
    List<Banner>queryByPage(@Param("beginIndex") Integer beginIndex,@Param("rows") Integer rows);
    void insert(Banner banner);
    void delete(Integer id);
    void update(Banner banner);
    Banner queryById(Integer id);
}
