package com.yhyt.health.controller;

import com.yhyt.health.configuration.WebPathConfiguration;
import com.yhyt.health.model.SysFeedback;
import com.yhyt.health.model.SysMessage;
import com.yhyt.health.result.WebResult;
import com.yhyt.health.util.Page;
import com.yhyt.health.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 意见投诉
 * @author localadmin
 *
 */
@RequestMapping("/sysPage")
@Controller
public class FeedbackController {
	@Autowired
	private RestTemplate restTemplate;
	private static Logger logger  = LoggerFactory.getLogger(FeedbackController.class);

	@Autowired
	private WebPathConfiguration webPathConfiguration;
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/feedback/{useType}")
	public String feedbackListByType(SysFeedback feedback, Model model, @PathVariable("useType")String userType){
		model.addAttribute("userType",userType);
		return "/feedback/feedbackList";
	}

	@RequestMapping("/feedback/list")
	@ResponseBody
	public WebResult<SysFeedback> getFeedbackListPage(SysFeedback sysFeedback, String startDate, String endDate, Integer pageIndex, Integer pageSize){
		WebResult<SysFeedback> result = new WebResult<>();
//		HttpHeaders headers = new HttpHeaders();
		try {
			Page forObject = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+
					"/sysfeedback/page?userId={0}&username={1}&useType={2}" +
							"&realname={3}&content={4}&dealState={5}" +
							"&startDate={startDate}&endDate={endDate}&pageIndex={pageIndex}&pageSize={pageSize}",
					Page.class,sysFeedback.getUserId(),sysFeedback.getUsername(),sysFeedback.getUseType(),sysFeedback.getRealname()
					,sysFeedback.getContent(),sysFeedback.getDealState(),startDate,endDate,pageIndex,pageSize);
			result.setList(forObject.getResult());
			result.setCount(forObject.getTotalRecord());
		} catch (RestClientException e) {
			result.setCode("500");
		}
		return result;
	}
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/feedback")
	public ModelAndView feedbackList(SysFeedback feedback){
		ModelAndView view  = new ModelAndView();
		view.setViewName("/feedback/feedbackList");
		view.addObject("feedback", feedback);
		return view;
	}

	@RequestMapping("/edit/{id}/{dealState}")
	@ResponseBody
	public WebResult<String> updateState(@PathVariable("id")long id, @PathVariable("dealState")byte state, HttpServletRequest request){
		WebResult<String> result = new WebResult<>();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		SysFeedback sysFeedback = new SysFeedback();
		sysFeedback.setId(id);
		sysFeedback.setDealState(state);
//		sysFeedback.setUserId(WebUtils.getCurrUserId(request));
		sysFeedback.setOperator(WebUtils.getCurrUserName(request));
		HttpEntity<SysFeedback> httpEntity = new HttpEntity<>(sysFeedback, headers);
		try {
			restTemplate.postForEntity(webPathConfiguration.getSystemUrl()+"/sysfeedback/edit",httpEntity,null);
		} catch (RestClientException e) {
			logger.error("update state error,error:{}",e);
			result.setCode("500");
		}
		return result;
	}
	
	@RequestMapping("/message/form")
	public ModelAndView toMessageFormList(SysMessage message){
		ModelAndView model = new ModelAndView();
		model.setViewName("/feedback/messageForm");
		model.addObject("message",message);
		return model;
	}
	
}
