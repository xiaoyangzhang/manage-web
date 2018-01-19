package com.yhyt.health.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.annotation.PostConstruct;
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

import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddressList;
import org.apache.poi.ss.usermodel.Workbook;
import org.jeecgframework.poi.excel.entity.enmus.ExcelType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.yhyt.health.model.SysConfig;

@Component    
public class DownLoadUtil {


    
    
	
	
	public static Workbook  downloadFIle(HttpServletRequest request, HttpServletResponse response,List t1,List t2,List t3,String sheetname,String filename, List newlist) {
		
	 	
	   	 Workbook workbook = exportExcel(t1,t2,t3,sheetname, ExcelType.HSSF);
	   	 
	   	 //设置成下拉列表
	      
//		     String[] strs = new String[]{"aa","bb","cc","dd","ee","ff","gg","hh","ii"};
		    
		   String[] strs = new String[newlist.size()];
		   for(int ne=0;ne<newlist.size();ne++) {
			   strs[ne]=newlist.get(ne).toString();
		   }
         //设置第一列的1-10行为下拉列表

         CellRangeAddressList regions = new CellRangeAddressList(0, t3.size(), 16, 18);

         //创建下拉列表数据

         DVConstraint constraint = DVConstraint.createExplicitListConstraint(strs);

         //绑定

         HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);

         workbook.getSheetAt(0).addValidationData(dataValidation);
//         sheet.addValidationData(dataValidation);
         
