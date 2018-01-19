package com.yhyt.health.controller;

import com.yhyt.health.configuration.WebPathConfiguration;
import com.yhyt.health.model.Item;
import com.yhyt.health.result.WebResult;
import com.yhyt.health.spring.AppResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

/**
 * Created by apple on 2017/12/28.
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private WebPathConfiguration webPathConfiguration;

    /*商品列表*/
    @RequestMapping("/toProductList")
    public String toProductList(){
        return "/product/product-list";
    }

    /*创建商品*/
    @RequestMapping("/addProduct")
    public String addContent(){
        return "/product/add-product";
    }

    /**
     * 科室下的服务包上下架
     * @param item
     * @return
     */
    @RequestMapping("/state/update")
    @ResponseBody
    public WebResult<String> updateItemState(@RequestBody Item item){
        WebResult<String> result = new WebResult<>();
        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Item> httpEntity = new HttpEntity<>(item, headers);
        try {
            AppResult appResult = restTemplate.patchForObject(webPathConfiguration.getSystemUrl() + "/itemManage/update/state", httpEntity, AppResult.class);
            if (appResult!=null && "501".equals(appResult.getStatus().getCode())){
                result.setCode("501");
                result.setMsg(appResult.getStatus().getMessage());
            }
        } catch (RestClientException e) {
            result.setCode("500");
        }

        return result;
    }
}
