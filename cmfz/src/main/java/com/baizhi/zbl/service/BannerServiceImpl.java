package com.baizhi.zbl.service;

import com.baizhi.zbl.dao.BannerDAO;
import com.baizhi.zbl.entity.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;

/**
 * Created by Administrator on 2018/10/24 0024.
 */
@Service
public class BannerServiceImpl implements BannerService{

    @Autowired
    private BannerDAO bannerDAO;

    @Override
    public List<Banner> queryAll() {
        List<Banner> banners = bannerDAO.queryAll();
        for (Banner bannerlist :banners) {
            System.out.println(bannerlist);
        }
        return banners;
    }

    @Override
    public List<Banner> queryByPage(Integer page, Integer rows) {
        int beginIdex=(page-1)*rows;
        List<Banner> bannerlist = bannerDAO.queryByPage(beginIdex, rows);
        for (Banner banners:bannerlist) {
            System.out.println(banners);
        }
        return bannerlist;
    }

    @Override
    public void insert(Banner banner) {
        bannerDAO.insert(banner);
    }

    @Override
    public void delete(Integer id, HttpServletRequest request) {
        Banner banner = bannerDAO.queryById(id);
        File file = new File(new File(request.getSession().getServletContext().getRealPath("/")).getParent() + banner.getImgPath());
        if(file.exists())
            file.delete();
        bannerDAO.delete(id);
    }

    @Override
    public void update(Banner banner) {
        bannerDAO.update(banner);
    }

    @Override
    public Banner queryById(Integer id) {
        return bannerDAO.queryById(id);
    }
}
