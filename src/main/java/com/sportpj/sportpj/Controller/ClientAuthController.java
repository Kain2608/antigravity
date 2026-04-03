package com.sportpj.sportpj.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sportpj.sportpj.Model.UserModel;
import com.sportpj.sportpj.Model.dto.LoginRequest;
import com.sportpj.sportpj.Model.dto.RegisterRequest;
import com.sportpj.sportpj.Service.JwtAuthService;
import com.sportpj.sportpj.Service.UserService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ClientAuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtAuthService jwtAuthService;

    // ----------------------------------------
    // REGISTER FLOW
    // ----------------------------------------
    @GetMapping("/register")
    public String getClientRegisterPage() {
        return "client/register"; // Automatically resolves to /WEB-INF/views/client/register.jsp
    }

    @PostMapping("/register")
    public String registerClient(
            @ModelAttribute RegisterRequest request,
            RedirectAttributes redirect) {

        if (request.getAgree() == null || !request.getAgree()) {
            redirect.addFlashAttribute("error", "Vui lòng đồng ý với các điều khoản.");
            return "redirect:/register";
        }

        // Map DTO to Model
        UserModel userModel = new UserModel();
        userModel.setFullName(request.getFullName());
        userModel.setEmail(request.getEmail());
        userModel.setPassword(request.getPassword());

        if (!userService.register(userModel)) {
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
        return "client/login"; // Automatically resolves to /WEB-INF/views/client/login.jsp
    }

    @PostMapping("/login")
    public String loginClient(
            @ModelAttribute LoginRequest request,
            RedirectAttributes redirect,
            HttpServletResponse response) {

        if (!userService.checkLogin(request.getEmail(), request.getPassword())) {
            redirect.addFlashAttribute("error", "Email hoặc mật khẩu không chính xác.");
            return "redirect:/login";
        }

        UserModel user = userService.findByEmail(request.getEmail());
        List<String> permissions = userService.getPermissions(user.getId());

        // Reusing the existing JWT structure ensures maximum compatibility
        String token = jwtAuthService.generateToken(
                user.getEmail(),
                user.getId(),
                permissions);

        jwtAuthService.addTokenCookie(response, token);

        // Redirect to main client index after login
        return "redirect:/";
    }
}
