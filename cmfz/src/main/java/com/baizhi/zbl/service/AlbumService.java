package com.baizhi.zbl.service;

import com.baizhi.zbl.entity.Album;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
public interface AlbumService {
    void insert(MultipartFile pic, Album album, HttpServletRequest request);
    void delete(Integer id,HttpServletRequest request);
    void update(Album album);
    Album queryById(Integer id);
    List<Album> queryAll();
    List<Album> queryByPage(@Param("beginIndex")Integer beginIndex, @Param("rows")Integer rows);
}
