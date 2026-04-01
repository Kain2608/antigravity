package com.sportpj.sportpj.config;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.sportpj.sportpj.Service.JwtAuthService;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtFilter extends OncePerRequestFilter {

    @Autowired
    private JwtAuthService jwtAuthService;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        String token = null;

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("token".equals(c.getName())) {
                    token = c.getValue();
                }
            }
        }

        if (token != null) {
            Map<String, Object> data = jwtAuthService.validateToken(token);

            if (data != null) {
                request.setAttribute("userId", data.get("userId"));
                request.setAttribute("email", data.get("email"));
                request.setAttribute("permissions", data.get("permissions"));
            }
        }

        filterChain.doFilter(request, response);
    }
}