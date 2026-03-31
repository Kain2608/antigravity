package com.sportpj.sportpj.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/admin")
public class RoleController {
  @GetMapping("/role/list")
  public String getRolePage() {
      return "roleList";
  }
  @GetMapping("/role/create")
  public String getCreate() {
      return "roleCreate";
  }
  
}
