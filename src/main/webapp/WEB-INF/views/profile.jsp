<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
  <title>Thông tin cá nhân</title>
  <%@ include file="/WEB-INF/views/layout/default.jsp" %>
  <link rel="stylesheet" href="assets/css/profile.css">
</head>

<body>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/sider.jsp" %>
<div class="sider-overlay"></div>

<main class="main">

  <%-- Breadcrumb --%>
  <nav class="breadcrumb">
    <a href="/admin/dashboard"><i class="fa-solid fa-house"></i></a>
    <span class="sep"><i class="fa-solid fa-chevron-right"></i></span>
    <span class="current">Thông tin cá nhân</span>
  </nav>

  <h1 class="box-title">Thông tin cá nhân</h1>

  <%-- ══ HERO CARD ══ --%>
  <div class="profile-hero">
    <div class="profile-hero-banner"></div>
    <div class="profile-hero-body">

      <div class="profile-avatar-wrap">
        <div class="profile-avatar">
          <c:choose>
            <c:when test="${not empty profile.avatar}">
              <img src="${profile.avatar}" alt="Avatar">
            </c:when>
            <c:otherwise>
              <i class="fa-solid fa-user"></i>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="profile-avatar-edit" title="Đổi ảnh đại diện">
          <i class="fa-solid fa-camera"></i>
        </div>
      </div>

      <div class="profile-hero-info">
        <h2 class="profile-hero-name">
          ${not empty profile.fullName ? profile.fullName : 'Chưa cập nhật'}
        </h2>
        <div class="profile-hero-meta">
          <span class="profile-hero-badge">
            <i class="fa-solid fa-shield-halved"></i>
            ${not empty profile.role ? profile.role : 'Admin'}
          </span>
          <span class="profile-hero-role">
            <i class="fa-solid fa-briefcase" style="margin-right:4px;font-size:11px;"></i>
            ${not empty profile.positionCompany ? profile.positionCompany : 'Chưa cập nhật'}
          </span>
        </div>
      </div>

    </div>
  </div>

  <%-- ══ 2-COL LAYOUT ══ --%>
  <div class="profile-layout">

    <%-- LEFT: Form --%>
    <div class="profile-left">
      <div class="pcard">

        <div class="pcard-header">
          <div class="pcard-header-icon"><i class="fa-solid fa-user-pen"></i></div>
          <h3 class="pcard-header-title">Chỉnh sửa thông tin</h3>
        </div>

        <form id="profile-edit-form"
              method="post"
              action="/admin/profile/edit"
              enctype="multipart/form-data">

          <div class="pcard-body">
            <div class="form-grid">

              <%-- Họ tên --%>
              <div class="field-group">
                <label class="field-label" for="fullName">
                  Họ tên <span class="required">*</span>
                </label>
                <div class="field-icon-wrap">
                  <i class="fa-solid fa-user field-icon"></i>
                  <input class="field-control" type="text"
                    id="fullName" name="fullName"
                    placeholder="Nhập họ và tên..."
                    value="${profile.fullName}">
                </div>
              </div>

              <%-- Số điện thoại --%>
              <div class="field-group">
                <label class="field-label" for="phone">Số điện thoại</label>
                <div class="field-icon-wrap">
                  <i class="fa-solid fa-phone field-icon"></i>
                  <input class="field-control" type="text"
                    id="phone" name="phone"
                    placeholder="Nhập số điện thoại..."
                    value="${profile.phone}">
                </div>
              </div>

              <%-- Email --%>
              <div class="field-group full">
                <label class="field-label" for="email">
                  Email <span class="required">*</span>
                </label>
                <div class="field-icon-wrap">
                  <i class="fa-solid fa-envelope field-icon"></i>
                  <input class="field-control" type="email"
                    id="email" name="email"
                    placeholder="Nhập địa chỉ email..."
                    value="${profile.email}">
                </div>
              </div>

              <%-- Chức vụ (readonly) --%>
              <div class="field-group">
                <label class="field-label" for="positionCompany">Chức vụ</label>
                <div class="field-icon-wrap">
                  <i class="fa-solid fa-briefcase field-icon"></i>
                  <input class="field-control field-readonly" type="text"
                    id="positionCompany"
                    value="${profile.positionCompany}"
                    readonly>
                </div>
              </div>

              <%-- Nhóm quyền (readonly) --%>
              <div class="field-group">
                <label class="field-label" for="role">Nhóm quyền</label>
                <div class="field-icon-wrap">
                  <i class="fa-solid fa-shield-halved field-icon"></i>
                  <input class="field-control field-readonly" type="text"
                    id="role"
                    value="${profile.role}"
                    readonly>
                </div>
              </div>

              <%-- Avatar input ẩn cho filepond --%>
              <div style="display:none;">
                <input type="file" id="avatar" name="avatar"
                  accept="image/*"
                  image-default="${profile.avatar}"
                  filepond-image>
              </div>

            </div><%-- /form-grid --%>
          </div><%-- /pcard-body --%>

          <div class="form-actions">
            <button type="submit" class="btn-primary">
              <i class="fa-solid fa-floppy-disk"></i> Lưu thay đổi
            </button>
            <a href="/admin/dashboard" class="btn-secondary">
              <i class="fa-solid fa-xmark"></i> Huỷ
            </a>
          </div>

        </form>

      </div><%-- /pcard --%>
    </div><%-- /profile-left --%>

    <%-- RIGHT: Sidebar --%>
    <div class="profile-right">

      <%-- Thông tin tài khoản --%>
      <div class="pcard" style="margin-bottom:20px;">
        <div class="pcard-header">
          <div class="pcard-header-icon"><i class="fa-solid fa-circle-info"></i></div>
          <h3 class="pcard-header-title">Thông tin tài khoản</h3>
        </div>
        <div class="pcard-body" style="padding-top:4px;padding-bottom:4px;">
          <ul class="meta-list">
            <li>
              <span class="meta-key"><i class="fa-solid fa-envelope"></i> Email</span>
              <span class="meta-val">${not empty profile.email ? profile.email : '—'}</span>
            </li>
            <li>
              <span class="meta-key"><i class="fa-solid fa-phone"></i> Điện thoại</span>
              <span class="meta-val">${not empty profile.phone ? profile.phone : '—'}</span>
            </li>
            <li>
              <span class="meta-key"><i class="fa-solid fa-user-shield"></i> Nhóm quyền</span>
              <span class="meta-val">${not empty profile.role ? profile.role : '—'}</span>
            </li>
            <li>
              <span class="meta-key"><i class="fa-solid fa-clock"></i> Cập nhật lần cuối</span>
              <span class="meta-val">${not empty profile.updatedAt ? profile.updatedAt : '—'}</span>
            </li>
          </ul>
        </div>
      </div>

      <%-- Bảo mật --%>
      <div class="pcard">
        <div class="pcard-header">
          <div class="pcard-header-icon"><i class="fa-solid fa-lock"></i></div>
          <h3 class="pcard-header-title">Bảo mật</h3>
        </div>
        <div class="pcard-body">
          <div class="security-list">
            <a href="/admin/profile/change-password" class="security-item">
              <div class="security-item-left">
                <div class="security-item-icon"><i class="fa-solid fa-key"></i></div>
                <div>
                  <div class="security-item-text">Đổi mật khẩu</div>
                  <div class="security-item-desc">Cập nhật mật khẩu định kỳ</div>
                </div>
              </div>
              <i class="fa-solid fa-chevron-right security-item-arrow"></i>
            </a>
          </div>
        </div>
      </div>

    </div><%-- /profile-right --%>

  </div><%-- /profile-layout --%>

  <%-- Toast notifications --%>
  <c:if test="${not empty success}">
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        toastr.success('<c:out value="${success}"/>');
      });
    </script>
  </c:if>
  <c:if test="${not empty error}">
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        toastr.error('<c:out value="${error}"/>');
      });
    </script>
  </c:if>

</main>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
</html>
