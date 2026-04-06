package com.sportpj.sportpj.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sportpj.sportpj.interceptor.AuthInterceptor;

import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.mvc.WebContentInterceptor;
import org.springframework.http.CacheControl;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private AuthInterceptor authInterceptor;

    @Bean
    public WebContentInterceptor webContentInterceptor() {
        WebContentInterceptor interceptor = new WebContentInterceptor();
        interceptor.setCacheControl(CacheControl.noStore().mustRevalidate());
        return interceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor).addPathPatterns("/**");
        
        // Prevent browser caching on dynamic endpoints to protect session on logout Back-Button
        registry.addInterceptor(webContentInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/css/**", "/js/**", "/images/**", "/static/**", "/webjars/**");
    }
}