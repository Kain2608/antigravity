package com.sportpj.sportpj.Service;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
@Service
public class JwtAuthService {
    private final String SECRET = "SportPjSecretKey2026!@#DayLaChuoiBaoMatCucManh";
    
    private Key key = Keys.hmacShaKeyFor(SECRET.getBytes());
    private long expire = 1000 * 60 * 60*60; 

    public String generateToken(String email, long userId) {
        return Jwts.builder()
                .claim("email", email)
                .claim("userId", userId)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + expire))
                .signWith(key)
                .compact();
    }


    public Map<String, Object> validateToken(String token) {
        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
            Map<String, Object> data = new HashMap<>();
            data.put("email", claims.get("email", String.class));
            data.put("userId", claims.get("userId", Long.class));
            return data;
        } catch (JwtException e) {
            return null; 
        }
    }
  public void addTokenCookie(HttpServletResponse response, String token) {
    Cookie cookie = new Cookie("token", token);
    cookie.setHttpOnly(true); // JS không đọc được cookie
    cookie.setMaxAge((int) (expire / 1000)); // thời gian sống của cookie tinh bang s
    cookie.setPath("/"); 
    response.addCookie(cookie);
  }
}