package com.sportpj.sportpj.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

import com.sportpj.sportpj.Model.UserModel;
import com.sportpj.sportpj.Model.dto.LoginRequest;
import com.sportpj.sportpj.Model.dto.RegisterRequest;
import com.sportpj.sportpj.Service.JwtAuthService;
import com.sportpj.sportpj.Service.UserService;

@RestController
@RequestMapping("/api/auth")
public class ApiAuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtAuthService jwtAuthService;

    @PostMapping("/register")
    public ResponseEntity<?> registerApi(@RequestBody RegisterRequest request) {
        if (request.getAgree() == null || !request.getAgree()) {
            Map<String, String> response = new HashMap<>();
            response.put("message", "Vui lòng đồng ý với các điều khoản.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }

        UserModel userModel = new UserModel();
        userModel.setFullName(request.getFullName());
        userModel.setEmail(request.getEmail());
        userModel.setPassword(request.getPassword());

        if (!userService.register(userModel)) {
            Map<String, String> response = new HashMap<>();
            response.put("message", "Email này đã được sử dụng!");
            return ResponseEntity.status(HttpStatus.CONFLICT).body(response);
        }

        Map<String, String> response = new HashMap<>();
        response.put("message", "Đăng ký thành công!");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginApi(@RequestBody LoginRequest request, HttpServletResponse responseHeader) {
        if (!userService.checkLogin(request.getEmail(), request.getPassword())) {
            Map<String, String> response = new HashMap<>();
            response.put("message", "Email hoặc mật khẩu không chính xác.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }

        UserModel user = userService.findByEmail(request.getEmail());
        List<String> permissions = userService.getPermissions(user.getId());

        String token = jwtAuthService.generateToken(
                user.getEmail(),
                user.getId(),
                permissions);

        // Inject the HTTP-Only cookie natively into the browser response
        jwtAuthService.addTokenCookie(responseHeader, token);

        Map<String, String> response = new HashMap<>();
        response.put("token", token);
        response.put("message", "Đăng nhập thành công");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/logout")
    public void logoutApi(HttpServletResponse response) throws java.io.IOException {
        // Destroy the HttpOnly token cookie natively
        Cookie cookie = new Cookie("token", null);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        
        // Redirect browser to home page
        response.sendRedirect("/");
    }
}
