package com.yhyt.health.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.yhyt.health.configuration.WebPathConfiguration;
import com.yhyt.health.model.Article;
import com.yhyt.health.model.ArticleDTO;
import com.yhyt.health.model.ArticleLogDTO;
import com.yhyt.health.model.query.ArticleQuery;
import com.yhyt.health.model.vo.ArticleVO;
import com.yhyt.health.result.WebResult;
import com.yhyt.health.spring.AppResult;
import com.yhyt.health.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.List;

/**
 * Created by apple on 2017/12/4.
 */
@Controller
@RequestMapping("/publish")
public class PublishController {

    private static Logger logger = LoggerFactory.getLogger(PublishController.class);

    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private WebPathConfiguration webPathConfiguration;
    /*@RequestMapping("/toAddArticle")
    public String toAddArticle(){
        return "/publish/addContent";
    }*/

    /**
     *
     * @param id
     * @param type
     * @param action 1：查看 2：编辑 3：审核
     * @param model
     * @return
     */
    @RequestMapping("/toEditArticle/{id}/{action}")
    public String toEditArticle(@PathVariable("id")Long id, @PathVariable("action")String action, Model model){
        ArticleDTO forObject = restTemplate.getForObject(webPathConfiguration.getDoctorUrl() + "/article/get/" + id+"/"+action, ArticleDTO.class);
        model.addAttribute("article",forObject.getArticle());
        if (!CollectionUtils.isEmpty(forObject.getArticleDepartmentDTOS())){

            model.addAttribute("articleDepts",JSON.toJSONString(forObject.getArticleDepartmentDTOS()));
        }else
            model.addAttribute("articleDepts",JSON.toJSONString(Collections.emptyList()));

        if (!CollectionUtils.isEmpty(forObject.getArticleAreaDTOS())){

            model.addAttribute("articleAreas",JSON.toJSONString(forObject.getArticleAreaDTOS()));
        }else
            model.addAttribute("articleAreas",JSON.toJSONString(Collections.emptyList()));

        model.addAttribute("articleLogs",forObject.getArticleLogDTOS());
        model.addAttribute("id",id);
//        model.addAttribute("type",type);
        model.addAttribute("action",action);
        return "/publish/editContent";
    }

    /*@RequestMapping("/toList/{type}")
    public String toList(@PathVariable("type")Byte type,Model model){
        if (1==type) return "/publish/physician-list";
        else if (2==type) return "/publish/topic-list";
        return "";
    }*/

    @RequestMapping("/article/list")
    @ResponseBody
    public WebResult<ArticleVO> queryArticleListPage(ArticleQuery articleQuery){
        WebResult<ArticleVO> result = new WebResult<>();
        try {
            PageInfo pageInfo = restTemplate.getForObject(webPathConfiguration.getDoctorUrl() + "/article/list?quertStr={quertStr}", PageInfo.class, JSON.toJSONString(articleQuery));
            result.setList(pageInfo.getList());
            result.setCount(pageInfo.getTotal());
            logger.info("article list,result:{}",JSON.toJSONString(result));
        } catch (RestClientException e) {
            logger.error("get article list page error,error:{}",e);
            result.setCode("500");
        }
        return result;
    }

    @RequestMapping("/add/article")
    @ResponseBody
    public WebResult<String> addArticle(@RequestBody ArticleDTO articleDTO, HttpServletRequest request){
        WebResult<String> result = new WebResult<>();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        articleDTO.setOperator(WebUtils.getCurrUserName(request));
        HttpEntity<ArticleDTO> httpEntity = new HttpEntity<>(articleDTO, headers);
        try {
            restTemplate.postForEntity(webPathConfiguration.getDoctorUrl()+"/article/add",httpEntity,Integer.class);
        } catch (RestClientException e) {
            logger.error("add article error,error:{}",e);
            result.setCode("500");
        }
        return result;
    }

    @RequestMapping("/edit/article")
    @ResponseBody
    public WebResult<String> editArticle(@RequestBody ArticleDTO articleDTO,HttpServletRequest request,Model model){
        WebResult<String> result = new WebResult<>();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        articleDTO.setOperator(WebUtils.getCurrUserName(request));
        HttpEntity<ArticleDTO> httpEntity = new HttpEntity<>(articleDTO, headers);
        try {
            ResponseEntity<AppResult> responseEntity = restTemplate.postForEntity(webPathConfiguration.getDoctorUrl() + "/article/edit", httpEntity, AppResult.class);
            if (responseEntity!=null && "501".equals(responseEntity.getBody().getStatus().getCode())){
                result.setCode("501");
                result.setMsg(responseEntity.getBody().getMsg());
            }
        } catch (RestClientException e) {
            logger.error("edit article error,error:{}",e);
            result.setCode("500");
        }
        return result;
    }

    @RequestMapping("/update/article/state")
    @ResponseBody
    public WebResult<String> updateArticleState(@RequestBody ArticleLogDTO articleLogDTO,HttpServletRequest request){
        WebResult<String> result = new WebResult<>();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        articleLogDTO.setOperator(WebUtils.getCurrUserName(request));
        HttpEntity<ArticleLogDTO> httpEntity = new HttpEntity<>(articleLogDTO, headers);
        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        try {
            AppResult appResult = restTemplate.patchForObject(webPathConfiguration.getDoctorUrl() + "/article/state/update", httpEntity, AppResult.class);
            if (appResult!=null && "501".equals(appResult.getStatus().getCode())){
                result.setCode("501");
                result.setMsg(appResult.getMsg());
            }
        } catch (RestClientException e) {
            logger.error("update article  state error,error:{}",e);
            result.setCode("500");
        }
        return result;
    }
    /*创建新内容*/
    @RequestMapping("/addContent")
    public String addContent(){
        return "/publish/addContent";
    }

    @RequestMapping("/toArticle/dept")
    public String toQuestionnaireDept(Model model){
        List deptCategories = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/dictDeptList/query", List.class);
        /*List questionnaireDepts = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"//questionnaire/dept/query/"+id, List.class);
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
        }*/
        model.addAttribute("deptCategories",deptCategories);
        return "/publish/dept-category";
    }
    /*医师培训*/
    @RequestMapping("/toPhysicianList")
    public String toPhysicianList(){
        return "/publish/physician-list";
    }

    /*参与课题*/
    @RequestMapping("/toTopicList")
    public String toTopicList(){
        return "/publish/topic-list";
    }

    //获取科室
    /*@RequestMapping("/toQuestionnaire/dept/{questionnaireId}")
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
        return "/publish/dept-category";
    }*/

    /***
     * 预览
     * @param id
     * @return
     */
    @RequestMapping("/detail/{id}")
    @ResponseBody
    public WebResult<Article> getArticleDetail(@PathVariable("id")Long id){
        WebResult<Article> result = new WebResult<>();
        try {
            Article article = restTemplate.getForObject(webPathConfiguration.getDoctorUrl() + "/article/detail/"+id, Article.class);
            if (article!=null){
                result.setEntity(article);
            }
        } catch (RestClientException e) {
            logger.error("get article detail error,error:{}",e);
            result.setCode("500");
        }

        return result;
    }
}
