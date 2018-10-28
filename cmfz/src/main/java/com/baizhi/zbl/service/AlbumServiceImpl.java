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
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
@Service
@Transactional
public class AlbumServiceImpl implements AlbumService {

    @Autowired
    private AlbumDAO albumDAO;
    @Autowired
    private ChapterDAO chapterDAO;

    @Override
    public void insert(MultipartFile coverImg, Album album, HttpServletRequest request) {
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String originalFilename=coverImg.getOriginalFilename();
        String profile = new File(realPath).getParent();
        File uploadFile = new File(profile + "/upload");

        if(!uploadFile.exists()){
            uploadFile.mkdir();
        }
        UUID uuid = UUID.randomUUID();
        String newName = uuid.toString();
        String extension = FilenameUtils.getExtension(originalFilename);
        newName = newName + "." + extension;
        try {
            album.setId(Integer.valueOf(uuid.toString()));
            album.setCoverImg("/upload/"+newName);
            album.getCreatDate(new Date());
            albumDAO.insert(album);

            coverImg.transferTo(new File(uploadFile,newName));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Integer id, HttpServletRequest request) {
        List<Chapter> list = chapterDAO.queryByAlbumId(id);
        String fileName = new File(request.getSession().getServletContext().getRealPath("/")).getParent();

        for (Chapter chapter : list) {
            fileName+=chapter.getAudioPath();
            File file = new File(fileName);
            if(file.exists()){
                file.delete();
            }
        }
        chapterDAO.deleteAll(id);
        albumDAO.delete(id);
    }

    @Override
    public void update(Album album) {
        albumDAO.update(album);
    }

    @Override
    public Album queryById(Integer id) {
        Album album = albumDAO.queryById(id);
        return album;
    }

    @Override
    public List<Album> queryAll() {
        List<Album> albums = albumDAO.queryAll();
        for (Album albumlist : albums) {
            System.out.println(albumlist);
        }
        return albums;
    }

    @Override
    public List<Album> queryByPage(Integer page, Integer rows) {
        System.out.println("page:"+page+"---------"+"rows:"+rows);
        int beginIndex=(page-1)*rows;
        System.out.println(page+"$$$$$$$$$$$$"+rows);
        List<Album> albums = albumDAO.queryByPage(beginIndex, rows);
        for (Album albumlist : albums) {
            System.out.println(albumlist);
        }
        return albums;
    }
}
