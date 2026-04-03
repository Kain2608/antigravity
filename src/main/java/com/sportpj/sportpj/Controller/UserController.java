package com.sportpj.sportpj.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sportpj.sportpj.Model.UserClient;
import com.sportpj.sportpj.Service.JwtAuthService;
import com.sportpj.sportpj.Service.UserService;
import com.sportpj.sportpj.annotation.RequirePermission;
import com.sportpj.sportpj.annotation.RequirePermission;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class UserController {
    @Autowired
    UserService userService;
    
    @Autowired
    JwtAuthService jwtAuthService;
  
    @GetMapping("/admin/register")
    public String getRegisterPage() {
        return "register";
    }

    @PostMapping("/admin/register")
    public String register(@ModelAttribute UserClient user,
                           @RequestParam(required = false) Boolean agree,
                           RedirectAttributes redirect,
                           Model model) {

        if(agree == null || !agree) {
            redirect.addFlashAttribute("error", "Bạn phải đồng ý điều khoản");
            return "redirect:/admin/register";
        }

        if(!userService.register(user)) {
            redirect.addFlashAttribute("error", "Email đã tồn tại");
            return "redirect:/admin/register";
        }
        redirect.addFlashAttribute("success", "Bạn đã đăng ký tài khoản thành công");
        return "redirect:/admin/login";
    }

    @GetMapping("/admin/login")
    public String getLoginPage(Model model) {
        return "login";
    }
  
    @PostMapping("/admin/login")
    public String loginPost(
            RedirectAttributes redirect,
            @RequestParam String email,
            @RequestParam String password,
            HttpServletResponse response
    ) {

        if (!userService.checkLogin(email, password)) {
            redirect.addFlashAttribute("error", "Sai tài khoản hoặc mật khẩu");
            return "redirect:/admin/login";
        }

        UserClient user = userService.findByEmail(email);

        List<String> permissions = userService.getPermissions(user.getId());

        String token = jwtAuthService.generateToken(
                user.getEmail(),
                user.getId(),
                permissions
        );

        jwtAuthService.addTokenCookie(response, token);

        return "redirect:/admin/dashboard";
    }

    @RequirePermission("USER_READ")
    @GetMapping("/admin/dashboard")
    public String dashboard(HttpServletRequest request) {
        return "dashboard";
    }

    @GetMapping("/admin/logout")
    public String logout(HttpServletResponse response) {
        Cookie cookie = new Cookie("token", null);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(0); 
        response.addCookie(cookie);
        return "redirect:/admin/login";
    }
}