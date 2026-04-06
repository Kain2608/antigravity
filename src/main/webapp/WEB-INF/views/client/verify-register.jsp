<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Xác minh Đăng ký</title>
    <!-- CSS and Scripts -->
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>

<body>
    <div class="page-account">
        <div class="form-account">
            <h2 class="inner-title">Xác minh Email</h2>
            <p class="inner-desc">Chúng tôi đã gửi mã xác nhận đến email của bạn</p>
            
            <form class="inner-form" action="/register-verify" method="POST">
                <div class="inner-group">
                    <label class="inner-label" for="otp">Mã Xác Nhận (OTP)</label>
                    <input class="inner-control" type="text" name="otp" id="otp"
                        placeholder="Nhập 6 số" style="letter-spacing: 5px; text-align: center; font-size: 20px;" maxlength="6" required />
                </div>
                
                <button class="inner-button" type="submit">Xác Nhận & Hoàn Tất</button>
            </form>

            <div class="inner-more" style="margin-top: 15px;">
                <form action="/register" method="POST" style="display:inline;">
                    <!-- We could resend by just pulling their session info, but we make them register again for simplicity if they leave -->
                    <a href="${pageContext.request.contextPath}/register">Quay lại trang đăng ký</a>
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
