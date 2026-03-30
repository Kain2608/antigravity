<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
  <title>Tạo danh mục</title>
  <%@ include file="/WEB-INF/views/layout/default.jsp" %>
</head>

<body>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/sider.jsp" %>
<div class="sider-overlay"></div>

<main class="main">
  <h1 class="box-title">Tạo danh mục</h1>

  <div class="section-8">
    <form id="category-create-form" method="post" action="/admin/category/create" enctype="multipart/form-data">

      <div class="inner-group">
        <label class="inner-label" for="name">Tên danh mục</label>
        <input type="text" name="name" id="name">
      </div>

      <div class="inner-group">
        <label class="inner-label" for="status">Trạng thái</label>
        <select name="status" id="status">
          <option value="active">Hoạt động</option>
          <option value="inactive">Dừng</option>
        </select>
      </div>

      <div class="inner-group inner-two-col">
        <label class="inner-label" for="avatar">Ảnh</label>
        <div class="inner-upload-image">
          <input type="file" id="avatar" name="avatar" filepond-image accept="image/*">
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
  <c:if test="${not empty success}">
  <script>
    $(document).ready(function(){
      toastr.success('<c:out value="${success}"/>');
    });
  </script>
  </c:if>

  <c:if test="${not empty error}">
    <script>
      $(document).ready(function(){
        toastr.error('<c:out value="${error}"/>');
      });
    </script>
  </c:if>
</main>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
</html>