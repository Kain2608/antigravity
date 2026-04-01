
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
          <span class="role-count-badge">${count}</span>
        </div>

        <div class="role-search-wrap">
          <i class="fa-solid fa-magnifying-glass"></i>
          <input type="text" placeholder="Tìm vai trò...">
        </div>

        <ul class="role-list">
          <c:forEach  var="item" items="${roleList}">
          <li class="role-item active">
            <div class="role-item-icon"><i class="fa-solid fa-shield-halved"></i></div>
            <div class="role-item-info">
              <span class="role-item-name">${item.name}</span>
              <span class="role-item-count"><i class="fa-solid fa-users"></i> ${countMap[item.name]} thành viên</span>
            </div>
          </li>
          </c:forEach>
        </ul>

      </div>
    </div>
    <div class="role-detail-col">
      <div class="rcard">
        <c:forEach  var="item" items="${roleList}">
        <div class="rcard-header">
          <h3>Thông tin vai trò</h3>
          <button class="btn-delete-role" onclick="return confirm('Bạn có muốn xóa danh mục này không?')">
            <i class="fa-solid fa-trash"></i>
          </button>
        </div>
        <div class="rcard-body">
          <p><b>Tên:</b> ${item.name}</p>
          <p><b>Số user:</b> ${countMap[item.name]} thành viên</p>
          <p><b>Mô tả:</b> ${item.description}</p>
        </div>
        </c:forEach>
      </div>
      
  </div>

</main>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
</html>

