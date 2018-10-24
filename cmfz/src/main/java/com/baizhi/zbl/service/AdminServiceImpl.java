package com.baizhi.zbl.service;

import com.baizhi.zbl.dao.AdminDAO;
import com.baizhi.zbl.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2018/10/19 0019.
 */
@Service
@Transactional
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDAO adminDAO;

    @Override
    public Admin login(String username, String password) {
        Admin admin = adminDAO.query(username,password);
        if(admin==null){
            throw new RuntimeException("用户名不存在!");
        }else{
            if(admin.getPassword().equals(password)){
                return admin;
            }else{
                throw new RuntimeException("密码错误！");
            }
        }
    }

    @Override
    public void save(Admin admin) {
        Admin a = adminDAO.query(admin.getUsername(),admin.getPassword());
        if(a!=null){
            throw new RuntimeException("用户名已存在！");
        }else{
            adminDAO.save(admin);
        }
    }

    @Override
    public void delete(Integer id) {
        adminDAO.delete(id);
    }

    @Override
    public void update(Admin admin) {
        adminDAO.update(admin);
    }

    @Override
    public List<Admin> queryAll() {
        List<Admin> admins = adminDAO.queryAll();
        for(Admin list:admins){
            System.out.println(list);
        }
        return admins;
    }

    @Override
    public Admin queryById(Integer id) {
        Admin admin = adminDAO.queryById(id);
        return admin;
    }


}
