package com.baizhi.zbl.controller;

import com.baizhi.zbl.entity.Album;
import com.baizhi.zbl.entity.Chapter;
import com.baizhi.zbl.service.AlbumService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
@Controller
@RequestMapping("/album")
public class AlbumController {
    @Autowired
    private AlbumService albumService;

    @RequestMapping("/add.do")
    @ResponseBody
    public void addAlbum(MultipartFile coverImg, Album album, HttpServletRequest request) {
        albumService.insert(coverImg,album,request);
    }

    @ResponseBody
    @RequestMapping("/delete.do")
    public void delete(Integer id,HttpServletRequest request){
        albumService.delete(id,request);
    }

    @ResponseBody
    @RequestMapping("/update.do")
    public void update(Album album){
        albumService.update(album);
    }

   /* @ResponseBody
    @RequestMapping("/query.do")
    public String query(Integer id){
        Album album = albumService.queryById(id);
        return "query";
    }*/

    @RequestMapping("/queryById.do")
    public void queryById(Integer id){
       albumService.queryById(id);
    }

    @RequestMapping("/queryAll.do")
    public String queryAll(){
        List<Album> albums=albumService.queryAll();
        for (Album albumlist : albums) {
            System.out.println(albumlist);
        }
        return "queryAll";
    }
    
    @ResponseBody
    @RequestMapping("/queryByPage.do")
    public Map<String,Object> queryByPage(Integer page, Integer rows){
        System.out.println("page:"+page+"rows:"+rows);
        Map<String,Object> map=new HashMap<String,Object>();
        //总条数： total=0;
        List<Album> albums=albumService.queryAll();
        List<Album> albumPage=albumService.queryByPage(page,rows);
        for (Album albumes : albumPage) {
            System.out.println("****************"+albumes);
        }
        map.put("total",albums.size());
        map.put("rows",albumPage);
        return map;
    }

}
