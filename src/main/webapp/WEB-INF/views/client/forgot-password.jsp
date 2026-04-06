<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quên mật khẩu</title>
    <!-- CSS and Scripts -->
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>

<body>
    <div class="page-account">
        <div class="form-account">
            <h2 class="inner-title">Quên Mật Khẩu</h2>
            <p class="inner-desc">Nhập email đã đăng ký của bạn để nhận mã khôi phục</p>
            
            <form class="inner-form" action="/forgot-password" method="POST">
                <div class="inner-group">
                    <label class="inner-label" for="email">Email</label>
                    <input class="inner-control" type="email" name="email" id="email"
                        placeholder="Nhập email của bạn" required />
                </div>
                
                <button class="inner-button" type="submit">Gửi Mã Khôi Phục</button>
            </form>

            <div class="inner-more">
                <a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
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
