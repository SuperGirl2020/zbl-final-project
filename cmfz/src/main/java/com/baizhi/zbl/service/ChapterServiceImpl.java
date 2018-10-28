package com.baizhi.zbl.service;

import com.baizhi.zbl.dao.AlbumDAO;
import com.baizhi.zbl.dao.ChapterDAO;
import com.baizhi.zbl.entity.Album;
import com.baizhi.zbl.entity.Chapter;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
@Service
@Transactional
public class ChapterServiceImpl implements ChapterService {
    @Autowired
    private ChapterDAO chapterDAO;
    @Autowired
    private AlbumDAO albumDAO;

    @Override
    public void insert(MultipartFile cha, Chapter chapter, HttpServletRequest request) {
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String originalFilename = cha.getOriginalFilename();
        String profile = new File(realPath).getParent();
        File uploadFile = new File(profile + "/music");

        if(!uploadFile.exists()){
            uploadFile.mkdir();
        }
        try {
            UUID uuid = UUID.randomUUID();
            String newName = uuid.toString();
            String extension = FilenameUtils.getExtension(originalFilename);
            newName = newName + "." + extension;
            chapter.setId(Integer.valueOf(uuid.toString()));
            chapter.setAudioPath("/music/"+newName);

            chapterDAO.insert(chapter);
            Album album = albumDAO.queryById(chapter.getAlbumId());
            album.setCount(album.getCount()+1);
            albumDAO.update(album);
            cha.transferTo(new File(uploadFile,newName));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Integer id, Integer albumId, HttpServletRequest request) {
        Chapter chapter = chapterDAO.queryById(id);
        File file = new File(new File(request.getSession().getServletContext().getRealPath("/")).getParent() + chapter.getAudioPath());
        if(file.exists()){
            file.delete();
        }
        Album album = albumDAO.queryById(albumId);
        album.setCount(album.getCount()-1);
        albumDAO.update(album);
        chapterDAO.delete(id);

    }

    @Override
    public void deleteOne(Integer id, HttpServletRequest request) {
        Chapter chapter = chapterDAO.queryById(id);
        File file = new File(new File(request.getSession().getServletContext().getRealPath("/")).getParent() + chapter.getAudioPath());
        if(file.exists()){
            file.delete();
        }
        chapterDAO.delete(id);
    }

    @Override
    public void update(Chapter chapter) {
        chapterDAO.update(chapter);
    }

    @Override
    public List<Chapter> queryAll() {
        return chapterDAO.queryAll();
    }

    @Override
    public Chapter queryById(Integer id) {
        return  chapterDAO.queryById(id);
    }



   /* @Override
    public List<Chapter> queryByPage(Integer page, Integer rows) {
        int beginIndex=(page-1)*rows;
        List<Chapter> listChapter=chapterDAO.queryByPage(beginIndex,rows);
        for (Chapter chapters:listChapter){
            System.out.println(chapters);
        }
        return listChapter;
    }*/
}
