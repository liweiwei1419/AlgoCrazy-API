package com.suanfa8.algocrazyapi.utils;

import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Component;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

@Slf4j
@Component
public class MyFileUtil {

    public void downloadFile(HttpServletResponse response, File file, String filename) throws IOException {
        OutputStream out = null;
        try {
            out = response.getOutputStream();
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
            response.setHeader("Content-Length", String.valueOf(FileUtils.sizeOf(file)));
            BufferedInputStream fis = new BufferedInputStream(new FileInputStream(file.getPath()));
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            IOUtils.copy(fis, toClient);
            out.flush();
        } catch (Exception e) {
            log.error("io异常", e);
        } finally {
            IOUtils.close(out);
        }
    }
}