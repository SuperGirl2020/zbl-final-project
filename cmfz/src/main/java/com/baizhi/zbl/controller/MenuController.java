package com.baizhi.zbl.controller;

import com.baizhi.zbl.entity.Menu;
import com.baizhi.zbl.service.MenuService;
import javafx.scene.control.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by Administrator on 2018/10/19 0019.
 */
@RestController
@RequestMapping("/menu")
public class MenuController {
    @Autowired
    private MenuService menuService;


    //@RequestMapping(value = "/queryAll", produces = MediaType.APPLICATION_JSON_UTF8_VALUE,method = RequestMethod.POST)
    @RequestMapping("/queryAll.do")
    @ResponseBody
    public List<Menu> queryAll(){
        List<Menu> menus=menuService.queryAll();
        return menus;
    }
    /*public String queryAll(Model model){
        List<Menu> menus=menuService.queryAll();
        model.addAttribute("menus",menus);
        return "back/main";
    }*/

}
