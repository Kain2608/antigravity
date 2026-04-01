
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <div class="rcard">                        
  <div class="rcard-header">...</div>
  <form action="/admin/role/create" method="post">
    <div class="rcard-body">

      <div class="role-create-layout">        

        <div class="role-create-main">        
          <div class="field-group">
            <label class="field-label">Tên vai trò *</label>
            <div class="field-icon-wrap">
              <i class="fa-solid fa-shield-halved field-icon"></i>
              <input class="field-control" type="text" name="name"
                     placeholder="VD: Admin,..." required>
            </div>
          </div>

          <div class="field-group">
            <label class="field-label">Mô tả</label>
            <textarea class="field-control rc-textarea"
                      name="description"
                      placeholder="Mô tả vai trò..."></textarea>
          </div>

          <div class="field-group">
            <h4 style="margin-bottom: 12px;">Phân quyền</h4>
            <div class="perm-module perm-actions">
              <c:forEach var="p" items="${permissions}">
                <label class="perm-action-item">
                  <input type="checkbox" name="permission" value="${p.code}"> ${p.name}
                </label>
              </c:forEach>
            </div>
          </div>
        </div>

        <div class="role-create-sidebar">     
          <div class="rc-action-body">
            <button type="submit" class="btn-primary rc-btn-full">
              <i class="fa-solid fa-plus"></i> Tạo vai trò
            </button>
            <a href="/admin/role/list" class="btn-secondary rc-btn-full">Huỷ</a>
          </div>
        </div>

      </div>
    </div>
  </form>
</div>
</main>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>

