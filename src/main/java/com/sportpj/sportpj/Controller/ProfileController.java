package com.sportpj.sportpj.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/admin")
public class ProfileController {
  @GetMapping("/profile")
  public String getProfilePage() {
      return "profile";
  }

}
