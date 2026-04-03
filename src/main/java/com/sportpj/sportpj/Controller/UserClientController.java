package com.sportpj.sportpj.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

import com.sportpj.sportpj.Model.UserClient;
import com.sportpj.sportpj.Service.UserService;

@Controller
public class UserClientController {

    @Autowired
    private UserService userService;

    // ----------------------------------------
    // REGISTER FLOW
    // ----------------------------------------
    @GetMapping("/register")
    public String getClientRegisterPage() {
        return "client/register"; 
    }

    @PostMapping("/register")
    public String registerClient(
            @ModelAttribute UserClient UserClient,
            @RequestParam(required = false) Boolean agree,
            RedirectAttributes redirect) {

        if (agree == null || !agree) {
            redirect.addFlashAttribute("error", "Vui lòng đồng ý với các điều khoản.");
            return "redirect:/register";
        }

        // Direct pass to Repository -> Service without middle DTO mapping 
        if (!userService.register(UserClient)) {
            redirect.addFlashAttribute("error", "Email này đã được sử dụng!");
            return "redirect:/register";
        }

        redirect.addFlashAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
        return "redirect:/login";
    }

    // ----------------------------------------
    // LOGIN FLOW
    // ----------------------------------------
    @GetMapping("/login")
    public String getClientLoginPage() {
        return "client/login"; 
    }

    @PostMapping("/login")
    public String loginClient(
            @ModelAttribute UserClient userLoginModel,
            RedirectAttributes redirect,
            HttpSession session) {

        // Validate directly from entity bounds 
        if (!userService.checkLogin(userLoginModel.getEmail(), userLoginModel.getPassword())) {
            redirect.addFlashAttribute("error", "Email hoặc mật khẩu không chính xác.");
            return "redirect:/login";
        }

        // Retrieve full user profile
        UserClient user = userService.findByEmail(userLoginModel.getEmail());

        // Store user cleanly in Server Session
        session.setAttribute("clientUser", user);

        // Redirect to main client index after login
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logoutClient(HttpSession session) {
        session.removeAttribute("clientUser");
        session.invalidate();
        return "redirect:/login";
    }
}
