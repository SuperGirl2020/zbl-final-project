package com.baizhi.zbl.controller;

import com.baizhi.zbl.entity.Banner;
import com.baizhi.zbl.service.BannerService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by Administrator on 2018/10/24 0024.
 */
@Controller
@RequestMapping("/banner")
public class BannerController {
    @Autowired
    private BannerService bannerService;

  /*  @RequestMapping("/add.do")
    @ResponseBody
    public String add(Banner banner){
        bannerService.insert(banner);
        System.out.println("添加没？？？？？？？？");
        return "add";
    }*/

    @RequestMapping("/delete.do")
    @ResponseBody
    public void delete(Integer id,HttpServletRequest request){
        bannerService.delete(id,request);
        System.out.println("删除没？？？？？？？");
    }

    @RequestMapping("update.do")
    @ResponseBody
    public void update(Integer id,String status){
        Banner banner = bannerService.queryById(id);
        banner.setStatus(status);
        bannerService.update(banner);
        System.out.println("修改没？？？？？？？");

    }

    @RequestMapping("/queryByPage.do")
    @ResponseBody
    public Map<String,Object>queryByPage(Integer page,Integer rows){
        System.out.println("page:"+page+"rows:"+rows);
        HashMap<String, Object> map = new HashMap<>();
        //总条数total
        List<Banner> banners = bannerService.queryAll();
        System.out.println("!!!!!!!!!!!"+banners.size());
        //当前页page,每页条数：rows
        List<Banner> pages = bannerService.queryByPage(page, rows);
        System.out.println("page:"+page+"rows:"+rows);
        for (Banner bannerss : pages) {
            System.out.println("~~~~~~~~~~"+bannerss);
        }
        map.put("total",banners.size());
        map.put("rows",pages);
        return map;
    }

    @RequestMapping("/uploadFile.do")
    @ResponseBody
    public void addBanner(HttpServletRequest request, Banner banner,String status, String title, String description, MultipartFile imgPath){
         /*
         * 1.指定上传位置
         * 2.防止文件重名
         * 3.上传文件到指定文件夹
         *
         *   webapps   暂时 存放到项目中   分布式的文件存储系统
         *
         * */
//        项目的绝对路径 D:\source\final-project\cmfz\src\main\webapp\
        String realPath = request.getServletContext().getRealPath("/");
        String uploadFilePath = realPath + "upload";
        File file = new File(uploadFilePath);
        if(!file.exists()){
            file.mkdir();
        }
//       获取原始文件名  1.jpg
        String originalFilename = imgPath.getOriginalFilename();
        String uuid = UUID.randomUUID().toString();
//       获取后缀名 jpg
        String extension= FilenameUtils.getExtension(originalFilename);
//        newName
        String newName = uuid + "." + extension;
        try {
            imgPath.transferTo(new File(uploadFilePath,newName));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
