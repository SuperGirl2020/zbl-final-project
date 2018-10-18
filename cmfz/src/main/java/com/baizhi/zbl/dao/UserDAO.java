package com.baizhi.zbl.dao;

import com.baizhi.zbl.entity.User;

import java.util.List;

/**
 * Created by Administrator on 2018/10/18 0018.
 */
public interface UserDAO {
    public void save(User user);

    public List<User>queryAll();
}
