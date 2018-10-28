package com.baizhi.zbl.entity;

import java.io.Serializable;

/**
 * Created by Administrator on 2018/10/27 0027.
 */
public class Chapter implements Serializable{
    private Integer id;
    private String title;
    private Double duration;
    private Double size;
    private String audioPath;
    private Integer albumId;
    private Album album;

    public Chapter() {
    }

    public Chapter(Integer id, String title, Double duration, Double size, String audioPath, Integer albumId, Album album) {
        this.id = id;
        this.title = title;
        this.duration = duration;
        this.size = size;
        this.audioPath = audioPath;
        this.albumId = albumId;
        this.album = album;
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

    public Double getDuration() {
        return duration;
    }

    public void setDuration(Double duration) {
        this.duration = duration;
    }

    public Double getSize() {
        return size;
    }

    public void setSize(Double size) {
        this.size = size;
    }

    public String getAudioPath() {
        return audioPath;
    }

    public void setAudioPath(String audioPath) {
        this.audioPath = audioPath;
    }

    public Integer getAlbumId() {
        return albumId;
    }

    public void setAlbumId(Integer albumId) {
        this.albumId = albumId;
    }

    public Album getAlbum() {
        return album;
    }

    public void setAlbum(Album album) {
        this.album = album;
    }

    @Override
    public String toString() {
        return "Chapter{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", duration=" + duration +
                ", size=" + size +
                ", audioPath='" + audioPath + '\'' +
                ", albumId=" + albumId +
                ", album=" + album +
                '}';
    }
}
