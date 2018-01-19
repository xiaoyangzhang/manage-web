package com.yhyt.health.util;

import javax.servlet.http.HttpServletRequest;

public class WebUtils {

//    @Autowired
//    private SysUserService sysUserService;
//
    public static String getCurrUserName(HttpServletRequest request){
        String username= (String) request.getSession().getAttribute("username");
        return username;
    }

    public static Long getCurrUserId(HttpServletRequest request){
        Long userId= (Long) request.getSession().getAttribute("userId");
        return userId;
    }
}
