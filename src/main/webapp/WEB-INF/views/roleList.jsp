
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Quản lý phân quyền</title>
  <%@ include file="/WEB-INF/views/layout/default.jsp" %>
  <link rel="stylesheet" href="assets/css/role.css">
</head>

<body>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/sider.jsp" %>
<div class="sider-overlay"></div>

<main class="main">

  <nav class="breadcrumb">
    <a href="#"><i class="fa-solid fa-house"></i></a>
    <span class="sep"><i class="fa-solid fa-chevron-right"></i></span>
    <span class="current">Quản lý phân quyền</span>
  </nav>

  <div class="role-page-header">
    <h1 class="box-title">Quản lý phân quyền</h1>
    <a href="/admin/role/create" class="btn-create" id="btnOpenCreate">
      <i class="fa-solid fa-plus"></i> Thêm vai trò
    </a>
  </div>

  <div class="role-layout">

    <div class="role-list-col">
      <div class="rcard">

        <div class="rcard-header">
          <div class="rcard-header-icon"><i class="fa-solid fa-shield-halved"></i></div>
          <h3>Danh sách vai trò</h3>
          <span class="role-count-badge">2</span>
        </div>

        <div class="role-search-wrap">
          <i class="fa-solid fa-magnifying-glass"></i>
          <input type="text" placeholder="Tìm vai trò...">
        </div>

        <ul class="role-list">
          <li class="role-item active">
            <div class="role-item-icon"><i class="fa-solid fa-shield-halved"></i></div>
            <div class="role-item-info">
              <span class="role-item-name">Admin</span>
              <span class="role-item-count"><i class="fa-solid fa-users"></i> 5 người dùng</span>
            </div>
          </li>

          <li class="role-item">
            <div class="role-item-icon"><i class="fa-solid fa-shield-halved"></i></div>
            <div class="role-item-info">
              <span class="role-item-name">User</span>
              <span class="role-item-count"><i class="fa-solid fa-users"></i> 12 người dùng</span>
            </div>
          </li>
        </ul>

      </div>
    </div>
    <div class="role-detail-col">
      <div class="rcard">
        <div class="rcard-header">
          <h3>Thông tin vai trò</h3>
        </div>
        <div class="rcard-body">
          <p><b>Tên:</b> Admin</p>
          <p><b>Số user:</b> 5</p>
          <p><b>Mô tả:</b> Quản trị toàn hệ thống</p>
        </div>
      </div>
      <div class="rcard" style="margin-top:20px;">
        <div class="rcard-header">
          <h3>Phân quyền</h3>
        </div>

        <div class="rcard-body">

          <div class="perm-module">
            <b>Quản lý User</b><br>
            <label><input type="checkbox" checked> Xem</label>
            <label><input type="checkbox" checked> Thêm</label>
            <label><input type="checkbox"> Xoá</label>
          </div>

          <div class="perm-module">
            <b>Quản lý Product</b><br>
            <label><input type="checkbox" checked> Xem</label>
            <label><input type="checkbox"> Thêm</label>
            <label><input type="checkbox"> Xoá</label>
          </div>

        </div>
      </div>
      <div class="rcard" style="margin-top:20px;">
        <div class="rcard-header">
          <h3>Người dùng thuộc vai trò</h3>
        </div>

        <div class="rcard-body">
          <table border="1" width="100%">
            <tr>
              <th>Tên</th>
              <th>Email</th>
              <th>Chức vụ</th>
            </tr>

            <tr>
              <td>Nguyễn Văn A</td>
              <td>a@gmail.com</td>
              <td>Developer</td>
            </tr>
            <tr>
              <td>Trần Văn B</td>
              <td>b@gmail.com</td>
              <td>Tester</td>
            </tr>

          </table>
        </div>
      </div>

    </div>

  </div>

</main>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
</html>

