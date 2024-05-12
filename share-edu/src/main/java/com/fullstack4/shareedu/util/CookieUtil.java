package com.fullstack4.shareedu.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {

    public static void setCookies(String name, String value, int expire, HttpServletResponse response) {
        Cookie cookie = new Cookie(name, value);

        cookie.setPath("/");
        cookie.setMaxAge(expire);

        response.addCookie(cookie);
    }

    public static String getCookieValue(String name, HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        String value = "";

        if(cookies != null) {
            for(Cookie c : cookies) {
                if(c.getName().equals(name)) {
                    value = c.getValue();
                    break;
                }
            }
        }

        return value;
    }

    public static void deleteCookie(String name, String value, int expire, HttpServletResponse response) {
        setCookies(name, value, 0, response);
    }
}
