package com.sportpj.sportpj.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sportpj.sportpj.Model.RoleModel;
@Repository
public interface  RoleRepository extends JpaRepository<RoleModel, Long>{
 
}
