package com.baizhi.zbl.controller;

import com.baizhi.zbl.entity.Chapter;
import com.baizhi.zbl.service.ChapterService;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
@Controller
@RequestMapping("/chapter")
public class ChapterController {
    @Autowired
    private ChapterService chapterService;

   /* @RequestMapping("/add.do")
    @ResponseBody
    public String add(Chapter chapter){
        chapterService.insert(chapter);
        return "add";
    }*/
    @RequestMapping("/add.do")
    @ResponseBody
    public void add(MultipartFile cha,Chapter chapter,HttpServletRequest request){
        chapterService.insert(cha,chapter,request);
    }

    @RequestMapping("/download.do")
    public void download(String title, String audioPath, HttpServletRequest request, HttpServletResponse response){
        //1-1获取项目的webApp路径（文件存储在webAPP）HttpServletRequest
        String realPath = request.getServletContext().getRealPath("/");
        //1-2获取文件路径
        String filePath = realPath + "music/" + audioPath;
        //3-1获取文件对象（响应下载路径）
        File file = new File(filePath);
        //通过原始名获取扩展名
        String extension = FilenameUtils.getExtension(audioPath);
        title = title + "." + extension;
        String fileName=null;
        try {
            //返回的编码格式：ISO-8859-1，再转为：utf-8
            fileName = new String(title.getBytes("utf-8"), "ISO-8859-1");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        //2-1发送http请求后，以响应流返回HttpServletResponse
        //2-2响应类型，音频类型：audio/mpeg
        response.setContentType("audio/mpeg");
        //2-3响应头：音频类型tomcat-conf-web.xml(文件的响应类型)
        //响应头的属性：Content-Disposition，附件的形式attachment：下载
        response.setHeader("Content-Disposition","attachment;filename="+fileName);
        //响应出去
        try {
            //获取输出流
            ServletOutputStream outputStream = response.getOutputStream();
            //文件转为byte[]，工具类：FileUtiles
            outputStream.write(FileUtils.readFileToByteArray(file));
            //释放资源flush()
            outputStream.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @ResponseBody
    @RequestMapping("/delete.do")
    public void delete(Integer id,Integer albumId,HttpServletRequest request){
        chapterService.delete(id,albumId,request);
    }

    @ResponseBody
    @RequestMapping("/deleteOne.do")
    public void deleteOne(Integer id,HttpServletRequest request){
        chapterService.deleteOne(id,request);
    }

    @ResponseBody
    @RequestMapping("/query.do")
    public Chapter query(Integer id){
        return chapterService.queryById(id);
    }

    /*@RequestMapping("/queryByPage.do")
    public Map<String,Object> queryByPage(Integer page, Integer rows){
        System.out.println("page:"+page+"rows:"+rows);
        Map<String,Object> map=new HashMap<String,Object>();
        int total=0;
        List<Chapter> list=chapterService.queryAll();
        for (Chapter chapters:list) {
            total++;
        }
        List<Chapter> lists=chapterService.queryByPage(page,rows);
        for (Chapter chapters:list) {
            System.out.println(chapters);
        }
        map.put("total",total);
        map.put("rows",rows);
        map.put("lists",list);
        return map;
    }
*/
}
