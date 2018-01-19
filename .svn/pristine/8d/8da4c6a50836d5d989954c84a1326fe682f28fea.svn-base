package com.yhyt.health.controller;

import com.yhyt.health.configuration.WebPathConfiguration;
import com.yhyt.health.model.DictCity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/cityPage")
public class DictCityWebController {

	@Autowired
	private WebPathConfiguration webPathConfiguration;
	@Autowired
	private RestTemplate restTemplate;
	@RequestMapping("/city")
	public String dictCityList(DictCity dictCity){
		return "/city/dictCityList";
	}

	/**
	 * 获取省份
	 * @param dictCity
	 * @param model
	 * @return
	 */
	@RequestMapping("/province")
	public String dictProvinceList(DictCity dictCity, Model model){
		List provinces = restTemplate.getForObject(webPathConfiguration.getSystemUrl()+"/city/?level=1", List.class);
		model.addAttribute("provinces",provinces);
		return "/publish/cityList";
	}

	@RequestMapping("/toAddCity")
	public ModelAndView toAddCity(DictCity dictCity){
		ModelAndView model = new ModelAndView();
		model.addObject("dictCity", dictCity);
		model.setViewName("/city/cityForm");
		return model;
	}
}
