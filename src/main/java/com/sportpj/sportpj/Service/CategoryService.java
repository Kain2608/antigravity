package com.sportpj.sportpj.Service;

import java.text.Normalizer;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.sportpj.sportpj.Model.CategoryModel;
import com.sportpj.sportpj.Model.UserClient;
import com.sportpj.sportpj.Repository.CategoryRepository;
import com.sportpj.sportpj.Repository.UserRepository;
import com.sportpj.sportpj.helpers.JwtHelper;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class CategoryService {
  @Autowired
  CategoryRepository categoryRepository;
  @Autowired
  private Cloudinary cloudinary;
  @Autowired
  JwtHelper jwtHelper;
  @Autowired
  UserRepository userRepository;
  public String toSlug(String input) {
    String slug = Normalizer.normalize(input, Normalizer.Form.NFD);
    slug = slug.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
    slug = slug.toLowerCase();
    slug = slug.replaceAll("[^a-z0-9\\s-]", "");
    slug = slug.trim().replaceAll("\\s+", "-");
    return slug;
}
  public UserClient getCurrentUser(HttpServletRequest request){
    String email = jwtHelper.getEmail(request);
    if(email != null){
      return userRepository.findByEmail(email);
    }
    return null;
  }
  public CategoryModel saveCategory(CategoryModel categoryModel, MultipartFile avatarFile,HttpServletRequest request){
    if (avatarFile != null && !avatarFile.isEmpty()) {
      try {
        Map uploadResult = cloudinary.uploader().upload(
            avatarFile.getBytes(),
            com.cloudinary.utils.ObjectUtils.asMap("folder", "category")
        );

        String url = uploadResult.get("secure_url").toString();
        categoryModel.setAvatar(url);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    categoryModel.setStatus("active");
    String slug = toSlug(categoryModel.getName());
    int i = 1;
    while(categoryRepository.existsBySlug(slug)){
        slug = toSlug(categoryModel.getName()) + "-" + i;
        i++;
    }
    categoryModel.setSlug(slug);
    UserClient user = getCurrentUser(request);
    
    if(user != null){
      categoryModel.setCreatedBy(user.getFullName());
      categoryModel.setUpdatedBy(user.getFullName()); 
    }
    
    return categoryRepository.save(categoryModel);
    }

    public CategoryModel updateCategory(@PathVariable("id") long id,CategoryModel categoryModel, MultipartFile avatarFile, HttpServletRequest request){
      CategoryModel old = categoryRepository.findById(id).orElseThrow();
      old.setName(categoryModel.getName());
      old.setStatus(categoryModel.getStatus());
      old.setDescription(categoryModel.getDescription());
      if (avatarFile != null && !avatarFile.isEmpty()) {
        try {
          Map uploadResult = cloudinary.uploader().upload(
              avatarFile.getBytes(),
              com.cloudinary.utils.ObjectUtils.asMap("folder", "category")
          );

          String url = uploadResult.get("secure_url").toString();
          old.setAvatar(url);
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
      UserClient user = getCurrentUser(request);
      if(user != null){
        old.setUpdatedBy(user.getFullName()); 
      }
      String slug = toSlug(categoryModel.getName());
      int i = 1;
      while(categoryRepository.existsBySlug(slug) && !old.getSlug().equals(slug)){
          slug = toSlug(categoryModel.getName()) + "-" + i;
          i++;
      }
      old.setSlug(slug);
      return categoryRepository.save(old);
    }

    public void deleteCategory(@PathVariable("id") long id){
      categoryRepository.deleteById(id);
    }
}


