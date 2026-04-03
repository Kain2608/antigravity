package com.sportpj.sportpj.Service;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.sportpj.sportpj.Model.ShoesModel;
import com.sportpj.sportpj.Model.UserClient;
import com.sportpj.sportpj.Repository.ShoesRepository;
import com.sportpj.sportpj.Repository.UserRepository;
import com.sportpj.sportpj.helpers.JwtHelper;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class ShoesService {

    @Autowired
    private ShoesRepository shoesRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private Cloudinary cloudinary;
    @Autowired
    JwtHelper jwtHelper;
    public UserClient getCurrentUser(HttpServletRequest request){
        String email = jwtHelper.getEmail(request);
        if(email != null){
            return userRepository.findByEmail(email);
        }
        return null;
    }

    public String priceFormatter(ShoesModel shoes){
      Locale localeVN = new Locale("vi", "VN");
      NumberFormat priceFormat = NumberFormat.getCurrencyInstance(localeVN);
      String priceF = priceFormat.format(shoes.getPrice());
      return priceF;
    }

    public ShoesModel saveShoes(ShoesModel shoes, MultipartFile avatarFile,HttpServletRequest request) {
      if (avatarFile != null && !avatarFile.isEmpty()) {
          try {
              Map uploadResult = cloudinary.uploader().upload(
                      avatarFile.getBytes(),
                      ObjectUtils.asMap("folder", "shoes")
              );
              String url = uploadResult.get("secure_url").toString();
              shoes.setAvatar(url);
          } catch (IOException e) {
              e.printStackTrace();
          }
      }
      if(shoes.getStatus() == null || shoes.getStatus().isBlank()){
          shoes.setStatus("active");
      }
      UserClient user = getCurrentUser(request);
      if(user != null){
          shoes.setCreatedBy(user.getFullName());
          shoes.setUpdatedBy(user.getFullName());
      }
      
      return shoesRepository.save(shoes);
    }
}
