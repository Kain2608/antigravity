package com.sportpj.sportpj.Service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.sportpj.sportpj.Model.UserClient;
import com.sportpj.sportpj.Repository.UserRepository;
import com.sportpj.sportpj.helpers.JwtHelper;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class ProfileService {
  @Autowired
  UserRepository userRepository;
  @Autowired
  JwtHelper jwtHelper;
  @Autowired
  private Cloudinary cloudinary;
  public UserClient getCurrentUser(HttpServletRequest request){
    String email = jwtHelper.getEmail(request);
      if(email != null){
        return userRepository.findByEmail(email);
      }
    return null;
  }
  public UserClient updateProfile(UserClient UserClient, HttpServletRequest request,MultipartFile avatarFile){
    UserClient old = getCurrentUser(request);
    old.setFullName(UserClient.getFullName());
    old.setPhone(UserClient.getPhone());
    old.setEmail(UserClient.getEmail());
    if (avatarFile != null && !avatarFile.isEmpty()) {
      try {
        Map uploadResult = cloudinary.uploader().upload(
            avatarFile.getBytes(),
            com.cloudinary.utils.ObjectUtils.asMap("folder", "users")
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
    return userRepository.save(old);
  }
}
