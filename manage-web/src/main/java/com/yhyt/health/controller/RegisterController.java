package com.yhyt.health.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.mail.util.ByteArrayDataSource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.enmus.ExcelType;
import org.jeecgframework.poi.excel.entity.vo.MapExcelConstants;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.poi.excel.export.ExcelExportServer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.github.tobato.fastdfs.service.FastFileStorageClient;
import com.yhyt.health.configuration.WebPathConfiguration;
import com.yhyt.health.model.PatientlObstetrics;
import com.yhyt.health.model.query.DiseaseQuery;
import com.yhyt.health.model.query.DoctorDiseaseQuery;
import com.yhyt.health.model.query.ObstetricsQuery;
import com.yhyt.health.result.WebResult;
import com.yhyt.health.util.DownLoadUtil;
import com.yhyt.health.util.Page;

import io.swagger.annotations.ApiOperation;

/**
 * Created by localadmin on 17/12/4.
 */
@Controller
@RequestMapping("/register")
public class RegisterController {


    private static Logger logger = LoggerFactory.getLogger(DepartmentController.class);

    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private FastFileStorageClient storageClient;
    @Autowired
    private WebPathConfiguration webPathConfiguration;
	

    
    
    /*产科患者列表*/
    @RequestMapping("/toRegisterList")
    public String toRegisterList(){
        return "/register/register-list";
    }

    
    @RequestMapping(value = "/getObstetricsList",method = RequestMethod.POST)
    @ResponseBody
    public WebResult<Object> selectDiseaseList( ObstetricsQuery obstetricsQuery) {
        WebResult<Object> result = new WebResult<>();
        try {
//        	 Page pageInfo = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/disease/page?pageIndex={pageIndex}&pageSize={pageSize}&name={name}", Page.class, obstetricsQuery.getPageIndex(), obstetricsQuery.getPageSize(), obstetricsQuery.getName());
//                 List diseaseList = pageInfo.getResult();
                 ObstetricsQuery doctorDiseaseQuery=new ObstetricsQuery();
                doctorDiseaseQuery.setBirthTimeEnd(obstetricsQuery.getBirthTimeEnd());
                doctorDiseaseQuery.setBirthTimeStart(obstetricsQuery.getBirthTimeStart());
                doctorDiseaseQuery.setUsername(obstetricsQuery.getUsername());
                doctorDiseaseQuery.setRealname(obstetricsQuery.getRealname());
                doctorDiseaseQuery.setIsDangerous(obstetricsQuery.getIsDangerous());
                doctorDiseaseQuery.setPageSize(500);
                doctorDiseaseQuery.setPageIndex(1);
                PageInfo diseaseAddedList = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/getObstetricsList/query?queryStr={queryStr}", PageInfo.class, JSON.toJSONString(doctorDiseaseQuery));
//                List addedList = diseaseAddedList.getList();
            result.setCount(diseaseAddedList.getTotal());
            result.setList(diseaseAddedList.getList());
            return result;
        } catch (RestClientException e) {
            result.setCode("500");
        }

        return result;
    }
    
    @RequestMapping(value = "/getObstetricsDetailList",method = RequestMethod.POST)
    @ResponseBody
    public WebResult<Object> getObstetricsDetailList( ObstetricsQuery obstetricsQuery) {
        WebResult<Object> result = new WebResult<>();
        try {
//        	 Page pageInfo = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/disease/page?pageIndex={pageIndex}&pageSize={pageSize}&name={name}", Page.class, obstetricsQuery.getPageIndex(), obstetricsQuery.getPageSize(), obstetricsQuery.getName());
//                 List diseaseList = pageInfo.getResult();
                 ObstetricsQuery doctorDiseaseQuery=new ObstetricsQuery();
//                doctorDiseaseQuery.setBirthTimeEnd(obstetricsQuery.getBirthTimeEnd());
//                doctorDiseaseQuery.setBirthTimeStart(obstetricsQuery.getBirthTimeStart());
                doctorDiseaseQuery.setUsername(obstetricsQuery.getUsername());
                
//                doctorDiseaseQuery.setRealname(obstetricsQuery.getRealname());
//                doctorDiseaseQuery.setIsDangerous(obstetricsQuery.getIsDangerous());
                doctorDiseaseQuery.setPageSize(500);
                doctorDiseaseQuery.setPageIndex(1);
                List diseaseAddedList = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/getObstetricsDetailList/query?queryStr={queryStr}", List.class, JSON.toJSONString(doctorDiseaseQuery));
//                List addedList = diseaseAddedList.getList();
            result.setCount(diseaseAddedList.size());
            result.setList(diseaseAddedList);
            return result;
        } catch (RestClientException e) {
            result.setCode("500");
        }

        return result;
    }

