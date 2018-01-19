package com.yhyt.health.config;


import com.alibaba.druid.pool.DruidDataSource;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
//@ConfigurationProperties(prefix = "spring.datasource")
public class DataBaseConfiguration {


//    @Value("${spring.datasource.driver-class-name}")
//    private String driverClassName;
//    @Value("${spring.datasource.username}")
//    private String username;
//    @Value("${spring.datasource.password}")
//    private String password;
//    @Value("${spring.datasource.url}")
//    private String url;


    @Bean
//    @Primary
//    @Qualifier
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource getDataSource() {
//        DruidDataSource dataSource = new DruidDataSource();
//        dataSource.setDriverClassName(driverClassName);
//        dataSource.setUsername(username);
//        dataSource.setPassword(password);
//        dataSource.setUrl(url);
        return new DruidDataSource();
    }
//
//    @Bean
//    @Primary
//    @Qualifier
//    public SqlSessionFactory sqlSessionFactoryBean() throws Exception {
//        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
//        sqlSessionFactoryBean.setDataSource(getDataSource());
////        sqlSessionFactoryBean.setTypeAliasesPackage("com.yhyt.health.mapper");
////        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
////        sqlSessionFactoryBean.setMapperLocations(resolver.getResources("classpath:/mapper/*.xml"));
//
//        return sqlSessionFactoryBean.getObject();
//    }
}
