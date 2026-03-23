package com.sportpj.sportpj.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sportpj.sportpj.Model.CategoryModel;
import com.sportpj.sportpj.Repository.CategoryRepository;
import com.sportpj.sportpj.Service.CategoryService;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
@RequestMapping("/admin/category")
public class CategoryController {
  @Autowired
  CategoryService categoryService;
  @Autowired
  CategoryRepository categoryRepository;
  @InitBinder
  public void initBinder(WebDataBinder binder){
    binder.setDisallowedFields("avatar");
  }
  @GetMapping("/list")
  public String getCategoryPage(Model model, CategoryModel categoryModel){
    List<CategoryModel> categoryList = categoryRepository.findByStatus("active");
    model.addAttribute("categoryList", categoryList);
    return "categoryList";
  }
  @GetMapping("/create")
  public String getCategoryCreatePage(){
    return "categoryCreate";
  }
  @PostMapping("/create")
  public String postMethodName(@ModelAttribute CategoryModel categoryModel,RedirectAttributes redirect, @RequestParam(name="avatar", required=false) MultipartFile avatarFile,HttpServletRequest request) {
    categoryService.saveCategory(categoryModel, avatarFile, request);
    redirect.addFlashAttribute("success", "Tạo mới thành công");
    return "redirect:/admin/category/create";
  }
  @GetMapping("/edit/{id}")
  public String getCategoryEditPage(@PathVariable("id") long id,Model model){
    CategoryModel categoryModel = categoryRepository.findById(id).orElseThrow();
    model.addAttribute("categoryDetail", categoryModel);
    return "categoryEdit";
  }
  @PostMapping("/edit/{id}")
  public String postEdit(@PathVariable("id") long id,@ModelAttribute CategoryModel categoryModel,RedirectAttributes redirect, @RequestParam(name="avatar", required=false) MultipartFile avatarFile,HttpServletRequest request) {
    categoryService.updateCategory(id, categoryModel, avatarFile, request);
    redirect.addFlashAttribute("success", "Chỉnh sửa thành công");
    return "redirect:/admin/category/edit/{id}";
  }
  @GetMapping("/delete/{id}")
  public String deleteCategory(@PathVariable("id") long id, RedirectAttributes redirect){
    categoryService.deleteCategory(id);
    redirect.addFlashAttribute("success", "Xóa thành công");
    return "redirect:/admin/category/list";
  }
}
