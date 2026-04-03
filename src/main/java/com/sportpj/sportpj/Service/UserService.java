package com.sportpj.sportpj.Service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sportpj.sportpj.Model.PermissionModel;
import com.sportpj.sportpj.Model.RoleModel;
import com.sportpj.sportpj.Model.UserClient;
import com.sportpj.sportpj.Repository.RoleRepository;
import com.sportpj.sportpj.Repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    public boolean emailExists(String email) {
        return userRepository.findByEmail(email) != null;
    }

    public UserClient findByEmail(String email){
        return userRepository.findByEmail(email);
    }

    public boolean register(UserClient UserClient){
        if(emailExists(UserClient.getEmail())) return false;

        UserClient.setPassword(hashPassword(UserClient.getPassword()));

        UserClient.setRole("user");
        UserClient.setStatus("active");

        userRepository.save(UserClient);
        return true;
    }

    public boolean checkLogin(String email, String rawPassword) {
        UserClient user = userRepository.findByEmail(email);
        if(user == null) return false;
        if(!"active".equals(user.getStatus())) return false;

        return user.getPassword().equals(hashPassword(rawPassword));
    }

    public List<String> getPermissions(Long userId) {
        UserClient user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        String roleName = user.getRole();

        RoleModel role = roleRepository.findByName(roleName);

        if (role == null || role.getPermission() == null) {
            return List.of();
        }

        return role.getPermission()
                .stream()
                .map(PermissionModel::getCode)
                .toList();
    }

    private static final String SALT = "SportPj@2026";

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            String salted = password + SALT;

            byte[] encoded = digest.digest(salted.getBytes(StandardCharsets.UTF_8));

            StringBuilder hexString = new StringBuilder();

            for (byte b : encoded) {
                String hex = Integer.toHexString(0xff & b);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}