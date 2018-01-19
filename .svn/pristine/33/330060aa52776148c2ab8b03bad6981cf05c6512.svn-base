package com.yhyt.health.controller;

import com.alibaba.fastjson.JSON;
import com.yhyt.health.configuration.WebPathConfiguration;
import com.yhyt.health.model.DictDepartment;
import com.yhyt.health.model.DictDepartmentVO;
import com.yhyt.health.model.QuestionnaireDept;
import com.yhyt.health.model.QuestionnaireQuery;
import com.yhyt.health.model.dto.QuestionnaireDTO;
import com.yhyt.health.result.WebResult;
import com.yhyt.health.spring.AppResult;
import com.yhyt.health.util.Page;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.LinkedList;
import java.util.List;

@Controller
@RequestMapping("/questionnaire")
public class QuestionnaireController {

    private static Logger logger = LoggerFactory.getLogger(QuestionnaireController.class);

    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private WebPathConfiguration webPathConfiguration;
//    @Autowired
//    private FastFileStorageClient storageClient;
//    @Autowired
//    private DoctorConstant doctorConstant;
    @RequestMapping("/toQuestionnaireList")
    public String toQuestionnaireList(Model model){
        LinkedList list = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/levelOneDepts/query", LinkedList.class);
        logger.info("获取一级科室列表，list:{}",JSON.toJSONString(list));
        DictDepartment dictDepartment = new DictDepartment();
        dictDepartment.setParentCode(-2);
        dictDepartment.setParentName("全部科室");
        list.addFirst(dictDepartment);
        DictDepartment dictDepartment2 = new DictDepartment();
        dictDepartment2.setParentCode(0);
        dictDepartment2.setParentName("通用科室");
        list.add(1,dictDepartment2);
        DictDepartment dictDepartment3 = new DictDepartment();
        dictDepartment3.setParentCode(-1);
        dictDepartment3.setParentName("草稿箱");
        list.addLast(dictDepartment3);
        model.addAttribute("list",list);
        return "/doctor/questionnaire-list";
    }
    @RequestMapping("/query/list")
    @ResponseBody
    public WebResult<QuestionnaireDTO> queryQuestionnaireList(QuestionnaireQuery questionnaireQuery){
        WebResult<QuestionnaireDTO> result = new WebResult<>();
        try {
            Page forObject = restTemplate.getForObject(webPathConfiguration.getSystemUrl() + "/questionnaire/list?" +
                    "title={0}&levelOnedictDeptId={1}&levelTwodictDeptId={2}&pageIndex={pageIndex}&pageSize={pageSize}", Page.class,questionnaireQuery.getTitle(),
                    questionnaireQuery.getLevelOnedictDeptId(),questionnaireQuery.getLevelTwodictDeptId(),questionnaireQuery.getPageIndex(),questionnaireQuery.getPageSize());
            result.setList(forObject.getResult());
            result.setCount(forObject.getTotalRecord());
            logger.info("问卷列表，result:{}",JSON.toJSONString(result));
        } catch (RestClientException e) {
            result.setCode("500");
        }
        return result;
    }

    @RequestMapping("/toAddQuestionnaire")
    public String toAddQuestionnaire(){
       return  "/doctor/questionnaire-add";
    }
    @RequestMapping("/add")
    @ResponseBody
    public WebResult<String>  addQuestionnaire(@RequestBody QuestionnaireDTO questionnaireDTO){
        WebResult<String> result = new WebResult<>();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<QuestionnaireDTO> httpEntity = new HttpEntity<>(questionnaireDTO, headers);
        try {
            //返回主键 id
            ResponseEntity<Long> responseEntity = restTemplate.postForEntity(webPathConfiguration.getSystemUrl()+"/questionnaire/add", httpEntity, Long.class);
            result.setEntity(responseEntity.getBody().toString());
        } catch (Exception e) {
            result.setCode("500");
        }
        return  result;
    }


    @RequestMapping("/update/state/{id}/{state}")
    @ResponseBody
    public WebResult<String>  updateState(@PathVariable("id")Long id,@PathVariable("state")Byte state){
        WebResult<String> result = new WebResult<>();
        AppResult appResult=null;
        try {
             appResult= restTemplate.patchForObject(webPathConfiguration.getSystemUrl() + "/update/state/" + id + "/" + state, null, AppResult.class);
             if ("501".equals(appResult.getStatus().getCode())) {
                 result.setCode(appResult.getStatus().getCode());
                 result.setMsg(appResult.getMsg());
             }
        } catch (Exception e) {
            result.setCode("500");
        }
        return result;

    }

