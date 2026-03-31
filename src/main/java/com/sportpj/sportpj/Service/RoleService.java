// package com.sportpj.sportpj.Service;


// import java.util.List;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Service;

// import com.sportpj.sportpj.Model.PermissionModel;
// import com.sportpj.sportpj.Model.RoleModel;
// import com.sportpj.sportpj.Repository.PermissionRepository;
// import com.sportpj.sportpj.Repository.RoleRepository;

// @Service
// public class RoleService {
//   @Autowired
//   RoleRepository roleRepository;
//   @Autowired
//   PermissionRepository permissionRepository;
//   public void createRole(RoleModel roleModel,List<String> codes){
//     if(codes != null && !codes.isEmpty()){
//       List<PermissionModel> permiss = permissionRepository.findByCodeIn(codes);
//       roleModel.setPermission(permiss);
//     }
//     roleRepository.save(roleModel);
//   }
// }
