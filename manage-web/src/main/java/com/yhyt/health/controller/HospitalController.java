package com.yhyt.health.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.yhyt.health.configuration.WebPathConfiguration;
import com.yhyt.health.constant.DictConstant;
import com.yhyt.health.model.Hospital;
import com.yhyt.health.model.query.HospitalQuery;
import com.yhyt.health.model.vo.HospitalVO;
import com.yhyt.health.result.WebResult;
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

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/hospital")
public class HospitalController {

    private static Logger logger = LoggerFactory.getLogger(HospitalController.class);

    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private WebPathConfiguration webPathConfiguration;

    @RequestMapping("/toHospitalList")
    public String toHospitalListPage(Model model) {
        List provinces = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/city/?level=1", List.class);
        model.addAttribute("provinces",provinces);
        return "/hospital/hospital-list";
    }

    @RequestMapping(value = "/hospitalList",method = RequestMethod.POST)
    @ResponseBody
    public WebResult<HospitalVO> getHospitalListPage( HospitalQuery hospitalQuery) {
        WebResult<HospitalVO> result = new WebResult<>();
        PageInfo pageInfo = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/hospitalList?queryStr={queryStr}", PageInfo.class, JSON.toJSONString(hospitalQuery));
        result.setCount(pageInfo.getTotal());
        result.setList(pageInfo.getList());
        return result;
    }

    @RequestMapping("/toAddHospital")
    public String toAddHospital(Model model) {
        //TODO 字典 code
        List hospitalLevels = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/dictionary/?dictCode="+ DictConstant.HOSPITAL_LEVEL, List.class);
        model.addAttribute("hospitalLevels",hospitalLevels);
        List hospitalCategories = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/dictionary/?dictCode="+DictConstant.HOSPITAL_CATEGORY, List.class);
        model.addAttribute("categories",hospitalCategories);
        List provinces = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/city/?level=1", List.class);
        model.addAttribute("provinces",provinces);
        return "/hospital/hospital-add";
    }
    @RequestMapping(value = "/addHospital",method = RequestMethod.POST)
    @ResponseBody
    public WebResult<String> addHospital(@RequestBody Hospital hospital, HttpServletRequest request) {
        WebResult<String> result = new WebResult<>();
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            hospital.setOperator(WebUtils.getCurrUserName(request));
            HttpEntity<Hospital> httpEntity = new HttpEntity<>(hospital, headers);
            ResponseEntity<Integer> responseEntity = restTemplate.postForEntity(webPathConfiguration.getDoctorUrl()+"/addHospital", httpEntity, Integer.class);
            return result;
        } catch (RestClientException e) {
            result.setCode("500");
        }
        return result;

    }

    @RequestMapping("/toEditHospital/{id}")
    public String toEditHospital(@PathVariable("id")long id, Model model) {
        model.addAttribute("id",id);
        return "/hospital/hospital-edit";
    }
    @RequestMapping("/hospital/get/{id}")
    public String getHospitalById(@PathVariable("id")long id,Model model){
        Hospital hospital = null;
        try {
            hospital = restTemplate.getForObject(webPathConfiguration.getDoctorUrl()+"/viewHospital/" + id, Hospital.class);
            model.addAttribute("hospital",hospital);
            List provinces = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/city/?level=1", List.class);
            model.addAttribute("provinces",provinces);
            List cities = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/city/?level=2&parentId="+hospital.getDictCityIdProvince(), List.class);
            model.addAttribute("cities",cities);
            //TODO 字典 code
            List hospitalLevels = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/dictionary/?dictCode="+ DictConstant.HOSPITAL_LEVEL, List.class);
            model.addAttribute("hospitalLevels",hospitalLevels);
            List hospitalCategories = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/dictionary/?dictCode="+ DictConstant.HOSPITAL_CATEGORY, List.class);
            model.addAttribute("categories",hospitalCategories);
        } catch (RestClientException e) {
//            result.setCode("500");
            logger.error("get hospital error,error:{}",e);
        }
        return "/hospital/hospital-edit";

//        return result;
    }
    @RequestMapping(value = "/editHospital",method = RequestMethod.POST)
    @ResponseBody
    public WebResult<String> editHospital(@RequestBody Hospital hospital) {
        WebResult<String> result = new WebResult<>();
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Hospital> httpEntity = new HttpEntity<>(hospital, headers);
            restTemplate.put(webPathConfiguration.getDoctorUrl()+"/updateHospital", httpEntity);
            return result;
        } catch (RestClientException e) {
            result.setCode("500");
        }
        return result;

    }
}
