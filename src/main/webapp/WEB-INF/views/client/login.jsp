<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Đăng nhập khách hàng</title>
            <!-- Your existing CSS and Scripts -->
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

                    <!-- Removed standard 'action' and 'method'. ID remains 'login-form' -->
                    <form class="inner-form" id="login-form">
                        <div class="inner-group">
                            <label class="inner-label" for="email">Email</label>
                            <input class="inner-control" type="email" name="email" id="email" placeholder="Nhập email"
                                required />
                        </div>
                        <div class="inner-group">
                            <label class="inner-label" for="password">Mật khẩu</label>
                            <input class="inner-control" type="password" name="password" id="password" required />
                        </div>
                        <div class="inner-meta">
                            <div class="inner-confirm">
                                <input class="inner-check" type="checkbox" name="rememberPassword"
                                    id="remember-password" />
                                <label class="inner-label" for="remember-password">Nhớ mật khẩu</label>
                            </div>
                        </div>
                        <button class="inner-button" type="submit">Đăng Nhập</button>
                    </form>

                    <div class="inner-more">
                        <span>Bạn chưa có tài khoản?</span><a href="<c:url value='/register'/>">Đăng ký ngay</a>
                    </div>
                </div>
            </div>

            <!-- AJAX Implementation block -->
    <script>
        // Check if user is already logged in, redirect them back to the home page!
        if (localStorage.getItem('token')) {
            window.location.href = "<c:url value='/'/>";
        }

        $(document).ready(function() {
                    $('#login-form').on('submit', function (e) {
                        // 1. Prevent page reload 
                        e.preventDefault();

                        // 2. Fetch input parameters
                        var email = $('#email').val();
                        var password = $('#password').val();

                        // 3. Initiate AJAX request to backend
                        $.ajax({
                            url: 'http://localhost:8081/api/auth/login',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify({
                                email: email,
                                password: password
                            }),
                            success: function (response) {
                                // 4. Capture JWT Token (fallback parsing included)
                                var token = response.token || response.accessToken || response;

                                if (token) {
                                    // 5. Store JWT and Redirect
                                    localStorage.setItem('token', token);
                                    toastr.success("Đăng nhập thành công!");
                                    setTimeout(function () {
                                        window.location.href = "<c:url value='/'/>";
                                    }, 1000);
                                } else {
                                    toastr.warning("Kết nối thành công nhưng không nhận được Token.");
                                }
                            },
                            error: function (xhr) {
                                // 6. Print visual Error directly from JSON payload
                                var msg = "Đăng nhập thất bại. Vui lòng kiểm tra lại thông tin.";
                                if (xhr.responseJSON && xhr.responseJSON.message) {
                                    msg = xhr.responseJSON.message;
                                }
                                toastr.error(msg);
                            }
                        });
                    });
                });
            </script>
        </body>

        </html>