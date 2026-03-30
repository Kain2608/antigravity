package com.sportpj.sportpj.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sportpj.sportpj.Model.CategoryModel;


@Repository
public interface CategoryRepository extends JpaRepository<CategoryModel, Long>{
  List<CategoryModel> findByStatus(String status);
  List<CategoryModel> findByCreatedBy(String createdBy);
  List<CategoryModel> findByStatusAndCreatedBy(String status, String createdBy);
  boolean existsBySlug(String slug);
  long countByStatus(String status);
}
