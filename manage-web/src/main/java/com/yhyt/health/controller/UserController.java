package com.yhyt.health.controller;

import com.yhyt.health.configuration.WebPathConfiguration;
import com.yhyt.health.model.Patientl;
import com.yhyt.health.result.AppResult;
import com.yhyt.health.result.WebResult;
import com.yhyt.health.util.Dictionary;
import com.yhyt.health.util.QueryByPage;
import com.yhyt.health.util.ResultForLayui;
import com.yhyt.health.util.WebUtils;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//查询页面的controller
@Controller
@RequestMapping("/newhealth")
public class UserController extends BaseController{
	
	 @Autowired
	 private RestTemplate restTemplate;
	 @Autowired
	 private WebPathConfiguration webPathConfiguration;

	@RequestMapping("/")
	public String indexl(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			id="index1";
			response.setCharacterEncoding("UTF-8");
			return getUrlPrefix(request)+Dictionary.pagepath+id;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：页面路由器
	 * 
	 * 
	 */
 //   @HystrixCommand(fallbackMethod="isWrongReturnBack")
	@RequestMapping("/index")
	public String index(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			String id2 = request.getParameter("id2");
//			System.out.println(getUrlPrefix(request));
			response.setCharacterEncoding("UTF-8");
			return getUrlPrefix(request)+Dictionary.pagepath+id;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：患者列表
	 * 
	 * 
	 */
	@RequestMapping(value="/patient",method=RequestMethod.POST)
	public String anotherindex(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String pageIndexrequest=request.getParameter("pageIndex");
			String pageSizerequest=request.getParameter("pageSize");
			String id1 = request.getParameter("id1");
			String begintime = request.getParameter("begintime");
			String endtime = request.getParameter("endtime");
			Map mp=new HashMap();
			mp.put("id",id);
			mp.put("begintime",begintime);
			mp.put("endtime",endtime);
		//	restTemplate=new RestTemplate();
			String url=Dictionary.BathRestUrl+"patientl?"+"id="+id+"&begintime="+begintime+"&endtime="+endtime;
			
			url=QueryByPage.getPageMake(request,url);
			
			List u= restTemplate.getForEntity(url, List.class).getBody();

			
//			List ls=(List) restTemplate.postForEntity("http://localhost:9090/hello", request, List.class);
	//		List<Patient> u = patientService.getPatientById(mp);
//			List u1=QueryByPage.getPage(request,u);
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			
			
			response.setCharacterEncoding("UTF-8");
			ResultForLayui rfl=new ResultForLayui();
			rfl.setRel("true");
			rfl.setMsg("获取成功");
			
			rfl.setCount(((Map)u.get(u.size()-1)).get("id").toString());
			u.remove(u.size()-1);
			rfl.setList(u);
			response.getWriter().print(JSONObject.fromObject(rfl).toString());
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：黑名单列表
	 * 
	 * 
	 */
	@RequestMapping(value="/blacklist",method=RequestMethod.POST)
	public String blacklist(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			String begintime = request.getParameter("begintime");
			String endtime = request.getParameter("endtime");
			Map mp=new HashMap();
			mp.put("id",id);
			mp.put("begintime",begintime);
			mp.put("endtime",endtime);
			
			
            String url=Dictionary.BathRestUrl+"blacklist?"+"id="+id+"&begintime="+begintime+"&endtime="+endtime;
			
            url=QueryByPage.getPageMake(request,url);
			List u= restTemplate.getForEntity(url, List.class).getBody();
			
			
//			List<Patient> u = patientService.getSysBlacklistById(mp);
//			List u1=QueryByPage.getPage(request,u);
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			
			
			response.setCharacterEncoding("UTF-8");
			ResultForLayui rfl=new ResultForLayui();
			rfl.setRel("true");
			rfl.setMsg("获取成功");
			rfl.setCount(((Map)u.get(u.size()-1)).get("id").toString());
			u.remove(u.size()-1);
			rfl.setList(u);
			
			response.getWriter().print(JSONObject.fromObject(rfl).toString());
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：删除黑名单
	 * 
	 * 
	 */
	@RequestMapping(value="/blacklistdelete",method=RequestMethod.POST)
	public String blacklistdelete(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			String operator=WebUtils.getCurrUserName(request);
		       String url=Dictionary.BathRestUrl+"blacklistdelete?"+"id="+id+"&operator="+operator;
				
				
				String u=restTemplate.getForEntity(url, String.class).getBody();
			
//			String u = patientService.delSysBlacklistById(id);
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			response.setCharacterEncoding("UTF-8");
			ResultForLayui rfl=new ResultForLayui();
			
			response.getWriter().print(u);
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：删除H5
	 * 
	 * 
	 */
	@RequestMapping(value="/h5delete",method=RequestMethod.POST)
	public String h5delete(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			
		       String url=Dictionary.BathRestUrl+"h5delete?"+"id="+id;
				
				
				String u=restTemplate.getForEntity(url, String.class).getBody();
			
//			String u = patientService.delSysBlacklistById(id);
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			response.setCharacterEncoding("UTF-8");
			ResultForLayui rfl=new ResultForLayui();
			
			response.getWriter().print(u);
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：订单列表
	 * 
	 * 
	 */
	@RequestMapping(value="/order",method=RequestMethod.POST)
	public String order(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			
			
			String begintime = request.getParameter("begintime");
			String endtime = request.getParameter("endtime");
			String servicetype = request.getParameter("servicetype");
			String orderno = request.getParameter("orderno");
			
			
			
			Map mp=new HashMap();
			mp.put("id",id);
			mp.put("begintime",begintime);
			mp.put("endtime",endtime);
			mp.put("servicetype",servicetype);
			mp.put("orderno",orderno);
			
			
            String url=Dictionary.BathRestUrl+"orderder?"+"id="+id+"&begintime="+begintime+"&endtime="+endtime+"&servicetype="+servicetype+"&orderno="+orderno;
			
            url=QueryByPage.getPageMake(request,url);
			List u=restTemplate.getForEntity(url, List.class).getBody();
			
//			List<Order> u = patientService.getOrderById(mp);
//			List u1=QueryByPage.getPage(request,u);
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			
			response.setCharacterEncoding("UTF-8");
			ResultForLayui rfl=new ResultForLayui();
			rfl.setRel("true");
			rfl.setMsg("获取成功");
			rfl.setCount(((Map)u.get(u.size()-1)).get("id").toString());
			u.remove(u.size()-1);
			rfl.setList(u);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(JSONObject.fromObject(rfl).toString());
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：诊后患者
	 * 
	 * 
	 */
	@RequestMapping(value="/dialogsign",method=RequestMethod.POST)
	public String dialogsign(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			
			String begintime = request.getParameter("begintime");
			String endtime = request.getParameter("endtime");
			String hospital = request.getParameter("hospital");
			String department = request.getParameter("department");
			String type = request.getParameter("type");
			Map mp=new HashMap();
			mp.put("id",id);
			mp.put("begintime",begintime);
			mp.put("endtime",endtime);
			mp.put("hospital",hospital);
			mp.put("department",department);
			mp.put("type",type);
			
		     String url=Dictionary.BathRestUrl+"dialogsign?"+"id="+id+"&begintime="+begintime+"&endtime="+endtime+"&hospital="+hospital+"&department="+department+"&type="+type;
				
		 	url=QueryByPage.getPageMake(request,url);
				List u=restTemplate.getForEntity(url, List.class).getBody();
			
//			List<DialogSignReview> u = patientService.getDialogSignReviewId(mp);
//			List u1=QueryByPage.getPage(request,u);
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			
			
			response.setCharacterEncoding("UTF-8");
			ResultForLayui rfl=new ResultForLayui();
			rfl.setRel("true");
			rfl.setMsg("获取成功");
			rfl.setCount(((Map)u.get(u.size()-1)).get("id").toString());
			u.remove(u.size()-1);
			rfl.setList(u);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(JSONObject.fromObject(rfl).toString());
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：诊后签到审核
	 * 
	 * 
	 */
	@RequestMapping(value="/dialogsignreview",method=RequestMethod.POST)
	public String dialogsignreview(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			String name1 = request.getParameter("name1");
			String hospital = request.getParameter("hospital");
			String state = request.getParameter("state");
			
			Map mp=new HashMap();
			mp.put("id",id);
			mp.put("name1",name1);
			mp.put("hospital",hospital);
			mp.put("state",state);
			
			  String url=Dictionary.BathRestUrl+"dialogsignreview?"+"id="+id+"&name1="+name1+"&hospital="+hospital+"&state="+state;
				
				url=QueryByPage.getPageMake(request,url);
				List u=restTemplate.getForEntity(url, List.class).getBody();
//			List<DialogSignReview> u = patientService.getDialogSignReviewId(mp);
//			List u1=QueryByPage.getPage(request,u);
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			
       
			response.setCharacterEncoding("UTF-8");
			ResultForLayui rfl=new ResultForLayui();
			rfl.setRel("true");
			rfl.setMsg("获取成功");
			rfl.setCount(((Map)u.get(u.size()-1)).get("id").toString());
			u.remove(u.size()-1);
			rfl.setList(u);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(JSONObject.fromObject(rfl).toString());
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：订单标记为已科室收支明细
	 * 
	 * 
	 */
	
	@RequestMapping(value="/orderdepartmentdetail",method=RequestMethod.POST)
	public String orderdepartmentdetail(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			
			
			
			String department = request.getParameter("department");
			String begintime = request.getParameter("begintime");
			String endtime = request.getParameter("endtime");
			Map mp=new HashMap();
			mp.put("id",id);
			mp.put("begintime",begintime);
			mp.put("endtime",endtime);
			mp.put("department",department);
			  String url=Dictionary.BathRestUrl+"orderdepartmentdetail?"+"id="+id+"&begintime="+begintime+"&endtime="+endtime+"&department="+department;
			  url=QueryByPage.getPageMake(request,url);
				
				List u=restTemplate.getForEntity(url, List.class).getBody();
				
//			List<OrderDepartmentDetail> u = patientService.getOrderdepartmentdetailId(mp);
//			List u1=QueryByPage.getPage(request,u);
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			
			response.setCharacterEncoding("UTF-8");
			ResultForLayui rfl=new ResultForLayui();
			rfl.setRel("true");
			rfl.setMsg("获取成功");
			rfl.setCount(((Map)u.get(u.size()-1)).get("id").toString());
			u.remove(u.size()-1);
			rfl.setList(u);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(JSONObject.fromObject(rfl).toString());
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	
	
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：用户消费明细
	 * 
	 * 
	 */
	@RequestMapping(value="/orderdetail",method=RequestMethod.POST)
	public String orderdetail(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String id1 = request.getParameter("id1");
			
			
			String serviceno = request.getParameter("serviceno");
			String begintime = request.getParameter("begintime");
			String endtime = request.getParameter("endtime");
			Map mp=new HashMap();
			mp.put("id",id);
			mp.put("begintime",begintime);
			mp.put("endtime",endtime);
			mp.put("serviceno",serviceno);
			
			  String url=Dictionary.BathRestUrl+"orderdetail?"+"id="+id+"&begintime="+begintime+"&endtime="+endtime+"&serviceno="+serviceno;
				
			  url=QueryByPage.getPageMake(request,url);
				List u=restTemplate.getForEntity(url, List.class).getBody();
//			List<OrderDetail> u = patientService.getOrderdetailId(mp);
			List u1=QueryByPage.getPage(request,u);
			
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			
		    
			response.setCharacterEncoding("UTF-8");
			ResultForLayui rfl=new ResultForLayui();
			rfl.setRel("true");
			rfl.setMsg("获取成功");
			rfl.setCount(((Map)u.get(u.size()-1)).get("id").toString());
			u.remove(u.size()-1);
			rfl.setList(u);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(JSONObject.fromObject(rfl).toString());
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
	
	
	/*
	 * 
	 * 张衡
	 * 
	 * 实现功能：设备名称列表
	 * 
	 * 
	 */
	@RequestMapping(value="/syslink",method=RequestMethod.POST)
	public String syslink(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String maindataid = request.getParameter("maindataid");
			String type = request.getParameter("type");
			
			  String url=Dictionary.BathRestUrl+"syslink?"+"id="+id+"&maindataid="+maindataid+"&type="+type;
				
				
				List u=restTemplate.getForEntity(url, List.class).getBody();
			
			
//			List<SysLink> u = patientService.getSyslinkId(id,null);
			List u1=QueryByPage.getPage(request,u);
			if(u!=null){
				request.setAttribute("userInfo", u);
			}
			response.setCharacterEncoding("UTF-8");
			
		
			ResultForLayui rfl=new ResultForLayui();
			rfl.setRel("true");
			rfl.setMsg("获取成功");
			rfl.setList(u1);
			rfl.setCount(String.valueOf(u.size()));
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(JSONObject.fromObject(rfl).toString());
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
    
    public String isWrongReturnBack(HttpServletRequest request, HttpServletResponse response){
    	
    	return getUrlPrefix(request)+"/index";

    }

    @RequestMapping("/patient/toEdit/{id}")
	public String toEditPatient(@PathVariable("id")Long id, Model model){
		ResponseEntity<AppResult> responseEntity = restTemplate.getForEntity(webPathConfiguration.getPatientUrl() + "/patient/info/" + id, AppResult.class);
		if (responseEntity!=null && responseEntity.getStatusCodeValue()==HttpStatus.OK.value()){
			model.addAttribute("patient",responseEntity.getBody().getBody().get("patient"));
		}
		return "/newhealth/pages/patient/patient-edit";
	}

    @RequestMapping("/patient/edit")
	@ResponseBody
	public WebResult<String> editPatient(@RequestBody Patientl patient,HttpServletRequest request){
		WebResult<String> result = new WebResult<>();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		patient.setOperator(WebUtils.getCurrUserName(request));
		HttpEntity<Patientl> httpEntity = new HttpEntity<>(patient, headers);
		try {
			ResponseEntity<AppResult> responseEntity = restTemplate.postForEntity(webPathConfiguration.getPatientUrl()+ "/patient/edit", httpEntity, AppResult.class);
			if (responseEntity!=null && responseEntity.getStatusCodeValue()== HttpStatus.OK.value()){

            }
		} catch (RestClientException e) {
			result.setCode("500");
		}

		return result;
	}
}
