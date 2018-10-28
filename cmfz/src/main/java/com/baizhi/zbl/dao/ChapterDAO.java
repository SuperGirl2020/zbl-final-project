package com.baizhi.zbl.dao;

import com.baizhi.zbl.entity.Chapter;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
public interface ChapterDAO {
    void insert(Chapter chapter);
    void delete(Integer id);
    void update(Chapter chapter);
    List<Chapter>queryAll();
    Chapter queryById(Integer id);
    void deleteAll(Integer albumId);
    List<Chapter>queryByAlbumId(Integer id);
   /* List<Chapter> queryByPage(@Param("beginIndex")Integer beginIndex, @Param("rows")Integer rows);*/
}
