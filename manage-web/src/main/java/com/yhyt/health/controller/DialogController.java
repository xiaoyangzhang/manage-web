package com.yhyt.health.controller;

import com.yhyt.health.util.Dictionary;
import com.yhyt.health.util.QueryByPage;
import com.yhyt.health.util.ResultForLayui;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/*
 * ：张衡
 * 对话业务restful风格实现类
 */
@Controller
@RequestMapping("/newhealth")
public class DialogController  extends BaseController{
	
	
	 @Autowired
	 private RestTemplate restTemplate;
		
		/*
		 * 
		 * 张衡
		 * 
		 * 实现功能：获取对话列表
		 * 
		 * 
		 */
	@RequestMapping(value="/dialog",method=RequestMethod.POST)
	public String dialog(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String pageIndexrequest=request.getParameter("pageIndex");
			String pageSizerequest=request.getParameter("pageSize");
			String id1 = request.getParameter("id1");
			String hospital = request.getParameter("hospital");
			String department = request.getParameter("department");
			
			Map mp=new HashMap();
			mp.put("id",id);
			mp.put("hospital",hospital);
			mp.put("department",department);
	
			String url=Dictionary.BathRestUrl+"dialogg?"+"id="+id+"&hospital="+hospital+"&department="+department;
			
			url=QueryByPage.getPageMake(request,url);
			List u=restTemplate.getForEntity(url, List.class).getBody();
			
//			List<Dialog> u = dialogService.getDialogAllId(mp);
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
	 * 实现功能：服务订单
	 * 
	 * 
	 */
	@RequestMapping(value="/dictservicecardlist",method=RequestMethod.POST)
	public String dictservicecardlist(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String pageIndexrequest=request.getParameter("pageIndex");
			String pageSizerequest=request.getParameter("pageSize");
			String id1 = request.getParameter("id1");
			

			String url=Dictionary.BathRestUrl+"dictservicecardlist?"+"id="+id;
			
			
			List u=restTemplate.getForEntity(url, List.class).getBody();
			
//			List<DictServiceCard> u = dialogService.dictservicecardlist(id);
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
	 * 实现功能：评价结果
	 * 
	 * 
	 */
	@RequestMapping(value="/evaluateresult",method=RequestMethod.POST)
	public String evaluateresult(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String username = request.getParameter("username");
			String department = request.getParameter("department");
			String province = request.getParameter("province");
			String city = request.getParameter("city");
			String pageIndexrequest=request.getParameter("pageIndex");
			String pageSizerequest=request.getParameter("pageSize");
			String id1 = request.getParameter("id1");
			Map mp=new HashMap();
			
			mp.put("username",username);
			mp.put("department",department);
			mp.put("province",province);
			mp.put("city",city);
			
            String url=Dictionary.BathRestUrl+"evaluateresult?"+"username="+username+"&department="+department+"&province="+province+"&city="+city;
            url=QueryByPage.getPageMake(request,url);
			
			List u=restTemplate.getForEntity(url, List.class).getBody();
			
//			List<DeptEvaluateResult> u = dialogService.evaluateresult(mp);
//			List<DeptEvaluateResult> u1=QueryByPage.getPage(request,u);
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
	 * 实现功能：评价结果详情
	 * 
	 * 
	 */
	@RequestMapping(value="/evaluatelog",method=RequestMethod.POST)
	public String evaluatelog(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String username = request.getParameter("username");
			String department = request.getParameter("department");
			String province = request.getParameter("province");
			String city = request.getParameter("city");
			String pageIndexrequest=request.getParameter("pageIndex");
			String pageSizerequest=request.getParameter("pageSize");
			String id1 = request.getParameter("id1");
			
			 String url=Dictionary.BathRestUrl+"evaluatelog?"+"id="+id;
				
				
				List u=restTemplate.getForEntity(url, List.class).getBody();
//			List<DeptEvaluateLog> u = dialogService.evaluatelog(id);
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
	 * 实现功能：对话内容
	 * 
	 * 
	 */
	@RequestMapping(value="/dialogdetaila",method=RequestMethod.POST)
	public String dialogdetail(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String patientid = request.getParameter("patientid");
			String departmentid = request.getParameter("departmentid");
			String username = request.getParameter("username");
			String id1 = request.getParameter("id1");
			if(null==patientid||null==departmentid||"".equals(patientid)||"".equals(departmentid)) {
				
				return null;
			}
            Map mp=new HashMap();
			
			mp.put("id",id);
			mp.put("patientid",patientid);
			mp.put("departmentid",departmentid);
			mp.put("username",username);
//			mp.put("city",city);
			
			
			Object appResult;
			try {
				appResult = restTemplate.postForObject("http://dialog/dialog/patient/getchatrecords?departmentId={1}&patientId={2}", null, Object.class, departmentid,patientid);
				String lm=((Map)((Map)appResult).get("status")).get("code").toString();
				if(lm.equals(Dictionary.Value_200)) {
					List st=(List)((Map)appResult).get("body");
					
					for(int ss=0;ss<st.size();ss++) {
						
						Map pa=(Map)st.get(ss);
						if(null!=pa.get("fromUserId")) {
							if(pa.get("fromUserId").toString().substring(0, 1).equals("1")) {
								pa.put("doctororpatient", "医生");
							}
							
							else if(pa.get("fromUserId").toString().substring(0, 1).equals("2")) {
								pa.put("doctororpatient", "患者");
							}
							else {
								
								pa.put("doctororpatient", "未知");
							}
							
							
						}
						
					}
					
					response.setCharacterEncoding("UTF-8");
					ResultForLayui rfl=new ResultForLayui();
					rfl.setRel("true");
					rfl.setMsg("获取成功");
					rfl.setList(st);
					rfl.setCount(String.valueOf(st.size()));
					
					response.getWriter().print(JSONObject.fromObject(rfl).toString());
					return null;
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				response.getWriter().print(Dictionary.Result_Fail);
				return null;
			}
			
			return null;
			
			
//            String url=Dictionary.BathRestUrl+"dialogdetail?"+"id="+id+"&patientid="+patientid+"&departmentid="+departmentid+"&username="+username;
//			
//			
//			List u=restTemplate.getForEntity(url, List.class).getBody();
//			
////			List<DialogDetail> u = dialogService.dialogdetail(mp);
//			List u1=QueryByPage.getPage(request,u);
//			if(u!=null){
//				request.setAttribute("userInfo", u);
//			}
//			
//			response.setCharacterEncoding("UTF-8");
//			ResultForLayui rfl=new ResultForLayui();
//			rfl.setRel("true");
//			rfl.setMsg("获取成功");
//			rfl.setList(u1);
//			rfl.setCount(String.valueOf(u.size()));
//			
//			response.getWriter().print(JSONObject.fromObject(rfl).toString());
//			return null;

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
	 * 实现功能：服务卡消耗详情
	 * 
	 * 
	 */
	@RequestMapping(value="/servicecarddetail",method=RequestMethod.POST)
	public String servicecarddetail(HttpServletRequest request, HttpServletResponse response){
		try{
			String id = request.getParameter("id");
			String username = request.getParameter("username");
			String department = request.getParameter("department");
			String province = request.getParameter("province");
			String city = request.getParameter("city");
			String pageIndexrequest=request.getParameter("pageIndex");
			String pageSizerequest=request.getParameter("pageSize");
			String id1 = request.getParameter("id1");
			

            String url=Dictionary.BathRestUrl+"servicecarddetail?"+"id="+id;
			
			
			List u=restTemplate.getForEntity(url, List.class).getBody();
			
//			List<ServicecardDetail> u = dialogService.servicecarddetail(id);
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
			
			response.getWriter().print(JSONObject.fromObject(rfl).toString());
			return null;

		}catch(Exception e){
			logger.error("用户首页出错",e);
			request.setAttribute("error", e);
			return forward(ERROR);
		}
	}
	
}