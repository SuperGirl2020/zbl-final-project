package com.baizhi.zbl.service;

import com.baizhi.zbl.dao.UserDAO;
import com.baizhi.zbl.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2018/10/18 0018.
 */
@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDAO userDAO;
    @Override
    public void save(User user) {
        userDAO.save(user);
    }

    @Override
    public List<User> queryAll() {
        return userDAO.queryAll();
    }
}
