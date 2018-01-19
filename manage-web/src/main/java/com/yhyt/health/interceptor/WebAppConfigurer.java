package com.yhyt.health.interceptor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
//@EnableWebMvc
public class WebAppConfigurer extends WebMvcConfigurerAdapter {

    @Bean
    public ResponseInterceptor responseInterceptor(){
        return new ResponseInterceptor();
    }
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(responseInterceptor()).addPathPatterns("/**");//.excludePathPatterns("/system/**");/*addPathPatterns("/doctor/**")*/
//                .addPathPatterns("/department/");
//        registry.addInterceptor(systemServiceInterceptor()).addPathPatterns("/system/**");
        super.addInterceptors(registry);
    }
}
