package com.yhyt.health.controller;

import com.github.tobato.fastdfs.domain.StorePath;
import com.github.tobato.fastdfs.service.FastFileStorageClient;
import com.yhyt.health.result.WebResult;
import com.yhyt.health.util.DoctorConstant;
import com.yhyt.health.util.FileUploadUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;

@Controller
@RequestMapping("/img")
public class ImageController {

    private static Logger logger = LoggerFactory.getLogger(ImageController.class);

    @Autowired
    private FastFileStorageClient storageClient;
    @Autowired
    private DoctorConstant doctorConstant;
    @Value("${fdfs.filesize}")
    private long filesize;

    @Resource
    private FileUploadUtil fileUploadUtil;

    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    @ResponseBody
    public WebResult<String> uploadImg(@RequestParam("file") MultipartFile importFile) throws IOException {
        WebResult<String> result = new WebResult<>();
        if (importFile.getSize()>filesize){
            result.setCode("201");
            result.setMsg("请上传小于3M的图片");
            return result;
        }
        InputStream inputStream=importFile.getInputStream();
        StorePath storePath= storageClient.uploadImageAndCrtThumbImage(inputStream,importFile.getSize(),importFile.getOriginalFilename().split("\\.")[1],null);
//        storePath.getGroup();
//        storePath.getPath();
//        BufferedImage src = ImageIO.read(inputStream);
        result.setEntity(doctorConstant.getFdfs().get("url")+"/"+storePath.getFullPath());
        //storageClient.deleteFile(storePath.getGroup(), storePath.getPath());
        return result;
    }

    /*public static void main(String[] args) throws IOException, WriterException {
        String path="/Users/localadmin/Desktop";
        boolean jpeg = QrCodeCreateUtil.createQrCode(new FileOutputStream(
                new File(path+"/department.jpeg")), "", 900, "JPEG");
        FileInputStream fis = new FileInputStream(new File(path + "department.jpeg"));

    }*/


    @RequestMapping(value = "/uploadImgUtil",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public WebResult<String> uploadImgUtil(@RequestParam("file") MultipartFile importFile) throws IOException {
        WebResult<String> result = new WebResult<>();
        if (importFile.getSize()>filesize){
            result.setCode("201");
            result.setMsg("请上传小于3M的图片");
            return result;
        }
        result.setEntity(fileUploadUtil.uploadImageAndCrtThumbImage(importFile));
        result.setMsg(fileUploadUtil.getPixe(importFile));
        return result;
    }





}
