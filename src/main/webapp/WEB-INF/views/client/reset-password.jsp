<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đặt lại mật khẩu</title>
    <!-- CSS and Scripts -->
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>

<body>
    <div class="page-account">
        <div class="form-account">
            <h2 class="inner-title">Đặt Lại Mật Khẩu</h2>
            <p class="inner-desc">Nhập mã xác nhận (OTP) và mật khẩu mới của bạn</p>
            
            <form class="inner-form" action="/reset-password" method="POST">
                <div class="inner-group">
                    <label class="inner-label" for="otp">Mã Xác Nhận (OTP)</label>
                    <input class="inner-control" type="text" name="otp" id="otp"
                        placeholder="Nhập 6 số" style="letter-spacing: 5px; text-align: center; font-size: 20px;" maxlength="6" required />
                </div>
                <div class="inner-group">
                    <label class="inner-label" for="newPassword">Mật khẩu mới</label>
                    <input class="inner-control" type="password" name="newPassword" id="newPassword" required minlength="6" />
                </div>
                <div class="inner-group">
                    <label class="inner-label" for="confirmPassword">Xác nhận mật khẩu</label>
                    <input class="inner-control" type="password" name="confirmPassword" id="confirmPassword" required minlength="6" />
                </div>
                
                <button class="inner-button" type="submit">Cập Nhật Mật Khẩu</button>
            </form>

            <div class="inner-more" style="margin-top: 15px;">
                <form action="/forgot-password" method="POST" style="display:inline;">
                    <input type="hidden" name="email" value="${sessionScope.resetEmail}" />
                    <button type="submit" style="background:none; border:none; color:#007bff; text-decoration:none; cursor:pointer;">Gửi lại mã OTP</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Error Handling using JSTL -->
    <c:if test="${not empty error}">
        <script>toastr.error("${error}");</script>
    </c:if>
    <c:if test="${not empty success}">
        <script>toastr.success("${success}");</script>
    </c:if>
</body>
</html>
