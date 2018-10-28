package com.baizhi.zbl.service;

import com.baizhi.zbl.entity.Chapter;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
public interface ChapterService {
    void insert(MultipartFile cha, Chapter chapter, HttpServletRequest request);
    void delete(Integer id,Integer albumId,HttpServletRequest request);
    void deleteOne(Integer id,HttpServletRequest request);
    void update(Chapter chapter);
    List<Chapter> queryAll();
    Chapter queryById(Integer id);
    /*void deleteAll(Integer albumId);
    List<Chapter>queryByAlbumId(Integer id);
    List<Chapter> queryByPage(Integer page, Integer rows);*/
}
