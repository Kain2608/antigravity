<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Quản lý danh mục</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
  </head>
  <body>
    <%@ include file="/WEB-INF/views/layout/header.jsp" %> <%@ include
    file="/WEB-INF/views/layout/sider.jsp" %>
    <div class="sider-overlay"></div>

    <main class="main">
      <h1 class="box-title">Quản lý danh mục</h1>
      <!-- STATS ROW -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon si-blue">
            <i class="fa-solid fa-table-cells"></i>
          </div>
          <div>
            <div class="stat-val">${totalCategory}</div>
            <div class="stat-lbl">Tổng danh mục</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon si-green">
            <i class="fa-solid fa-circle-check"></i>
          </div>
          <div>
            <div class="stat-val">${totalActive}</div>
            <div class="stat-lbl">Đang hoạt động</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon si-red">
            <i class="fa-solid fa-circle-xmark"></i>
          </div>
          <div>
            <div class="stat-val">${totalInactive}</div>
            <div class="stat-lbl">Tạm dừng</div>
          </div>
        </div>
        
          
        </div>
      </div>
      <!-- END STATS ROW -->
      <div class="section-4">
        <div class="inner-wrap">
          <div class="inner-item inner-label">
            <i class="fa-solid fa-filter"></i> Bộ lọc
          </div>
          <div class="inner-item">
            <select filter-status>
              <option value="">Trạng thái</option>
              <option value="active">Hoạt động</option>
              <option value="inactive">Tạm dừng</option>
            </select>
          </div>
          <div class="inner-item">
            <select filter-create-by>
              <option value="">Người tạo</option>
              <c:forEach var="user" items="${userList}">
                <option value="${user.fullName}">
                  ${user.fullName}
                </option>
              </c:forEach>
              
            </select>
          </div>
          <div class="inner-item inner-reset" btn-reset>
            <i class="fa-solid fa-rotate-left"></i> Xóa bộ lọc
          </div>
        </div>
      </div>
      <div class="section-5">
        <div class="inner-wrap">
          <div class="inner-search">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" placeholder="Tìm kiếm" />
          </div>
          <div class="inner-button-create">
            <button><a href="/admin/category/create">+ Tạo mới</a></button>
          </div>
        </div>
      </div>
      <div class="section-6">
        <div class="table-2">
          <table>
            <thead>
              <tr>
                <th class="inner-center">
                  <input type="checkbox" />
                </th>
                <th class="inner-center">Vị trí</th>
                <th>Tên danh mục</th>
                <th>Ảnh đại diện</th>
                <th class="inner-center">Trạng thái</th>
                <th>Tạo bởi</th>
                <th>Cập nhật bởi</th>
                <th>Hành động</th>
              </tr>
            </thead>

            <tbody>
              <c:forEach var="item" items="${categoryList}">
              <tr>
                <td class="inner-center"><input type="checkbox" /></td>
                <td class="inner-center">${item.id}</td>
                <td>${item.name}</td>
                <td>
                  <img class="inner-avatar" src= ${item.avatar} />
                </td>
                <td class="inner-center">
                  <c:choose>
                    <c:when test="${item.status == 'active'}">
                      <div class="badge badge-green">Hoạt động</div>
                    </c:when>
                    <c:otherwise>
                      <div class="badge badge-red">Tạm dừng</div>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <div>${item.createdBy}</div>
                  <div class="inner-time">${item.createdAt}</div>
                </td>
                <td>
                  <div>${item.updatedBy}</div>
                  <div class="inner-time">${item.updatedAt}</div>
                </td>
                <td>
                  <button><a href="/admin/category/edit/${item.id}">Sửa</a></button>
                  <button><a href="/admin/category/delete/${item.id}" onclick="return confirm('Bạn có muốn xóa danh mục này không')">Xóa</a></button>
                </td>
              </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
      <div class="section-7"><span class="inner-label">Trang </span>
        <select class="inner-pagination">
          <option>1</option>
          <option>2</option>
          <option>3</option>
        </select>
      </div>
      <c:if test="${not empty success}">
        <script>
          toastr.success("${success}");
        </script>
      </c:if>
      <c:if test="${not empty error}">
        <script>
          toastr.error("${error}");
        </script>
      </c:if>
    </main>
    <%@ include file="/WEB-INF/views/layout/footer.jsp" %>
  </body>
</html>
