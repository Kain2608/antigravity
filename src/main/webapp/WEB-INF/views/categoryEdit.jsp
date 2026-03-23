<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
  <title>Sửa danh mục</title>
  <%@ include file="/WEB-INF/views/layout/default.jsp" %>
</head>

<body>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/sider.jsp" %>
<div class="sider-overlay"></div>

<main class="main">
  <h1 class="box-title">Sửa danh mục</h1>

  <div class="section-8">
    <form id="category-edit-form" method="post" action="/admin/category/edit/${categoryDetail.id}" enctype="multipart/form-data">

      <div class="inner-group">
        <label class="inner-label" for="name">Tên danh mục</label>
        <input type="text" name="name" id="name" value="${categoryDetail.name}">
      </div>

      <div class="inner-group">
        <label class="inner-label" for="status">Trạng thái</label>
        <select name="status" id="status">
          <option value="active"
            <c:if test="${categoryDetail != null and categoryDetail.status eq 'active'}">selected</c:if>>
            Hoạt động
          </option>

          <option value="inactive"
            <c:if test="${categoryDetail != null and categoryDetail.status eq 'inactive'}">selected</c:if>>
            Dừng
          </option>
        </select>
      </div>

      <div class="inner-group inner-two-col">
        <label class="inner-label" for="avatar">Ảnh</label>
        <div class="inner-upload-image">
          <input type="file" id="avatar" name="avatar" image-default=${categoryDetail.avatar} filepond-image accept="image/*">
        </div>
      </div>

      <div class="inner-group inner-two-col">
        <label class="inner-label" for="description">Mô tả</label>
        <textarea name="description" id="description" textarea-mce></textarea>
      </div>

      <div class="inner-button inner-two-col">
        <button type="submit">Tạo danh mục</button>
      </div>

    </form>

    <div class="inner-back">
      <a href="/admin/category/list">Quay lại danh sách</a>
    </div>
  </div>
</main>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
</html>