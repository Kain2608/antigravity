package com.sportpj.sportpj.Repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sportpj.sportpj.Model.PermissionModel;

@Repository
public interface PermissionRepository extends JpaRepository<PermissionModel, Long>{
  List<PermissionModel> findByCodeIn(List<String> codes);
}
