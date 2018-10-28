package com.baizhi.zbl.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
public class Album implements Serializable{
    private Integer id;
    private String title;
    private Integer count;
    private String coverImg;
    private Integer score;
    private String author;
    private String broadCast;
    private String brief;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createDate;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date publishDate;
    private String status;
    private List<Chapter> children;

    public Album() {
    }

    public Album(Integer id, String title, Integer count, String coverImg, Integer score, String author, String broadCast, String brief, Date createDate, Date publishDate, String status, List<Chapter> children) {
        this.id = id;
        this.title = title;
        this.count = count;
        this.coverImg = coverImg;
        this.score = score;
        this.author = author;
        this.broadCast = broadCast;
        this.brief = brief;
        this.createDate = createDate;
        this.publishDate = publishDate;
        this.status = status;
        this.children = children;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getCoverImg() {
        return coverImg;
    }

    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getBroadCast() {
        return broadCast;
    }

    public void setBroadCast(String broadCast) {
        this.broadCast = broadCast;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public Date getCreatDate(Date date) {
        return createDate;
    }

    public void setCreatDate(Date creatDate) {
        this.createDate = creatDate;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<Chapter> getChildren() {
        return children;
    }

    public void setChildren(List<Chapter> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return "album{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", count=" + count +
                ", coverImg='" + coverImg + '\'' +
                ", score=" + score +
                ", author='" + author + '\'' +
                ", broadCast='" + broadCast + '\'' +
                ", brief='" + brief + '\'' +
                ", creatDate=" + createDate +
                ", publishDate=" + publishDate +
                ", status='" + status + '\'' +
                ", children=" + children +
                '}';
    }
}
