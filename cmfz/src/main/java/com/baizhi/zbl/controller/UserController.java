package com.baizhi.zbl.controller;

import com.baizhi.zbl.entity.User;
import com.baizhi.zbl.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Administrator on 2018/10/18 0018.
 */
@Controller
@RequestMapping("/test")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/queryAll")
    public String queryAll(HttpSession session){
        List<User> users = userService.queryAll();
        session.setAttribute("users",users);
        return "index";
    }

    @RequestMapping("/save")
    public void save(User user){
        userService.save(user);
    }

}
