package com.baizhi.zbl.util;

import org.jaudiotagger.audio.AudioFileIO;

import org.jaudiotagger.audio.mp3.MP3AudioHeader;
import org.jaudiotagger.audio.mp3.MP3File;

import java.io.File;


/**
 * Created by Administrator on 2018/10/27 0027.
 */
public class MP3Util {
    public static String getDuration(File file) {
        int time=0;
        try {
            MP3File f = (MP3File) AudioFileIO.read(file);
            MP3AudioHeader audioHeader = (MP3AudioHeader) f.getAudioHeader();
            time = audioHeader.getTrackLength();
        } catch (Exception e) {
            e.printStackTrace();
        }
        int second=time % 60;
        int minite=time / 60;
        return minite+"分"+second+"秒";


    }
}
