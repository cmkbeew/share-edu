package com.fullstack4.shareedu.util;

import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.util.UUID;

@Log4j2
public class FileUploadUtil {
    public static HttpServletRequest getRequest() {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        return attr.getRequest();
    }
    public static String uploadFolder = "C:\\HK\\share-edu\\share-edu\\src\\main\\webapp\\resources\\img\\";


    public static String saveFile(MultipartFile multipartFile, String path) {
        String org_file_name = multipartFile.getOriginalFilename();
        String ext = org_file_name.substring(org_file_name.lastIndexOf("."), org_file_name.length());

        UUID uuid = UUID.randomUUID();
        String[] uuids = uuid.toString().split("-");
        String newName = uuids[0];

        File save_file = new File(uploadFolder + path + "\\" + newName + ext);

        if(!save_file.exists()) {
            save_file.mkdir();
        }

        try {
            multipartFile.transferTo(save_file);
        } catch(IllegalStateException e) {
            e.printStackTrace();
        } catch(Exception e) {
            e.printStackTrace();
        }

        return newName + ext;
    }

    public static void deleteFile(String save_file_name, String path) {
        try {
            File file = new File(uploadFolder + path + "\\" + URLDecoder.decode(save_file_name, "UTF-8"));

            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//파일 보여주기 시도
    public static ResponseEntity<byte[]> getFile(String fileName){
        File file=new File(uploadFolder+"\\"+File.separatorChar +fileName);
        log.info(file);
        ResponseEntity<byte[]> result=null;
        try {
            HttpHeaders headers=new HttpHeaders();
            headers.add("Content-Type", Files.probeContentType(file.toPath()));
            result=new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),headers, HttpStatus.OK );
        }catch (IOException e) {
            e.printStackTrace();
        }
        log.info("result : "+ result);
        return result;
    }
}
