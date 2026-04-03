package com.sportpj.sportpj.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.http.client.HttpRedirects;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sportpj.sportpj.Model.UserClient;
import com.sportpj.sportpj.Service.ProfileService;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



@Controller
@RequestMapping("/admin")
public class ProfileController {
  @Autowired
  ProfileService profileService;

  @InitBinder
  public void initBinder(WebDataBinder binder){
    binder.setDisallowedFields("avatar");
  }
    @GetMapping("/profile")
  public String getProfilePage(HttpServletRequest request,Model model) {
    UserClient UserClient = profileService.getCurrentUser(request);
    model.addAttribute("profile",UserClient);
    return "profile";
  }
  @PostMapping("/profile/edit")
  public String postMethodName(Model model, @ModelAttribute UserClient UserClient,HttpServletRequest request, MultipartFile avatarFile,RedirectAttributes redirect) {
      UserClient = profileService.updateProfile(UserClient, request, avatarFile);
      redirect.addFlashAttribute("success", "Sửa thành công");
      return "redirect:/admin/profile";
  }
  
}
