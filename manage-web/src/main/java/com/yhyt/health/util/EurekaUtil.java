package com.yhyt.health.util;

import java.util.Map;

import com.yhyt.health.App;
import com.yhyt.health.constant.Constant;
import com.yhyt.health.result.AppResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;

@Component
public class EurekaUtil {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	 @Autowired
	 private RestTemplate restTemplate;
	
	public boolean  eurekateam(String patientId,String departmentId) {
	    //将患者加入科室
	    AppResult appResultnew = restTemplate.postForObject("http://DOCTOR/" + "addPatientDefaultGroup?patientId={1}&departmentId={2}", null, AppResult.class, patientId, departmentId);
	    if (!appResultnew.getStatus().getCode().equals("200")) {
	        throw new RuntimeException("服务异常，请稍后再试");
	    }
	    return true;
	}
}
