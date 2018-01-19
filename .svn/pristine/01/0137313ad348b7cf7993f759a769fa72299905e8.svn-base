package com.yhyt.health.controller;

import com.alibaba.fastjson.JSON;
import com.yhyt.health.configuration.WebPathConfiguration;
import com.yhyt.health.model.ArticleDTO;
import com.yhyt.health.model.DeptDisease;
import com.yhyt.health.model.ItemClassification;
import com.yhyt.health.model.dto.ItemBody;
import com.yhyt.health.model.dto.ItemBodyReturnVo;
import com.yhyt.health.model.dto.ItemQueryDTO;
import com.yhyt.health.model.dto.ItemResultDTO;
import com.yhyt.health.model.vo.DoctorDiseaseVO;
import com.yhyt.health.result.WebResult;
import com.yhyt.health.spring.AppResult;
import com.yhyt.health.util.Page;
import com.yhyt.health.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/item")
public class ItemController {
    private static final  Logger logger = LoggerFactory.getLogger(DictWebController.class);

    @Resource
    private RestTemplate restTemplate;

    @Resource
    private WebPathConfiguration webPathConfiguration;

    /**
     * 点击商品管理菜单，进入商品管理页面
     * @return
     */
    @RequestMapping("/itemAdd")
    public ModelAndView itemAdd(){
        ModelAndView model = new ModelAndView();
        model.setViewName("/item/item-add");
        return model;
    }

    /**
     * 点击商品管理菜单，进入商品管理页面
     * @return
     */
    @RequestMapping("/itemList")
    public ModelAndView itemList(){
        ModelAndView model = new ModelAndView();
        model.setViewName("/item/item-list");
        return model;
    }

    /**
     * 点击选择医院，加载医院列表
     * @return
     */
    @RequestMapping("/itemHospital")
    public ModelAndView itemHospital(){
        List provinces = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/city/?level=1", List.class);
        ModelAndView model = new ModelAndView();
        model.addObject("provinces",provinces);
        model.setViewName("/item/item-hospital");
        return model;
    }

    @RequestMapping("/itemDepartment/{hospitalId}")
    public ModelAndView toQuestionnaireDept(@PathVariable Long hospitalId){
        List deptCategories = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/getDepartmentList/"+hospitalId, List.class);
        ModelAndView model = new ModelAndView();
        model.addObject("deptCategories",deptCategories);
        model.setViewName("/item/item-department");
        return model;
    }

    /**
     * 点击添加疾病按钮，进入添加疾病页面
     * @return
     */
    @RequestMapping("/itemDisease")
    public ModelAndView itemDisease(){
        ModelAndView model = new ModelAndView();
        model.setViewName("/item/item-disease");
        return model;
    }


    /**
     * 商品分页查询接口
     * @return
     */
    @RequestMapping("/queryItemListPage")
    @ResponseBody
    public WebResult<ItemResultDTO> queryItemListPage(ItemQueryDTO itemQueryDTO){
        WebResult<ItemResultDTO> result = new WebResult<>();
        try {
            Page list = restTemplate.getForObject(webPathConfiguration.getSystemUrl() + "/itemManage/queryItemListPage?itemQueryDTO={itemQueryDTO}", Page.class, JSON.toJSONString(itemQueryDTO));
            result.setList(list.getResult());
            result.setCount(list.getTotalRecord());
            return result;
        }catch (RestClientException e) {
            result.setCode("500");
            return result;
        }
    }

    @RequestMapping("/getItemClassification")
    public ModelAndView dictProvinceList(){
        ModelAndView model = new ModelAndView();
        List<ItemClassification> list = null;
        try{
            list = restTemplate.getForObject(webPathConfiguration.getSystemUrl() + "/itemManage/getItemClassification", List.class);
        }catch (Exception e){
            e.printStackTrace();
        }
        model.addObject("classifications",list);
        model.setViewName("/item/item-sort");
        return model;
    }

    /**
     * 点击商品编辑的接口 （根据商品id查询商品信息接口）
     */
    @RequestMapping("/getItemMessage/{id}/{action}")
    public ModelAndView getItemMessage(@PathVariable("id") long id,@PathVariable("action")String action){

        ModelAndView model = new ModelAndView();
        ItemBodyReturnVo vo = null;
        try{
            vo = restTemplate.getForObject(webPathConfiguration.getSystemUrl() + "/itemManage/getItemMessage/"+id, ItemBodyReturnVo.class);
        }catch (Exception e){
            e.printStackTrace();
        }
        model.addObject("ItemBodyReturnVo",vo);
        model.addObject("action",action);
        model.setViewName("/item/item-edit");
        return model;
    }

    /**
     * 添加／修改商品信息
     * @param itemBody
     * @param request
     * @return
     */
    @RequestMapping(value = "/addItem",method = RequestMethod.POST)
    @ResponseBody
    public WebResult<String> addItem(@RequestBody ItemBody itemBody, HttpServletRequest request){

        WebResult<String> result = new WebResult<String>();
        //获取当前登陆后台用户
        String currentName = WebUtils.getCurrUserName(request);
        itemBody.setCreateOperator(currentName);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<ItemBody> httpEntity = new HttpEntity<ItemBody>(itemBody, headers);
        try {
            ResponseEntity<AppResult> responseEntity = restTemplate.postForEntity(webPathConfiguration.getSystemUrl()+"/itemManage/addItem", httpEntity, AppResult.class);
            result.setCode(responseEntity.getBody().getStatus().getCode());
            result.setMsg(responseEntity.getBody().getStatus().getMessage());
            result.setEntity(responseEntity.getBody().getBody().toString());
        } catch (RestClientException e) {
            result.setCode("500");
        }
        return result;
    }

    /**
     * 上架商品，需要校验商品的必填信息项
     * @param id
     * @param
     * @return
     */
    @RequestMapping("/shelvesItem/{id}/{state}")
    @ResponseBody
    public WebResult<String> shelvesItem(@PathVariable Long id,
                                         @PathVariable Byte state,
                                         HttpServletRequest request){

        WebResult<String> result = new WebResult<String>();

        //获取当前登陆后台用户
        String currentName = WebUtils.getCurrUserName(request);

        try {
            AppResult appResult = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"" +
                    "/itemManage/shelvesItem?itemId={1}&state={2}&currentName={3}",AppResult.class,id,state,currentName);
            result.setCode(appResult.getStatus().getCode());
            result.setMsg(appResult.getStatus().getMessage());
        }catch (RestClientException e) {
            result.setCode("500");
        }
        return result;
    }



    /**
     * 商品下架
     * @param id
     * @param state
     * @return
     */
    @RequestMapping("/offshelfItem/{id}/{state}")
    @ResponseBody
    public  WebResult<String> offshelfItem(@PathVariable Long id,
                                           @PathVariable Byte state,
                                           HttpServletRequest request){
        WebResult<String> result = new WebResult<String>();

        //获取当前登陆后台用户
        String currentName = WebUtils.getCurrUserName(request);

        try {
            ResponseEntity<AppResult> responseEntity = restTemplate.getForEntity(webPathConfiguration.getSystemUrl()+"" +
                    "/itemManage/offshelfItem?itemId={1}&state={2}&currentName={3}",AppResult.class,id,state,currentName);
            result.setCode(responseEntity.getBody().getStatus().getCode());
            result.setMsg(responseEntity.getBody().getStatus().getMessage());
        } catch (RestClientException e) {
            result.setCode("500");
        }
        return result;
    }














}
