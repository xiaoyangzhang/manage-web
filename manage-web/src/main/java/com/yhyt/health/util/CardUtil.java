package com.yhyt.health.util;

import java.util.Map;

import com.yhyt.health.App;
import com.yhyt.health.result.AppResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;

@Component
public class CardUtil {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	 @Autowired
	 private RestTemplate restTemplate;
	
	public boolean  sendCard(String patientId) {
		 AppResult appResult;
			try {
				appResult = restTemplate.postForObject("http://system/patient/orders/giveOrder?isReceipt=false&patientId={1}", null, AppResult.class, patientId);
				String lm=appResult.getStatus().getCode();
				if(lm.equals("200")) {
					logger.info("消息patientId:{} 赠卡成功",patientId);
					return true;
				}
				else {
					logger.info("消息patientId:{} 赠卡失败",patientId);
					return false;
				}
			} catch (RestClientException e) {
				logger.info("消息patientId:{} 赠卡失败",patientId);
				logger.error(e.getMessage(),e);
				return false;
			} catch (Exception e){
				logger.info("消息patientId:{} 赠卡失败",patientId);
				logger.error(e.getMessage(),e);
				return false;
			}
	}
}
