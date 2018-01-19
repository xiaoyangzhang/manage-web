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
public class MessageUtil {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	 @Autowired
	 private RestTemplate restTemplate;
	
	public boolean  pushMsg(String receiverId,String receiverType,String title,String content, String messageType) {
		 AppResult appResult;
			try {
				appResult = restTemplate.postForObject("http://dialog/dialog/sendmessage?userId={1}&userType={2}&messageTitle={3}&messageContent={4}&messageType={5}", null, AppResult.class, receiverId,receiverType, title, content,messageType);
				String lm=appResult.getStatus().getCode();
				if(lm.equals("200")) {
					logger.info("消息title:{},content:{},type:{} 给用户:{},type:{} 发送成功",title,content,messageType,receiverId,receiverType);
					return true;
				}
				else {
					logger.info("消息title:{},content:{},type:{} 给用户:{},type:{}发送失败",title,content,messageType,receiverId,receiverType);
					return false;
				}
			} catch (RestClientException e) {
				logger.info("消息title:{},content:{},type:{} 给用户:{},type:{}发送失败",title,content,messageType,receiverId,receiverType);
				logger.error(e.getMessage(),e);
				return false;
			} catch (Exception e){
				logger.info("消息title:{},content:{},type:{} 给用户:{},type:{}发送失败",title,content,messageType,receiverId,receiverType);
				logger.error(e.getMessage(),e);
				return false;
			}
	}
	
}
