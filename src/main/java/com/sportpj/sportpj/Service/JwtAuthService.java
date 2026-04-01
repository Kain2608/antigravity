package com.sportpj.sportpj.Service;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
@Service
public class JwtAuthService {
    private final String SECRET = "SportPjSecretKey2026!@#DayLaChuoiBaoMatCucManh";
    private final Key key = Keys.hmacShaKeyFor(SECRET.getBytes());

    private long expire = 1000 * 60 * 60 * 24; // 1 day

    // CREATE TOKEN
    public String generateToken(String email, long userId, List<String> permissions) {
        return Jwts.builder()
                .claim("email", email)
                .claim("userId", userId)
                .claim("permissions", permissions)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + expire))
                .signWith(key)
                .compact();
    }

    // VERIFY TOKEN
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
            data.put("permissions", claims.get("permissions", List.class));

            return data;

        } catch (JwtException e) {
            return null;
        }
    }

    // SET COOKIE
    public void addTokenCookie(HttpServletResponse response, String token) {
        Cookie cookie = new Cookie("token", token);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge((int) (expire / 1000));
        response.addCookie(cookie);
    }
}