package com.yhyt.health.controller;

import com.yhyt.health.entity.SysMenuEntity;
import com.yhyt.health.entity.SysUserEntity;
import com.yhyt.health.service.ShiroService;
import com.yhyt.health.service.SysUserService;
import com.yhyt.health.service.SysUserTokenService;
import com.yhyt.health.util.R;
import com.yhyt.health.util.WebUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@Controller
public class ConsoleWebController {

//	@Autowired
//	private RestTemplate restTemplate;

	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysUserTokenService sysUserTokenService;
	@Autowired
	private ShiroService shiroService;
	
	@RequestMapping(value = "/")
	public String index(HttpServletRequest request,Model model) {
		model.addAttribute("username", WebUtils.getCurrUserName(request));
		return "index";
	}
	
	@RequestMapping(value="/toLogin")
	public String toLogin(){
		return "login";
	}
	@RequestMapping(value="/menus")
	@ResponseBody
	public List getPermissions(HttpSession session){
		List permissions = new ArrayList<Map>();
//		permissions = this.restTemplate.getForObject("", null,null);
		long userId = (long) session.getAttribute("userId");
		List<SysMenuEntity> menuList = shiroService.getUserMenuList(userId);

		for (SysMenuEntity sysMenuEntity : menuList) {
			if(sysMenuEntity.getMenuId() == 1)
				continue;
			if(sysMenuEntity.getList().isEmpty())
				continue;
			Map<String,Object> permission = new HashMap<String,Object>();
			permission.put("title", sysMenuEntity.getName());
			permission.put("icon",sysMenuEntity.getIcon());
			permission.put("spread",false);
			List children = new ArrayList<Map>();
			for (Object o : sysMenuEntity.getList()) {
				SysMenuEntity submenu = (SysMenuEntity) o;
				HashMap sub_menu = new HashMap<String,Object>();
				sub_menu.put("title", submenu.getName());
				sub_menu.put("icon",submenu.getIcon());
				sub_menu.put("href",submenu.getUrl());
				children.add(sub_menu);
			}
			permission.put("children", children);
			permissions.add(permission);
		}
		/*Map<String,Object> permission = new HashMap<String,Object>();
		permissions.add(permission);
		List children = new ArrayList<Map>();
		permission.put("title", "医生用户");
		permission.put("icon","fa-user-circle-o");
		permission.put("spread",false);
		permission.put("children", children);

		permission = new HashMap<String,Object>();
		permission.put("title", "用户列表");
		permission.put("icon","fa-user-o");
		permission.put("href","/doctor/toDoctorList");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "医生信息审核");
		permission.put("icon","fa-user-md");
		permission.put("href","/doctor/toDoctorReviewList");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "医院科室维护");
		permission.put("icon","fa-hospital-o");
		permission.put("href","/hospital/toHospitalList");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "名医管理");
		permission.put("icon","fa-street-view");
		permission.put("href","/doctor/toFamousDoctorList");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "黑名单");
		permission.put("icon","fa-trash-o");
		permission.put("href","/doctor/toBlacklist");
		children.add(permission);
		

		//zhangheng 
		
		permission = new HashMap<String,Object>();
		permissions.add(permission);
		children = new ArrayList<Map>();
		permission.put("title", "患者用户");
		permission.put("icon","fa-user-circle");
		permission.put("spread",false);
		permission.put("children", children);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "患者列表");
		permission.put("icon","fa-users");
//		permission.put("href","/doctor/patient");
		permission.put("href","newhealth/index?id=pages/patient/patient");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "诊后患者");
		permission.put("icon","fa-address-book");
		permission.put("href","newhealth/index?id=pages/patient/dialogsign");
		children.add(permission);
			
		permission = new HashMap<String,Object>();
		permission.put("title", "黑名单");
		permission.put("icon","fa-trash");
		permission.put("href","newhealth/index?id=pages/patient/patientblacklist");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "诊后签到审核");
		permission.put("icon","fa-vcard");
		permission.put("href","newhealth/index?id=pages/patient/dialogsignreview");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "H5 new");
		permission.put("icon","fa-television");
		permission.put("href","newhealth/index?id=pages/patient/syslink");
		children.add(permission);
		
		
		
		permission = new HashMap<String,Object>();
		permissions.add(permission);
		children = new ArrayList<Map>();
		permission.put("title", "业务管理");
		permission.put("icon","fa-cogs");
		permission.put("spread",false);
		permission.put("children", children);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "对话管理");
		permission.put("icon","fa-comments");
		permission.put("href","newhealth/index?id=pages/business/dialoglist");
		children.add(permission);
		
		
		
		permission = new HashMap<String,Object>();
		permission.put("title", "服务卡管理");
		permission.put("icon","fa-address-card");
		permission.put("href","newhealth/index?id=pages/business/dictservicecardlist");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "评价结果");
		permission.put("icon","fa-commenting");
		permission.put("href","newhealth/index?id=pages/business/evaluateresult");
		children.add(permission);
		
		
		
		
		
		
		permission = new HashMap<String,Object>();
		permissions.add(permission);
		children = new ArrayList<Map>();
		permission.put("title", "订单及财务");
		permission.put("icon","fa-money");
		permission.put("spread",false);
		permission.put("children", children);
		
		
		permission = new HashMap<String,Object>();
		permission.put("title", "订单列表");
		permission.put("icon","fa-list-alt");
		permission.put("href","newhealth/index?id=pages/order/order");
		children.add(permission);
		
		
//		permission = new HashMap<String,Object>();
//		permission.put("title", "订单列表servicecarddetail");
//		permission.put("icon","fa-cubes");
//		permission.put("href","pages/order/servicecarddetail.jsp");
//		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "用户消费明细");
		permission.put("icon","fa-credit-card-alt");
		permission.put("href","newhealth/index?id=pages/order/orderdetail");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "科室收费明细");
		permission.put("icon","fa-credit-card");
		permission.put("href","newhealth/index?id=pages/order/orderdepartmentdetail");
		children.add(permission);
		
		
		//zhangheng
		permission = new HashMap<String,Object>();
		permissions.add(permission);
		children = new ArrayList<Map>();
		permission.put("title", "意见反馈与投诉");
		permission.put("icon","fa-asl-interpreting");
		permission.put("spread",false);
		permission.put("children", children);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "医生意见反馈");
		permission.put("icon","fa-assistive-listening-systems");
		permission.put("href","/sysPage/feedback/2");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "患者意见反馈");
		permission.put("icon","fa-deaf");
		permission.put("href","/sysPage/feedback/1");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "患者投诉管理");
		permission.put("icon","fa-exclamation-triangle");
		permission.put("href","/complaintPage/complaint");
		children.add(permission);
		
		
		permission = new HashMap<String,Object>();
		permissions.add(permission);
		children = new ArrayList<Map>();
		permission.put("title", "字典库/基础数据");
		permission.put("icon","fa-archive");
		permission.put("spread",false);
		permission.put("children", children);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "疾病库");
		permission.put("icon","fa-heartbeat");
		permission.put("href","/dictPage/disease");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "城市维护");
		permission.put("icon","fa-bank");
		permission.put("href","/cityPage/city");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "疾病分组");
		permission.put("icon","fa-database");
		permission.put("href","/dictPage/diseaseGroup");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "科室分类库");
		permission.put("icon","fa-cubes");
		permission.put("href","/dictPage/dictDepartment");
		children.add(permission);
		
		permission = new HashMap<String,Object>();
		permission.put("title", "各类字典维护");
		permission.put("icon","fa-sitemap");
		permission.put("href","/dictPage/dictionary");
		children.add(permission);*/
		
		
		return permissions;
	}