    @RequestMapping("/toEditQuestionnaire/{id}")
    public String toEditQuestionnaire(Model model,@PathVariable("id")Long id){
        QuestionnaireDTO forObject = restTemplate.getForObject(webPathConfiguration.getSystemUrl() + "/questionnaire/query/" + id, QuestionnaireDTO.class);
        model.addAttribute("questionnaire",forObject.getQuestionnaire());
        model.addAttribute("questionnaireItems",forObject.getQuestionnaireItems());
        model.addAttribute("questionnaireDepts", JSON.toJSONString(forObject.getQuestionnaireDeptDTOS()));
        model.addAttribute("questionnaireDiseases",JSON.toJSONString(forObject.getQuestionnaireDiseaseDTOs()));
        model.addAttribute("questionnaireId",id);
        return "/doctor/questionnaire-edit";
    }


    /*@RequestMapping("/query/{id}")
    @ResponseBody
    public String queryQuestionnaireById(@PathVariable("id")Long id){
        WebResult<QuestionnaireDTO> result = new WebResult<>();
        try {
            QuestionnaireDTO forObject = restTemplate.getForObject(webPathConfiguration.getSystemUrl() + "/questionnaire/query/" + id, QuestionnaireDTO.class);
            result.setEntity(forObject);
        } catch (RestClientException e) {
            result.setCode("500");
        }
        return  "/doctor/questionnaire-add";
    }*/
    @RequestMapping("/toQuestionnaire/dept/{questionnaireId}")
    public String toQuestionnaireDept(@PathVariable("questionnaireId")Long id,Model model){
        List deptCategories = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/dictDeptList/query", List.class);
        List questionnaireDepts = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"//questionnaire/dept/query/"+id, List.class);
        if (!CollectionUtils.isEmpty(questionnaireDepts)){
            for (Object o1:deptCategories){
                for (Object o2:questionnaireDepts){
                    DictDepartmentVO vo= (DictDepartmentVO) o1;
                    QuestionnaireDept qd= (QuestionnaireDept) o2;
                    if (vo.getId().equals(qd.getDictDepartmentId())){
                        vo.setSelected((byte)1);//页面选中标志
                    }
                }
            }
        }
        model.addAttribute("questionnaireId",id);
        model.addAttribute("deptCategories",deptCategories);
        return "/doctor/dept-category";
    }

    @RequestMapping("/toQuestionnaire/disease/{questionnaireId}")
    public String toQuestionnaireDisease(@PathVariable("questionnaireId")Long id,Model model){
        model.addAttribute("questionnaireId",id);
        return "/doctor/questionnaire-disease-list";
    }

    @RequestMapping("/preview/questionnaire/{questionnaireId}")
    public String previewQuestionnaire(@PathVariable("questionnaireId")Long id,Model model){
        QuestionnaireDTO forObject = restTemplate.getForObject(webPathConfiguration.getSystemUrl() + "/questionnaire/query/" + id, QuestionnaireDTO.class);
        /*StorePath storePath=null;
        try {
//                String path="/Users/localadmin/Desktop/";
            String path=webPathConfiguration.getQrCode();
            QrCode qrCode = new QrCode();
            qrCode.setType(0+"");
            qrCode.setId(forObject.getQuestionnaire().getId()+"");
            qrCode.setExtra(JSON.toJSONString(forObject));
            File file = new File(path + "department.jpeg");
            QrCodeCreateUtil.createQrCode(new FileOutputStream(
                    file), JSON.toJSONString(qrCode), 300, "JPEG");

            FileInputStream fis = new FileInputStream(file);
            storePath = storageClient.uploadFile(fis, file.length(), "JPEG", null);
        } catch (FileNotFoundException e) {
            logger.error("fail to upload department qrCode,error:{}",e);
//                result.setCode("500");
        }catch (Exception e) {
            logger.error("fail to generate department qrCode,error:{}",e);

        }*/
        model.addAttribute("questionnaire",forObject.getQuestionnaire());
        model.addAttribute("questionnaireItems",forObject.getQuestionnaireItems());
        model.addAttribute("questionnaireDepts", JSON.toJSONString(forObject.getQuestionnaireDeptDTOS()));
        model.addAttribute("questionnaireDiseases",JSON.toJSONString(forObject.getQuestionnaireDiseaseDTOs()));
        model.addAttribute("questionnaireId",id);
        return "/doctor/previewH5";
    }
}
