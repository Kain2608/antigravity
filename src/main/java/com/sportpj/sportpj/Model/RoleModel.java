package com.sportpj.sportpj.Model;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="role")
public class RoleModel {
  @Id
  @GeneratedValue(strategy= GenerationType.IDENTITY)
  private Long id;
  private String name;
  private String description;
  @ManyToMany
  @JoinTable(
    name="role_permission",
    joinColumns=@JoinColumn(name="role_id"),
    inverseJoinColumns=@JoinColumn(name="permission_id")
  )
  private List<PermissionModel> permission;
  public Long getId() {
    return id;
  }
  public void setId(Long id) {
    this.id = id;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getDescription() {
    return description;
  }
  public void setDescription(String description) {
    this.description = description;
  }
  public List<PermissionModel> getPermission() {
    return permission;
  }
  public void setPermission(List<PermissionModel> permission) {
    this.permission = permission;
  }
  
}
