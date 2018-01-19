package com.yhyt.health.util;

import com.github.tobato.fastdfs.domain.StorePath;
import com.github.tobato.fastdfs.exception.FdfsUnsupportStorePathException;
import com.github.tobato.fastdfs.service.FastFileStorageClient;
import com.yhyt.health.controller.ImageController;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;

/**
 * @author wangzhan@cis.com.cn
 * @version v1.0
 * @project business-biz
 * @Description
 * @encoding UTF-8
 * @date 2018/1/5
 * @time 下午4:33
 * @修改记录 <pre>
 * 版本       修改人         修改时间         修改内容描述
 * --------------------------------------------------
 * <p>
 *     v1.0 文件的上传工具类
 * --------------------------------------------------
 * </pre>
 */
@Component
public class FileUploadUtil {
    private static Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);

    @Resource
    private FastFileStorageClient storageClient;

    @Resource
    private DoctorConstant doctorConstant;

    @Value("${fdfs.filesize}")
    private long filesize;

    /**
     * 上传文件
     * @param file 文件对象
     * @return 文件访问地址
     * @throws IOException
     */
    public String uploadImage(MultipartFile file) throws IOException {
        boolean flag = null != file && file.getBytes().length>0? true : false;
        if(!flag){
            return "";
        }
        StorePath storePath = storageClient.uploadFile(file.getInputStream(),file.getSize(), FilenameUtils.getExtension(file.getOriginalFilename()),null);
        return getResAccessUrl(storePath);
    }

    /**
     * 批量上传文件
     * @param file 文件对象
     * @return 文件访问地址
     * @throws IOException
     */
    public String[] uploadImages(MultipartFile[] file) throws IOException {
        boolean flag = null != file && file.length>0? true : false;
        if(!flag){
            return null;
        }
        StorePath[] storePaths = new StorePath[file.length];
        int temp=0;
        for(MultipartFile fi : file){
            storePaths[temp] = storageClient.uploadFile(fi.getInputStream(),fi.getSize(), FilenameUtils.getExtension(fi.getOriginalFilename()),null);
            temp++;
        }
        String[] paths = new String[file.length];
        for(int i=0;i<paths.length;i++){
            paths[i] = getResAccessUrl(storePaths[i]);
        }
        return paths;
    }

    /**
     * 上传文件并同时生成缩略图
     * @param file 文件对象
     * @return 文件访问地址
     * @throws IOException
     */
    public String uploadImageAndCrtThumbImage(MultipartFile file) throws IOException {
        boolean flag = null != file && file.getBytes().length>0? true : false;
        if(!flag){
            return "";
        }
        StorePath storePath = storageClient.uploadImageAndCrtThumbImage(file.getInputStream(),file.getSize(), FilenameUtils.getExtension(file.getOriginalFilename()),null);
        return getResAccessUrl(storePath);
    }

    /**
     * 批量上传文件并同时生成缩略图
     * @param file 文件对象
     * @return 文件访问地址
     * @throws IOException
     */
    public String[] uploadImageAndCrtThumbImages(MultipartFile[] file) throws IOException {
        boolean flag = null != file && file.length>0? true : false;
        if(!flag){
            return null;
        }
        StorePath[] storePaths = new StorePath[file.length];
        int temp=0;
        for(MultipartFile fi : file){
            storePaths[temp] = storageClient.uploadImageAndCrtThumbImage(fi.getInputStream(),fi.getSize(), FilenameUtils.getExtension(fi.getOriginalFilename()),null);
            temp++;
        }
        String[] paths = new String[file.length];
        for(int i=0;i<paths.length;i++){
            paths[i] = getResAccessUrl(storePaths[i]);
        }
        return paths;
    }

    /**
     * 获取上传图片的像素 100_30 单位px
     * @param file
     * @return
     */
    public String getPixe(MultipartFile file){
        try {
            BufferedImage image =null;
            image = ImageIO.read(file.getInputStream());
            int width = image.getWidth();
            int height = image.getHeight();
            return width+"_"+height;
        } catch (IOException e) {
            logger.info("获取图片像素异常，图片名称{},异常描述{}",file.getName(),e.getMessage());
            return "";
        }
    }

    /**
     * 将一段字符串生成一个文件上传
     * @param content 文件内容
     * @param fileExtension
     * @return
     */
    public String uploadFile(String content, String fileExtension) {
        byte[] buff = content.getBytes(Charset.forName("UTF-8"));
        ByteArrayInputStream stream = new ByteArrayInputStream(buff);
        StorePath storePath = storageClient.uploadFile(stream,buff.length, fileExtension,null);
        return getResAccessUrl(storePath);
    }


    // 封装图片完整URL地址
    private String getResAccessUrl(StorePath storePath) {

        String fileUrl = doctorConstant.getFdfs().get("url")+ File.separator + storePath.getFullPath();

        return fileUrl;
    }

    /**
     * 删除文件
     * @param fileUrl 文件访问地址
     * @return
     */
    public void deleteFile(String fileUrl) {
        if (StringUtils.isEmpty(fileUrl)) {
            return;
        }
        try {
            StorePath storePath = StorePath.praseFromUrl(fileUrl);

            storageClient.deleteFile(storePath.getGroup(), storePath.getPath());

        } catch (FdfsUnsupportStorePathException e) {
            logger.warn(e.getMessage());
        }
    }


}
