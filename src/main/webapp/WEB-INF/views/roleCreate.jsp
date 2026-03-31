```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Thêm vai trò</title>
  <%@ include file="/WEB-INF/views/layout/default.jsp" %>
  <link rel="stylesheet" href="assets/css/role.css">
</head>

<body>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/sider.jsp" %>

<div class="sider-overlay"></div>
<main class="main">
  <nav class="breadcrumb">
    <a href="/admin/dashboard"><i class="fa-solid fa-house"></i></a>
    <span class="sep"><i class="fa-solid fa-chevron-right"></i></span>
    <a href="/admin/role/list">Vai trò</a>
    <span class="sep"><i class="fa-solid fa-chevron-right"></i></span>
    <span class="current">Thêm vai trò</span>
  </nav>
  <div class="rcard" style="max-width: 600px; margin: 0 auto;">

    <div class="rcard-header">
      <div class="rcard-header-icon">
        <i class="fa-solid fa-shield-halved"></i>
      </div>
      <h3 class="rcard-header-title">Thêm vai trò mới</h3>
    </div>
    <form action="/admin/role/create" method="post">
      <div class="rcard-body">
        <div class="field-group">
          <label class="field-label">Tên vai trò *</label>
          <div class="field-icon-wrap">
            <i class="fa-solid fa-shield-halved field-icon"></i>
            <input class="field-control" type="text"
                   name="name"
                   placeholder="VD: Admin, Editor..." required>
          </div>
        </div>
        <div class="field-group" style="margin-top: 16px;">
          <label class="field-label">Mô tả</label>
          <textarea class="field-control"
                    name="description"
                    placeholder="Mô tả vai trò..."
                    style="height:100px;"></textarea>
        </div>
        <div style="margin-top: 24px;">
          <h4 style="margin-bottom: 10px;">Phân quyền</h4>
          <div class="perm-module">
            <b>Quản lý User</b><br>
            <label><input type="checkbox" name="permissions" value="USER_VIEW"> Xem</label>
            <label><input type="checkbox" name="permissions" value="USER_CREATE"> Thêm</label>
            <label><input type="checkbox" name="permissions" value="USER_UPDATE"> Sửa</label>
            <label><input type="checkbox" name="permissions" value="USER_DELETE"> Xoá</label>
          </div>
          <div class="perm-module" style="margin-top: 10px;">
            <b>Quản lý Product</b><br>
            <label><input type="checkbox" name="permissions" value="PRODUCT_VIEW"> Xem</label>
            <label><input type="checkbox" name="permissions" value="PRODUCT_CREATE"> Thêm</label>
            <label><input type="checkbox" name="permissions" value="PRODUCT_UPDATE"> Sửa</label>
            <label><input type="checkbox" name="permissions" value="PRODUCT_DELETE"> Xoá</label>
          </div>

        </div>

      </div>
      <div class="rcard-footer" style="display:flex; gap:10px;">
        <a href="/admin/role/list" class="btn-secondary">Huỷ</a>
        <button type="submit" class="btn-primary">
          <i class="fa-solid fa-plus"></i> Tạo vai trò
        </button>
      </div>
    </form>
  </div>
</main>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>