	   	 if(null!=request&&null!=response) {
	   	 try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	        response.setCharacterEncoding("UTF-8");
	        response.setContentType("application/x-download");
	        String filedisplay = filename;
	        try {
				filedisplay = URLEncoder.encode(filedisplay, "UTF-8");
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	        response.addHeader("Content-Disposition", "attachment;filename=" + filedisplay);

	        try {
	            OutputStream out = response.getOutputStream();
	            workbook.write(out);
	            out.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	   	 }
	        return workbook;
		}
	
	 
    public static  Workbook exportExcel(List t1,List t2,List t3,String sheetname, ExcelType type) {
    	
    	
    	
    	HSSFWorkbook workbook;
        if (ExcelType.HSSF.equals(type)) {
            workbook = new HSSFWorkbook();
        } else {
    //        workbook = new XSSFWorkbook();
            workbook = new HSSFWorkbook();
        }
        workbook=createExcel(workbook,t1,t2,t3,sheetname);
        return workbook;
    }
    
    
    
    public static  HSSFWorkbook createExcel(HSSFWorkbook book,
            List<String> heads, List<String> fieldList, List<Object> dataList,String sheettName) {
        HSSFWorkbook  workbook = book;
        if(workbook ==null)
            workbook= new HSSFWorkbook();
        
        if(sheettName==null||"".equals(sheettName))
            sheettName="sheet"+Math.random();
        
        HSSFSheet sheet = workbook.createSheet(sheettName); //
        sheet.setDefaultColumnWidth(20);  
        sheet.setDefaultRowHeightInPoints(20);
        // 在索引0的位置创建行（最顶端的行）
        HSSFRow row = sheet.createRow(0);
        HSSFCell cell=null;
       
       //创建表格第一行的标题
        for (int i = 0; i < heads.size(); i++) {
            // 在索引0的位置创建单元格（左上端）
            cell = row.createCell(i);
            // 定义单元格为字符串类型
            cell.setCellType(HSSFCell.CELL_TYPE_STRING);
            // 在单元格中输入一些内容
            cell.setCellValue(heads.get(i));
        }

        for (int n = 0; n < dataList.size(); n++) {
            // 在索引1的位置创建行（最顶端的行）
            HSSFRow row_value = sheet.createRow(n + 1);
            Map<String, String> dataMap =(Map<String, String>)dataList.get(n);
            HSSFCell cell_v=null;
            for (int i = 0; i < fieldList.size(); i++) {
                // 在索引0的位置创建单元格（左上端）
                cell_v = row_value.createCell(i);
                // 定义单元格为字符串类型
                cell_v.setCellType(HSSFCell.CELL_TYPE_STRING);
                // 在单元格中输入一些内容
                cell_v.setCellValue(String.valueOf(dataMap.get(fieldList.get(i))));
            }
        }
        return  workbook ;
    } 
    
    
    public static void exportandmail(List diseaseAddedList, boolean b,HttpServletRequest request, HttpServletResponse response, List newlist) {
 		// TODO Auto-generated method stub
 	    	  List<Map<String,Object>> list1 = new ArrayList<Map<String,Object>>();
 		      List<String> t1=new ArrayList<String>();
 		      t1.add("报告单位");
 		      t1.add("填表日期");
 		      t1.add("编号");
 		      t1.add("孕妇名称");
 		      t1.add("孕妇身份证号码");
 		      t1.add("年龄");
 		      t1.add("孕次");
 		      t1.add("产次");
 		      t1.add("丈夫姓名");
 		      t1.add("户口北京（区）");
 		      t1.add("户口外地（省）");
 		      t1.add("现住址");
 		      t1.add("手机");
 		      t1.add("手机号码");
 		      t1.add("孕周");
 		      t1.add("预产期");
 		      t1.add("高危因素1");
 		      t1.add("高危因素2");
 		      t1.add("高危因素3");
 		      t1.add("备注");
 		      t1.add("三联单回执");
 		      t1.add("转出单位");
 		      List<String> t2=new ArrayList<String>();
 		      t2.add("hospital");
 		      t2.add("createTime");
 		      t2.add("index");
 		      t2.add("realname");
 		      t2.add("idno");
 		      t2.add("age");
 		      t2.add("pregnantTime");
 		      t2.add("produceTime");
 		      t2.add("husbandName");
 		      t2.add("birthPlace1");
 		      t2.add("birthPlace2");
 		      t2.add("resideAdress");
 		      t2.add("husbandMobile");
 		      t2.add("username");
 		      t2.add("pregnantWeek");
 		      t2.add("expectBirthDate");
 		      t2.add("dangerous1");
 		      t2.add("dangerous2");
 		      t2.add("dangerous3");
 		      t2.add("remark");
 		      t2.add("threetime");
 		      t2.add("outhospital");
 		      List t3=new ArrayList();
 		      
 		      SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 		      for(int li=0;li<diseaseAddedList.size();li++) {
 		    	  Map temp=(Map) diseaseAddedList.get(li);
 		    	   Map m1=new HashMap();
 		    	      m1.put("hospital", temp.get("hospital"));
 		    	      if(null==temp.get("createTime")||"".equals(temp.get("createTime"))) {
 		    	    	  m1.put("createTime", "");
 		    	      }
 		    	      else {
 		    	    	  m1.put("createTime", simpleDateFormat.format(new Date(Long.parseLong( temp.get("createTime").toString()))));
 		    	      }
// 		    	      m1.put("createTime", simpleDateFormat.format(new Date(Long.parseLong( temp.get("createTime").toString()))));
 		    	      m1.put("index", li+1);
 		    	      m1.put("realname", temp.get("realname"));
 		    	      m1.put("idno", temp.get("idno"));
 		    	      m1.put("age", temp.get("age"));
 		    	      m1.put("pregnantTime", temp.get("pregnantTime"));
 		    	      m1.put("produceTime", temp.get("produceTime"));
 		    	      m1.put("husbandName", temp.get("husbandName"));
 		    	      if(null!=temp.get("birthPlace")&&!temp.get("birthPlace").equals("")) {
 		    	    	  if(temp.get("birthPlace").toString().contains("北京")) {
 		    	    		 m1.put("birthPlace1", temp.get("birthPlace"));
 	 	 		    	      m1.put("birthPlace2", "");
 		    	    	  }
 		    	    	  else {
 		    	    		 m1.put("birthPlace1", "");
 	 	 		    	      m1.put("birthPlace2", temp.get("birthPlace"));
 		    	    	  }
 		    	    	
 		    	      }
 		    	      else {
 		    	    	 m1.put("birthPlace1", "");
 	 		    	      m1.put("birthPlace2", "");
 		    	      }
 		    	     
 		    	      m1.put("resideAdress", temp.get("resideAdress"));
 		    	      m1.put("husbandMobile", temp.get("husbandMobile"));
 		    	      m1.put("username", temp.get("username"));
 		    	      m1.put("pregnantWeek", temp.get("pregnantWeek"));
 		    	      if(null==temp.get("expectBirthDate")||"".equals(temp.get("expectBirthDate"))) {
 		    	    	  m1.put("expectBirthDate", "");
 		    	      }
 		    	      else {
 		    	    	  m1.put("expectBirthDate", simpleDateFormat.format(new Date(Long.parseLong( temp.get("expectBirthDate").toString()))));
 		    	      }
 		    	      String dang=temp.get("dangerous").toString();
 		    	      if(null!=dang&&!"".equals(dang)) {
 		    	    	  String[] agr=dang.split(",");
 		    	    	  if(agr.length>=1&&null!=agr[0]) {
 		    	    		 m1.put("dangerous1", agr[0]);
 		    	    	  }
 		    	    	  
 		    	    	 if(agr.length>=2&&null!=agr[1]) {
 		    	    		 m1.put("dangerous2", agr[1]);
 		    	    	  }else {
 		    	    		 m1.put("dangerous2", "");
 	 	 		    	      m1.put("dangerous3", "");
 		    	    	  }
 		    	    	 if(agr.length>=3&&null!=agr[2]) {
 		    	    		 m1.put("dangerous3", agr[2]);
 		    	    	  }
 		    	    	 else {
 		    	    		 m1.put("dangerous3", "");
 		    	    	 }
 		    	      }
 		    	      else {
 		    	    	 m1.put("dangerous1", "");
 	 		    	      m1.put("dangerous2", "");
 	 		    	      m1.put("dangerous3", "");
 		    	      }
 		    	      
 		    	      m1.put("remark", temp.get("remark"));
 		    	      m1.put("threetime", "");
 		    	      m1.put("outhospital", "");
 		    	      t3.add(m1);
 		    	  
 		      }
 		   
 		      
 		      String filename="高危孕产妇信息上报录入表.xls";
 		      
 		      Workbook workbook=downloadFIle(request,response, t1, t2, t3, "表单1",filename,newlist);
 		      
 		      
 		      
 		     
             
             
             
             
             
 		      
 		      if(b) {
// 			ByteArrayOutputStream baos= new ByteArrayOutputStream();
// 			try {
// 				workbook.write(baos);  
// 				  baos.flush();  
// 				  byte[] bt = ((ByteArrayOutputStream) baos).toByteArray();  
// 				  InputStream is = new ByteArrayInputStream(bt, 0, bt.length);  
// 				  baos.close();  
// 				  sendMail(is);
// 			} catch (IOException e) {
// 				// TODO Auto-generated catch block
// 				e.printStackTrace();
// 			} 
 		      }
 	}

	
}
