package com.baizhi.zbl.controller;
import com.baizhi.zbl.entity.Admin;
import com.baizhi.zbl.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2018/10/19 0019.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @RequestMapping("/login.do")
    public String login(HttpSession session,String username,String password,String captcha){
        String code = (String) session.getAttribute("code");
        if(code!=null){
            if(code.equals(captcha)){
                Admin admin = adminService.login(username, password);
                System.out.println(admin);
                session.setAttribute("admin",admin);
                session.setAttribute("username",username);
                if(admin==null){
                    return "back/login";
                }
                return "back/main";
            }
            return "back/login";
        }
        return "back/login";
    }

    @RequestMapping("/loginout.do")
    public String loginout(){
        System.out.println("退出没");
        return "redirect:back/login";
    }

    @RequestMapping("/update.do")
    public String update(Admin admin){
        adminService.update(admin);
        return "back/main";
    }

    @ResponseBody
    @RequestMapping("/queryById.do")
    public Admin queryById(Integer id){
        Admin admin = adminService.queryById(id);
        return admin;
    }
}
