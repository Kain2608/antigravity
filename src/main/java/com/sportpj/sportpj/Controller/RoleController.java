package com.sportpj.sportpj.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sportpj.sportpj.Model.PermissionModel;
import com.sportpj.sportpj.Model.RoleModel;
import com.sportpj.sportpj.Repository.PermissionRepository;
import com.sportpj.sportpj.Repository.RoleRepository;
import com.sportpj.sportpj.Repository.UserRepository;
import com.sportpj.sportpj.Service.RoleService;
import com.sportpj.sportpj.annotation.RequirePermission; 

@Controller
@RequestMapping("/admin/setting")
public class RoleController {
    @Autowired
    RoleService roleService;
    @Autowired
    UserRepository userRepository;
    @Autowired
    PermissionRepository permissionRepository;
    @Autowired
    RoleRepository roleRepository;
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("permission");
    }

    // Yêu cầu quyền xem role
    @RequirePermission("ROLE_READ")
    @GetMapping("/role/list")
    public String getRolePage(Model model,RoleModel roleModel) {
        List<RoleModel> roleList = roleRepository.findAll();
        long count = roleRepository.count();
        Map<String, Long> countMap = new HashMap<>();
        for(RoleModel role : roleList){
            countMap.put(role.getName(),userRepository.countByRole(role.getName()));
        }
        model.addAttribute("count",count);
        model.addAttribute("roleList",roleList);
        model.addAttribute("countMap", countMap);
        return "roleList";
    }

    // Yêu cầu quyền thêm role
    @RequirePermission("ROLE_CREATE")
    @GetMapping("/role/create")
    public String getCreate(Model model) {
        List<PermissionModel> permissions = permissionRepository.findAll();
        List<RoleModel> roleList = roleRepository.findAll();
        model.addAttribute("permissions",permissions);
        model.addAttribute("roleList",roleList);
        return "roleCreate";
    }

    // Yêu cầu quyền thêm role (khi submit form)
    @RequirePermission("ROLE_CREATE")
    @PostMapping("/role/create")
    public String createPost(@ModelAttribute RoleModel roleModel, RedirectAttributes redirect,@RequestParam(required = false) List<String> permission){
        try{
            roleService.createRole(roleModel, permission);
            redirect.addFlashAttribute("success","Tạo thành công");
            return "redirect:/admin/role/create";
        }
        catch(Exception e){
            redirect.addFlashAttribute("error","Loi");
            return "redirect:/admin/role/create";
        }
    }      
}