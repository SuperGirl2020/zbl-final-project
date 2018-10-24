package com.baizhi.zbl.dao;

import com.baizhi.zbl.entity.Admin;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2018/10/19 0019.
 */
public interface AdminDAO {
    Admin query(@Param("username") String username, @Param("password")String password);
    public void save(Admin admin);
    public void delete(Integer id);
    void update(Admin admin);
    public List<Admin>queryAll();
    Admin queryById(Integer id);
}