    /*产科患者详情*/
    @RequestMapping("/toRegisterDetail")
    public String toRegisterDetail(HttpServletRequest request, HttpServletResponse response){
    	
    	String id = request.getParameter("id");
    	  WebResult<Object> result = new WebResult<>();
          try {
//          	 Page pageInfo = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/disease/page?pageIndex={pageIndex}&pageSize={pageSize}&name={name}", Page.class, obstetricsQuery.getPageIndex(), obstetricsQuery.getPageSize(), obstetricsQuery.getName());
//                   List diseaseList = pageInfo.getResult();
                   ObstetricsQuery doctorDiseaseQuery=new ObstetricsQuery();
//                  doctorDiseaseQuery.setBirthTimeEnd(obstetricsQuery.getBirthTimeEnd());
//                  doctorDiseaseQuery.setBirthTimeStart(obstetricsQuery.getBirthTimeStart());
                  doctorDiseaseQuery.setUsername(id);
                  
//                  doctorDiseaseQuery.setRealname(obstetricsQuery.getRealname());
//                  doctorDiseaseQuery.setIsDangerous(obstetricsQuery.getIsDangerous());
                  doctorDiseaseQuery.setPageSize(500);
                  doctorDiseaseQuery.setPageIndex(1);
                  List diseaseAddedList = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/getObstetricsDetailList/query?queryStr={queryStr}", List.class, JSON.toJSONString(doctorDiseaseQuery));
//                  List addedList = diseaseAddedList.getList();
              result.setCount(diseaseAddedList.size());
              result.setList(diseaseAddedList);
              SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
              for(int jj=0;jj<diseaseAddedList.size();jj++) {
            	  Map p=(Map) diseaseAddedList.get(jj);
            	  if(null!=p.get("createTime")&&!"".equals(p.get("createTime"))) {
            	  p.put("createTime", simpleDateFormat.format(new Date(Long.parseLong( p.get("createTime").toString()))));
            	  }
            	  else {
            		  p.put("createTime", "");
            	  }
            	  
            	  
            	  if(null!=p.get("expectBirthDate")&&!"".equals(p.get("expectBirthDate"))) {
                	  p.put("expectBirthDate", simpleDateFormat.format(new Date(Long.parseLong( p.get("expectBirthDate").toString()))));
                	  }
                	  else {
                		  p.put("expectBirthDate", "");
                	  }    
            	  
              }
          	request.setAttribute("userInfo",diseaseAddedList.get(0));
          	
          	
          	
          	
          	
            ObstetricsQuery doctorDisease=new ObstetricsQuery();
            doctorDisease.setPageSize(500);
            doctorDisease.setUsername(id);
            doctorDisease.setPageIndex(1);
            PageInfo doctorDiseaselist = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/getObstetricsListSingle/query?queryStr={queryStr}", PageInfo.class, JSON.toJSONString(doctorDisease));
        	request.setAttribute("userPatientInfo",doctorDiseaselist.getList().get(0));
          }
          catch(Exception e){
        	  e.printStackTrace();
          }
    	
    	
//    	Map sl=new HashMap();
//    	sl.put("username", "username");
    
        return "/register/register-details";
    }
    
    
    
