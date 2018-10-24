package com.baizhi.zbl.service;

import com.baizhi.zbl.entity.Admin;

import java.util.List;

/**
 * Created by Administrator on 2018/10/19 0019.
 */
public interface AdminService {
    Admin login(String username,String password);
    public void save(Admin admin);
    public void delete(Integer id);
    void update(Admin admin);
    public List<Admin> queryAll();
    Admin queryById(Integer id);
}