	/**
	 * 获取权限
	 */
	@GetMapping("/permissions")
	@ResponseBody
	public Object permissions(HttpSession session){
		long userId = (long) session.getAttribute("userId");
		Set<String> permissions = shiroService.getUserPermissions(userId);
		return R.ok().put("permissions",permissions);
	}

	/**
	 * 登录
	 */
	@RequestMapping(value = "/manage/login", method = RequestMethod.POST)
	public Object login(String username, String password, HttpSession session,Model model)throws IOException {
		//用户信息
		SysUserEntity user = sysUserService.queryByUserName(username);

		//账号不存在、密码错误
		if(user == null || !user.getPassword().equals(new Sha256Hash(password, user.getSalt()).toHex())) {
//			return R.error("账号或密码不正确");
			model.addAttribute("error","账号或密码不正确");
			return "redirect:/toLogin";
		}

		//账号锁定
		if(user.getStatus() == 0){
//			return R.error("账号已被锁定,请联系管理员");
			model.addAttribute("error","账号已被锁定,请联系管理员");
			return "redirect:/toLogin";
		}

		//生成token，并保存到数据库
		R r = sysUserTokenService.createToken(user.getUserId());
		session.setAttribute("token",r);
		session.setAttribute("userId",user.getUserId());
		session.setAttribute("username",username);
		return "redirect:/";
	}

	@GetMapping("/manage/logout")
	public Object logout(HttpServletRequest request){
		request.getSession().invalidate();
		return "redirect:/";
	}
}
