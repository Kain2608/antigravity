<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đăng nhập khách hàng</title>
    <!-- CSS and Scripts -->
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>

<body>
    <div class="page-account">
        <div class="form-account">
            <h2 class="inner-title">Đăng nhập tài khoản</h2>
            <p class="inner-desc">Mua sắm nhanh chóng và quản lý đơn hàng dễ dàng</p>
            
            <!-- Standard Form Submission directly to Spring Controller -->
            <form class="inner-form" id="login-form" action="/login" method="POST">
                <div class="inner-group">
                    <label class="inner-label" for="email">Email</label>
                    <input class="inner-control" type="email" name="email" id="email" placeholder="Nhập email" required />
                </div>
                <div class="inner-group">
                    <label class="inner-label" for="password">Mật khẩu</label>
                    <input class="inner-control" type="password" name="password" id="password" required />
                </div>
                <div class="inner-meta">
                    <div class="inner-confirm">
                        <input class="inner-check" type="checkbox" name="rememberPassword" id="remember-password" />
                        <label class="inner-label" for="remember-password">Nhớ mật khẩu</label>
                    </div>
                </div>
                <button class="inner-button" type="submit">Đăng Nhập</button>
            </form>

            <div class="inner-more">
                <span>Bạn chưa có tài khoản?</span><a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
            </div>
        </div>
    </div>

    <!-- Error/Success Handling using JSTL and Model Flash Attributes -->
    <c:if test="${not empty error}">
        <script>toastr.error("${error}");</script>
    </c:if>
    <c:if test="${not empty success}">
        <script>toastr.success("${success}");</script>
    </c:if>
</body>
</html>