package com.yhyt.health.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
//@ConfigurationProperties(prefix = "url")
public class WebPathConfiguration {

    @Value("${url.doctorUrl}")
    private String doctorUrl;
    @Value("${url.systemUrl}")
    private String systemUrl;
    @Value("${url.gateWay}")
    private String gateWay;
    @Value("${url.patientUrl}")
    private String patientUrl;
    @Value("${url.newhealthUrl}")
    private String newhealthUrl;
    @Value("${url.qrCode}")
    private String qrCode;

    public String getQrCode() {
        return qrCode;
    }

    public String getNewhealthUrl() {
        return newhealthUrl;
    }

    public String getDoctorUrl() {
        return doctorUrl;
    }

    public String getSystemUrl() {
        return systemUrl;
    }

    public String getGateWay() {
        return gateWay;
    }

    public String getPatientUrl() {
        return patientUrl;
    }

    @Bean
    public WebPathConfiguration getPathConfiguration(){
        WebPathConfiguration webPathConfiguration = new WebPathConfiguration();
        webPathConfiguration.doctorUrl=doctorUrl;
        webPathConfiguration.gateWay=gateWay;
        webPathConfiguration.patientUrl=patientUrl;
        webPathConfiguration.qrCode=qrCode;
        webPathConfiguration.systemUrl=systemUrl;
        webPathConfiguration.newhealthUrl=newhealthUrl;
        return webPathConfiguration;
    }
}
