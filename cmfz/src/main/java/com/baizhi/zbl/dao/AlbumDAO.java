package com.baizhi.zbl.dao;

import com.baizhi.zbl.entity.Album;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
public interface AlbumDAO {
    void insert(Album album);
    void delete(Integer id);
    void update(Album album);
    Album queryById(Integer id);
    List<Album> queryAll();
    List<Album> queryByPage(@Param("beginIndex")Integer beginIndex,@Param("rows")Integer rows);
}
