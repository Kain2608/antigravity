package com.sportpj.sportpj.Controller;

import java.time.LocalDateTime;
import java.util.Random;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

import com.sportpj.sportpj.Model.UserClient;
import com.sportpj.sportpj.Model.VerificationCode;
import com.sportpj.sportpj.Repository.UserRepository;
import com.sportpj.sportpj.Repository.VerificationCodeRepository;
import com.sportpj.sportpj.Service.EmailService;
import com.sportpj.sportpj.Service.RateLimitingService;
import com.sportpj.sportpj.Service.UserService;

@Controller
public class UserClientController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private VerificationCodeRepository codeRepo;

    @Autowired
    private EmailService emailService;

    @Autowired
    private RateLimitingService rateLimitingService;

    private String generateOTP() {
        return String.format("%06d", new Random().nextInt(999999));
    }

    // ----------------------------------------
    // REGISTER FLOW
    // ----------------------------------------
    @GetMapping("/register")
    public String getClientRegisterPage() {
        return "client/register"; 
    }

    @PostMapping("/register")
    public String registerClient(
            @ModelAttribute UserClient userClient,
            @RequestParam(required = false) Boolean agree,
            RedirectAttributes redirect,
            HttpSession session) {

        if (agree == null || !agree) {
            redirect.addFlashAttribute("error", "Vui lòng đồng ý với các điều khoản.");
            return "redirect:/register";
        }

        if (userService.emailExists(userClient.getEmail())) {
            redirect.addFlashAttribute("error", "Email này đã được sử dụng!");
            return "redirect:/register";
        }

        if (!rateLimitingService.canRequestOtp(userClient.getEmail())) {
            redirect.addFlashAttribute("error", "Bạn đã yêu cầu mã quá nhiều lần. Vui lòng thử lại sau.");
            return "redirect:/register";
        }

        // Store user payload in session temporarily
        session.setAttribute("pendingUser", userClient);

        // Generate and save OTP
        String otp = generateOTP();

        boolean sent = emailService.sendEmail(userClient.getEmail(), "Mã xác nhận đăng ký", "Mã của bạn là: " + otp + "\nMã sẽ hết hạn trong 5 phút.");
        if (!sent) {
            redirect.addFlashAttribute("error", "Không thể gửi email. Vui lòng kiểm tra địa chỉ email hoặc cấu hình hộp thư.");
            return "redirect:/register";
        }

        VerificationCode code = new VerificationCode();
        code.setEmail(userClient.getEmail());
        code.setOtpCode(otp);
        code.setType("REGISTER");
        code.setExpiresAt(LocalDateTime.now().plusMinutes(5));
        codeRepo.save(code);

        rateLimitingService.recordOtpRequest(userClient.getEmail());

        return "redirect:/register-verify";
    }

    @GetMapping("/register-verify")
    public String getVerifyRegisterPage(HttpSession session, RedirectAttributes redirect) {
        if (session.getAttribute("pendingUser") == null) {
            return "redirect:/register";
        }
        return "client/verify-register";
    }

    @PostMapping("/register-verify")
    public String verifyRegister(
            @RequestParam("otp") String otp,
            HttpSession session,
            RedirectAttributes redirect) {
        
        UserClient pendingUser = (UserClient) session.getAttribute("pendingUser");
        if (pendingUser == null) {
            return "redirect:/register";
        }

        VerificationCode vc = codeRepo.findTopByEmailAndTypeOrderByCreatedAtDesc(pendingUser.getEmail(), "REGISTER");
        if (vc == null) {
            redirect.addFlashAttribute("error", "Không tìm thấy mã OTP.");
            return "redirect:/register-verify";
        }

        if (vc.isExpired()) {
            redirect.addFlashAttribute("error", "Mã OTP đã hết hạn.");
            return "redirect:/register-verify";
        }

        if (vc.getAttempts() >= 5) {
            redirect.addFlashAttribute("error", "Bạn đã nhập sai quá nhiều lần. Vui lòng đăng ký lại.");
            session.removeAttribute("pendingUser");
            return "redirect:/register";
        }

        if (!vc.getOtpCode().equals(otp)) {
            vc.incrementAttempts();
            codeRepo.save(vc);
            redirect.addFlashAttribute("error", "Mã OTP không chính xác.");
            return "redirect:/register-verify";
        }

        // OTP is correct! Register user
        if (!userService.register(pendingUser)) {
            redirect.addFlashAttribute("error", "Có lỗi xảy ra khi tạo tài khoản.");
            return "redirect:/register";
        }

        session.removeAttribute("pendingUser");
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

        if (!userService.checkLogin(userLoginModel.getEmail(), userLoginModel.getPassword())) {
            redirect.addFlashAttribute("error", "Email hoặc mật khẩu không chính xác.");
            return "redirect:/login";
        }

        UserClient user = userService.findByEmail(userLoginModel.getEmail());
        session.setAttribute("clientUser", user);
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logoutClient(HttpSession session) {
        session.removeAttribute("clientUser");
        session.invalidate();
        return "redirect:/";
    }

    // ----------------------------------------
    // FORGOT PASSWORD FLOW
    // ----------------------------------------
    @GetMapping("/forgot-password")
    public String getForgotPasswordPage() {
        return "client/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email, RedirectAttributes redirect, HttpSession session) {
        if (!userService.emailExists(email)) {
            redirect.addFlashAttribute("error", "Email không tồn tại trong hệ thống.");
            return "redirect:/forgot-password";
        }

        if (!rateLimitingService.canRequestOtp(email)) {
            redirect.addFlashAttribute("error", "Bạn đã yêu cầu quá nhiều lần. Vui lòng thử lại sau 1 giờ.");
            return "redirect:/forgot-password";
        }

        String otp = generateOTP();

        boolean sent = emailService.sendEmail(email, "Mã Khôi Phục Mật Khẩu", "Mã khôi phục của bạn là: " + otp + "\nMã sẽ hết hạn trong 5 phút.");
        if (!sent) {
            redirect.addFlashAttribute("error", "Lỗi: Hệ thống không thể gửi email tại thời điểm này.");
            return "redirect:/forgot-password";
        }

        VerificationCode code = new VerificationCode();
        code.setEmail(email);
        code.setOtpCode(otp);
        code.setType("RESET_PASSWORD");
        code.setExpiresAt(LocalDateTime.now().plusMinutes(5));
        codeRepo.save(code);

        rateLimitingService.recordOtpRequest(email);

        session.setAttribute("resetEmail", email);
        redirect.addFlashAttribute("success", "Mã xác nhận đã được gửi đến email của bạn.");
        return "redirect:/reset-password";
    }

    @GetMapping("/reset-password")
    public String getResetPasswordPage(HttpSession session, Model model) {
        if (session.getAttribute("resetEmail") == null) {
            return "redirect:/forgot-password";
        }
        return "client/reset-password";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(
            @RequestParam("otp") String otp,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpSession session,
            RedirectAttributes redirect) {

        String email = (String) session.getAttribute("resetEmail");
        if (email == null) {
            return "redirect:/forgot-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            redirect.addFlashAttribute("error", "Mật khẩu không khớp.");
            return "redirect:/reset-password";
        }

        UserClient user = userService.findByEmail(email);
        if (user == null) {
            redirect.addFlashAttribute("error", "Không tìm thấy dữ liệu người dùng.");
            return "redirect:/forgot-password";
        }
        
        if (BCrypt.checkpw(newPassword, user.getPassword())) {
            redirect.addFlashAttribute("error", "Mật khẩu mới phải khác với mật khẩu hiện tại.");
            return "redirect:/reset-password";
        }

        VerificationCode vc = codeRepo.findTopByEmailAndTypeOrderByCreatedAtDesc(email, "RESET_PASSWORD");
        if (vc == null || vc.isExpired()) {
            redirect.addFlashAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn.");
            return "redirect:/reset-password";
        }

        if (vc.getAttempts() >= 5) {
            redirect.addFlashAttribute("error", "Bạn sai quá 5 lần. Vui lòng yêu cầu mã lại.");
            session.removeAttribute("resetEmail");
            return "redirect:/forgot-password";
        }

        if (!vc.getOtpCode().equals(otp)) {
            vc.incrementAttempts();
            codeRepo.save(vc);
            redirect.addFlashAttribute("error", "Mã OTP không đúng.");
            return "redirect:/reset-password";
        }

        // SUCCESS -> Update password
        user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt(12)));
        userRepository.save(user);

        session.removeAttribute("resetEmail");
        redirect.addFlashAttribute("success", "Đổi mật khẩu thành công! Vui lòng đăng nhập.");
        return "redirect:/login";
    }
}
