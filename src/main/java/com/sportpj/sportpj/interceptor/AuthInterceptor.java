package com.sportpj.sportpj.interceptor;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import com.sportpj.sportpj.annotation.RequirePermission;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            RequirePermission requirePermission = handlerMethod.getMethodAnnotation(RequirePermission.class);

            if (requirePermission != null) {
                List<String> permissions = (List<String>) request.getAttribute("permissions");
                String required = requirePermission.value();

                if (permissions == null || !permissions.contains(required)) {
                    response.sendRedirect("/403");
                    return false;
                }
            }
        }
        return true;
    }
}