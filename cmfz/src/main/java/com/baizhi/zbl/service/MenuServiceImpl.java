package com.baizhi.zbl.service;

import com.baizhi.zbl.dao.MenuDAO;
import com.baizhi.zbl.entity.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2018/10/18 0018.
 */
@Service
@Transactional
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuDAO menuDAO;

    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    @Override
    public List<Menu> queryAll() {
        List<Menu> menuList=menuDAO.queryAll();
        for (Menu menus:menuList) {
            System.out.println(menus);
        }
        return menuList;
    }
}
