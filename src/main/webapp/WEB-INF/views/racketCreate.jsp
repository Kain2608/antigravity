<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Tạo vợt cầu lông</title>

  <%@ include file="/WEB-INF/views/layout/default.jsp" %>
</head>
<body>

<header class="header">
  <div class="inner-logo"><a href="#"><span>28</span><span>Admin</span></a></div>
  <div class="inner-wrap">
    <div class="inner-notify"><img src="<c:url value='/images/icon-bell.svg'/>" alt=""><span>6</span></div>
    <div class="inner-account">
      <div class="inner-avatar"><img src="<c:url value='/images/avatar.jpg'/>" alt=""></div>
      <div class="inner-text">
        <div class="inner-name">Le Van A</div>
        <div class="inner-role">Admin</div>
      </div>
    </div>
    <button class="inner-button-menu"><i class="fa-solid fa-bars"></i></button>
  </div>
</header>

<nav class="sider">
  <ul class="inner-menu">
    <li><a  href="#"><i class="fa-solid fa-gauge-high"></i> Tổng quan</a></li>
    <li><a class="active" href="#"><i class="fa-solid fa-table-cells-large"></i> Quản lý danh mục</a></li>
    <li><a href="#"><i class="fa-solid fa-table-list"></i> Quản lý sản phẩm</a></li>
    <li><a href="#"><i class="fa-solid fa-list-check"></i> Quản lý đơn hàng</a></li>
    <li><a href="#"><i class="fa-solid fa-user"></i> Quản lý người dùng</a></li>
    <li><a href="#"><i class="fa-solid fa-user-group"></i> Thông tin liên hệ</a></li>
  </ul>
  <hr>
  <ul class="inner-menu">
    <li><a href="#"><i class="fa-solid fa-gear"></i> Cài đặt chung</a></li>
    <li><a href="#"><i class="fa-solid fa-user-gear"></i> Thông tin cá nhân</a></li>
    <li><a class="inner-logout" href="#"><i class="fa-solid fa-power-off"></i> Đăng xuất</a></li>
  </ul>
</nav>

<div class="sider-overlay"></div>

<main class="main">
  <h1 class="box-title">Tạo vợt cầu lông</h1>

  <div class="section-8">
    <form id="racket-create-form" method="post" action="/admin/product/racket-create" enctype="multipart/form-data">

      <div class="inner-group">
        <label class="inner-label" for="name">Tên vợt</label>
        <input type="text" id="name" name="name">
      </div>
      <div class="inner-group">
        <label class="inner-label" for="category">Danh mục</label>
        <select id="category" name="category">
          <option value="">-- Chọn danh mục --</option>
          <option value="">Danh mục 1</option>
          <option value="">Danh mục 2</option>
        </select>
      </div>
      <div class="inner-group">
        <label for="brand" class="inner-label">Thương hiệu</label>
        <select name="brand" id="brand">
          <option value="">-- Chọn thương hiệu --</option>
          <option value="">TH1</option>
          <option value="">TH2</option>
        </select>
      </div>
      <div class="inner-group">
        <label class="inner-label">Trạng thái</label>
        <select name="status" id="status">
          <option value="active">Hoạt động</option>
          <option value="inactive">Dừng</option>
        </select>
      </div>
      <div class="inner-group">
        <label class="inner-label" for="length">Chiều dài</label>
        <input type="text" id="length" name="length" placeholder="vd:675mm">
      </div>

      <div class="inner-group">
        <label class="inner-label" for="weight">Trọng lượng</label>
        <input type="text" id="weight" name="weight" placeholder="vd:83g">
      </div>
    
      <div class="inner-group">
        <label class="inner-label" for="price">Giá</label>
        <input type="number" id="price" name="price">
      </div>
      <div class="inner-group">
        <label class="inner-label" for="style">Phong cách chơi</label>
        <select id="style" name="style">
          <option value="actack">Công</option>
          <option value="defend">Thủ</option>
          <option value="balance">Cân bằng</option>
        </select>
      </div>

      <div class="inner-group inner-two-col">
        <label class="inner-label" for="avatar">Ảnh đại diện</label>
        <div class="inner-upload-image">
          <input type="file" id="avatar" accept="image/*" filepond-image name="avatar">
        </div>
      </div>

      <div class="inner-group inner-two-col">
        <label class="inner-label" for="description">Mô tả</label>
        <textarea id="description" textarea-mce name="description"></textarea>
      </div>

      <div class="inner-button inner-two-col">
        <button type="submit">Tạo vợt</button>
      </div>

    </form>
    <div class="inner-back"><a href="#">Quay lại danh sách</a></div>
  </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.6/Sortable.min.js"></script>
<script src="https://unpkg.com/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.js"></script>
<script src="https://unpkg.com/filepond-plugin-file-validate-type/dist/filepond-plugin-file-validate-type.js"></script>
<script src="https://unpkg.com/filepond@^4/dist/filepond.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://unpkg.com/just-validate@latest/dist/just-validate.production.min.js"></script>
<script src="<c:url value='/js/script.js'/>"></script>

</body>
</html>