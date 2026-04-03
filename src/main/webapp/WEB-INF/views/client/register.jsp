<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đăng ký khách hàng</title>
    <!-- CSS and Scripts -->
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>

<body>
    <div class="page-account">
        <div class="form-account">
            <h2 class="inner-title">Tạo tài khoản mới</h2>
            <p class="inner-desc">Tận hưởng nhiều ưu đãi hơn với tư cách thành viên</p>
            
            <!-- Standard POST Form -->
            <form class="inner-form" id="register-form" action="/register" method="POST">
                <div class="inner-group">
                    <label class="inner-label" for="fullName">Họ và tên</label>
                    <input class="inner-control" type="text" name="fullName" id="fullName"
                        placeholder="Ví dụ: Nguyễn Văn A" required />
                </div>
                <div class="inner-group">
                    <label class="inner-label" for="email">Email</label>
                    <input class="inner-control" type="email" name="email" id="email"
                        placeholder="Ví dụ: levana@gmail.com" required />
                </div>
                <div class="inner-group">
                    <label class="inner-label" for="password">Mật khẩu</label>
                    <input class="inner-control" type="password" name="password" id="password" required />
                </div>
                <div class="inner-meta">
                    <div class="inner-confirm">
                        <input class="inner-check" type="checkbox" name="agree" id="agree" required value="true" />
                        <label class="inner-label" for="agree"> Tôi đồng ý với các điều khoản và thông tin mua hàng </label>
                    </div>
                </div>
                <button class="inner-button" type="submit">Xác Nhận Đăng Ký</button>
            </form>

            <div class="inner-more">
                <span>Bạn đã có tài khoản?</span><a href="${pageContext.request.contextPath}/login">Đăng nhập tại đây</a>
            </div>
        </div>
    </div>

    <!-- Error Handling using JSTL -->
    <c:if test="${not empty error}">
        <script>toastr.error("${error}");</script>
    </c:if>
</body>
</html>