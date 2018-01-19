package com.yhyt.health.component;

import org.apache.shiro.authc.AuthenticationToken;

/**
 * Created by localadmin on 17/9/14.
 */
public class OAuth2Token implements AuthenticationToken {
    private String token;

    public OAuth2Token(String token){
        this.token = token;
    }

    @Override
    public String getPrincipal() {
        return token;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}