    @RequestMapping("/getObstetricsDetailListExport")
    public String getObstetricsDetailListExport(HttpServletRequest request, HttpServletResponse response) {
    	
    	
    	String id=(String) request.getParameter("id");
    	
        ObstetricsQuery doctorDiseaseQuery=new ObstetricsQuery();
      doctorDiseaseQuery.setUsername(id);
      
      doctorDiseaseQuery.setPageSize(500);
      doctorDiseaseQuery.setPageIndex(1);
      List diseaseAddedList = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/getObstetricsDetailList/query?queryStr={queryStr}", List.class, JSON.toJSONString(doctorDiseaseQuery));

      
      
      Map<String, Object> mapPara = new HashMap<String, Object>();
      mapPara.put("dictCode", "800");
    com.yhyt.health.spring.AppResult result
    =restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/dictionary/dictionary/?dictCode={dictCode}", com.yhyt.health.spring.AppResult.class, mapPara);

    List newlist=new ArrayList();
    List<Map> lm=(List<Map>) result.getBody();
    for(int im=0;im<lm.size();im++) {
  	  Map p=lm.get(im);
  	  newlist.add(p.get("itemName").toString());
//  	  System.out.println(p.get("itemName"));
    }
      
      
      
      DownLoadUtil.exportandmail(diseaseAddedList,false,request,response,newlist);
    	
		return "高危孕产妇信息上报录入表.xls";
    }

    
    
    public static String myEmailAccount = "zhangheng@cis.com.cn";
    public static String myEmailPassword = "GC511g6467";

    // 发件人邮箱的 SMTP 服务器地址, 必须准确, 不同邮件服务器地址不同, 一般(只是一般, 绝非绝对)格式为: smtp.xxx.com
    // 网易163邮箱的 SMTP 服务器地址为: smtp.163.com
//    public static String myEmailSMTPHost = "smtp.163.com";
    
