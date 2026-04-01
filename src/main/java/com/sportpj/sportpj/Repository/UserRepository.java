package com.sportpj.sportpj.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sportpj.sportpj.Model.UserModel;



@Repository
public interface  UserRepository extends JpaRepository<UserModel, Long>{
  UserModel findByEmail(String email);
  long countByRole(String roleName);
}