    public static String myEmailSMTPHost = "mail.cis.com.cn";
    // 收件人邮箱（替换为自己知道的有效邮箱）
    public static String receiveMailAccount = "zhangheng@cis.com.cn";

   
   @ApiOperation(value="定时发送邮件", notes="定时发送邮件")
   @GetMapping("/patient/sendMail")
   public void sendMail(InputStream  dh) {
        // 1. 创建参数配置, 用于连接邮件服务器的参数配置
        Properties props = new Properties();                    // 参数配置
        props.setProperty("mail.transport.protocol", "smtp");   // 使用的协议（JavaMail规范要求）
        props.setProperty("mail.smtp.host", myEmailSMTPHost);   // 发件人的邮箱的 SMTP 服务器地址
        props.setProperty("mail.smtp.auth", "true");            // 需要请求认证

        // PS: 某些邮箱服务器要求 SMTP 连接需要使用 SSL 安全认证 (为了提高安全性, 邮箱支持SSL连接, 也可以自己开启),
        //     如果无法连接邮件服务器, 仔细查看控制台打印的 log, 如果有有类似 “连接失败, 要求 SSL 安全连接” 等错误,
        //     打开下面 /* ... */ 之间的注释代码, 开启 SSL 安全连接。
        /*
        // SMTP 服务器的端口 (非 SSL 连接的端口一般默认为 25, 可以不添加, 如果开启了 SSL 连接,
        //                  需要改为对应邮箱的 SMTP 服务器的端口, 具体可查看对应邮箱服务的帮助,
        //                  QQ邮箱的SMTP(SLL)端口为465或587, 其他邮箱自行去查看)
        final String smtpPort = "465";
        props.setProperty("mail.smtp.port", smtpPort);
        props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.setProperty("mail.smtp.socketFactory.fallback", "false");
        props.setProperty("mail.smtp.socketFactory.port", smtpPort);
        */

        // 2. 根据配置创建会话对象, 用于和邮件服务器交互
        Session session = Session.getInstance(props);
        session.setDebug(true);                                 // 设置为debug模式, 可以查看详细的发送 log

        try {
			// 3. 创建一封邮件
			MimeMessage message = createMimeMessage(session, myEmailAccount, receiveMailAccount,dh);

			// 4. 根据 Session 获取邮件传输对象
			Transport transport = session.getTransport();

			// 5. 使用 邮箱账号 和 密码 连接邮件服务器, 这里认证的邮箱必须与 message 中的发件人邮箱一致, 否则报错
			// 
			//    PS_01: 成败的判断关键在此一句, 如果连接服务器失败, 都会在控制台输出相应失败原因的 log,
			//           仔细查看失败原因, 有些邮箱服务器会返回错误码或查看错误类型的链接, 根据给出的错误
			//           类型到对应邮件服务器的帮助网站上查看具体失败原因。
			//
			//    PS_02: 连接失败的原因通常为以下几点, 仔细检查代码:
			//           (1) 邮箱没有开启 SMTP 服务;
			//           (2) 邮箱密码错误, 例如某些邮箱开启了独立密码;
			//           (3) 邮箱服务器要求必须要使用 SSL 安全连接;
			//           (4) 请求过于频繁或其他原因, 被邮件服务器拒绝服务;
			//           (5) 如果以上几点都确定无误, 到邮件服务器网站查找帮助。
			//
			//    PS_03: 仔细看log, 认真看log, 看懂log, 错误原因都在log已说明。
			transport.connect(myEmailAccount, myEmailPassword);

			// 6. 发送邮件, 发到所有的收件地址, message.getAllRecipients() 获取到的是在创建邮件对象时添加的所有收件人, 抄送人, 密送人
			transport.sendMessage(message, message.getAllRecipients());

			// 7. 关闭连接
			transport.close();
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
   }
   
   public static MimeMessage createMimeMessage(Session session, String sendMail, String receiveMail,InputStream  dh) throws Exception {
        // 1. 创建一封邮件
        MimeMessage message = new MimeMessage(session);

        // 2. From: 发件人（昵称有广告嫌疑，避免被邮件服务器误认为是滥发广告以至返回失败，请修改昵称）
        message.setFrom(new InternetAddress(sendMail, "海虹控股", "UTF-8"));

        // 3. To: 收件人（可以增加多个收件人、抄送、密送）
        message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "童亚伟", "UTF-8"));

        // 4. Subject: 邮件主题（标题有广告嫌疑，避免被邮件服务器误认为是滥发广告以至返回失败，请修改标题）
        message.setSubject("20171212垂杨柳医院产科高危孕产妇信息上报表", "UTF-8");

        // 5. Content: 邮件正文（可以使用html标签）（内容有广告嫌疑，避免被邮件服务器误认为是滥发广告以至返回失败，请修改发送内容）
        message.setContent("您好，请查收邮件，附件内容为上周垂杨柳医院产科高危孕产妇信息上报表：如有问题请及时上报，客服电话：40081503", "text/html;charset=UTF-8");
        
        MimeBodyPart attachment = new MimeBodyPart();
//        DataHandler dh2 = new DataHandler(new FileDataSource("product.xls"));  // 读取本地文件
        DataSource source = new ByteArrayDataSource(dh, "application/msexcel"); 
        DataHandler dh2 = new DataHandler(source);  // 读取本地文件
        attachment.setDataHandler(dh2);                                             // 将附件数据添加到“节点”
        attachment.setFileName(MimeUtility.encodeText(dh2.getName()));
        attachment.setFileName("高危孕产妇信息上报录入表.xls");
        
        
        
        MimeMultipart mm = new MimeMultipart();
        mm.addBodyPart(attachment);     // 如果有多个附件，可以创建多个多次添加
        mm.setSubType("mixed");         // 混合关系

        // 11. 设置整个邮件的关系（将最终的混合“节点”作为邮件的内容添加到邮件对象）
        message.setContent(mm);
        // 6. 设置发件时间
        message.setSentDate(new Date());

        // 7. 保存设置
        message.saveChanges();

        return message;
    }
    

}


