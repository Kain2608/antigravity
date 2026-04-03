<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportStore - Đồ Thể Thao Chính Hãng</title>
    
    <link rel="stylesheet" href="css/client.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

    <!-- Header -->
    <header>
        <div class="top-bar">
            <div class="container">
                <p>🚚 Miễn phí vận chuyển cho đơn hàng từ 500.000đ | Hotline: 0123 456 789</p>
            </div>
        </div>
        
        <nav class="navbar">
            <div class="container">
                <div class="logo">
                    <h1>Sport<span>Store</span></h1>
                </div>
                
                <div class="search-bar">
                    <input type="text" id="searchInput" placeholder="Tìm kiếm sản phẩm...">
                    <button onclick="searchProduct()"><i class="fas fa-search"></i></button>
                </div>
                
                <div class="nav-icons">
                    <span id="auth-container">
                        <a href="/login" class="icon-link" id="userIcon"><i class="fas fa-user"></i></a>
                    </span>
                    <a href="#" class="icon-link cart-icon" onclick="viewCart()">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="cart-count" id="cartCount">0</span>
                    </a>
                </div>
            </div>
        </nav>
    </header>

    <!-- Hero Banner -->
    <section class="hero">
        <div class="hero-content">
            <h2>CHẠY NHANH - TẬP MẠNH - THẮNG LỚN</h2>
            <p>Đồ thể thao chính hãng - Giá tốt nhất tại SportStore</p>
            <a href="#products" class="btn-primary">Mua Sắm Ngay</a>
        </div>
    </section>

    <!-- Danh mục sản phẩm -->
    <section class="categories">
        <div class="container">
            <h2 class="section-title">Danh Mục Sản Phẩm</h2>
            <div class="category-grid">
                
                <div class="category-card">
                    <img src="https://source.unsplash.com/300x200/?sneakers" alt="Giày thể thao">
                    <h3>Giày Thể Thao</h3>
                </div>
                
                <div class="category-card">
                    <img src="https://source.unsplash.com/300x200/?sportswear" alt="Quần áo">
                    <h3>Quần Áo Thể Thao</h3>
                </div>
                
                <div class="category-card">
                    <img src="https://source.unsplash.com/300x200/?dumbbell" alt="Dụng cụ gym">
                    <h3>Dụng Cụ Gym</h3>
                </div>
                
                <div class="category-card">
                    <img src="https://source.unsplash.com/300x200/?soccer" alt="Bóng đá">
                    <h3>Bóng Đá & Thể Thao Đội Nhóm</h3>
                </div>
            </div>
        </div>
    </section>

    <!-- Sản phẩm nổi bật -->
    <section class="featured-products" id="products">
        <div class="container">
            <h2 class="section-title">Sản Phẩm Nổi Bật</h2>
            
            <div class="product-grid">

    <!-- Sản phẩm 1 -->
    <div class="product-card">
        <div class="product-image">
            <span class="badge badge-sale">SALE 20%</span>
            <img src="https://source.unsplash.com/600x600/?nike,running" alt="Nike Pegasus">
            <button class="quick-view" onclick="quickView(1)">Xem nhanh</button>
        </div>
        <div class="product-info">
            <div class="brand">Nike</div>
            <h3>Nike Air Zoom Pegasus 40</h3>
            <div class="rating">
                ★★★★☆ <span>(124)</span>
            </div>
            <div class="price-container">
                <span class="current-price">2.280.000 ₫</span>
                <span class="original-price">2.850.000 ₫</span>
            </div>
            <div class="product-actions">
                <button class="add-to-cart" onclick="addToCart(1, 'Nike Air Zoom Pegasus 40', 2280000)">
                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                </button>
                <button class="quick-view-btn" onclick="quickView(1)">Chi tiết</button>
            </div>
        </div>
    </div>

    <!-- Sản phẩm 2 -->
    <div class="product-card">
        <div class="product-image">
            <span class="badge badge-hot">HOT</span>
            <img src="https://source.unsplash.com/600x600/?adidas,ultraboost" alt="Adidas Ultraboost">
            <button class="quick-view" onclick="quickView(2)">Xem nhanh</button>
        </div>
        <div class="product-info">
            <div class="brand">Adidas</div>
            <h3>Adidas Ultraboost 23</h3>
            <div class="rating">
                ★★★★★ <span>(89)</span>
            </div>
            <div class="price-container">
                <span class="current-price">3.290.000 ₫</span>
            </div>
            <div class="product-actions">
                <button class="add-to-cart" onclick="addToCart(2, 'Adidas Ultraboost 23', 3290000)">
                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                </button>
                <button class="quick-view-btn" onclick="quickView(2)">Chi tiết</button>
            </div>
        </div>
    </div>

    <!-- Thêm 3-4 sản phẩm tương tự nếu bạn muốn (tôi để 2 cái mẫu trước, bạn copy paste và chỉnh) -->
    <!-- Ví dụ sản phẩm 3 -->
    <div class="product-card">
        <div class="product-image">
            <span class="badge badge-new">NEW</span>
            <img src="https://source.unsplash.com/600x600/?sportshirt,nike" alt="Áo Dry-Fit">
            <button class="quick-view" onclick="quickView(3)">Xem nhanh</button>
        </div>
        <div class="product-info">
            <div class="brand">Nike</div>
            <h3>Áo Thun Dry-Fit Pro</h3>
            <div class="rating">
                ★★★★☆ <span>(56)</span>
            </div>
            <div class="price-container">
                <span class="current-price">450.000 ₫</span>
            </div>
            <div class="product-actions">
                <button class="add-to-cart" onclick="addToCart(3, 'Áo Thun Dry-Fit Pro', 450000)">
                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                </button>
                <button class="quick-view-btn" onclick="quickView(3)">Chi tiết</button>
            </div>
        </div>
    </div>


</div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-col">
                    <h3>SportStore</h3>
                    <p>Cửa hàng đồ thể thao uy tín hàng đầu Việt Nam</p>
                </div>
                <div class="footer-col">
                    <h4>Liên hệ</h4>
                    <p>Hotline: 0123 456 789</p>
                    <p>Email: support@sportstore.vn</p>
                    <p>Địa chỉ: 123 Nguyễn Văn Linh, Quận 7, TP.HCM</p>
                </div>
            </div>
            <div class="copyright">
                © 2026 SportStore. All rights reserved.
            </div>
        </div>
    </footer>

    <!-- Script -->
    <script src="js/script.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 1. Kiểm tra LocalStorage xem token có tồn tại không
            var token = localStorage.getItem('token');
            var authContainer = document.getElementById('auth-container');
            
            if (token) {
                // 2. Decode Payload JWT để lấy email hiển thị (Tùy chọn)
                var userEmail = "Tài Khoản";
                try {
                    var payload = JSON.parse(atob(token.split('.')[1]));
                    if(payload && payload.sub) {
                        userEmail = payload.sub; // .sub là chuẩn lưu trữ subject (thường dùng email) trong claim jwt
                    }
                } catch(e) {}
                
                // 3. User đã đăng nhập -> Chuyển icon thành "Đã đăng nhập" và thêm nút Đăng Xuất
                authContainer.innerHTML = `
                    <div style="display: inline-flex; align-items: center; gap: 10px;">
                        <a href="#" class="icon-link" title="`+userEmail+`">
                            <i class="fas fa-user-check" style="color: green;"></i>
                            <span style="font-size: 14px; margin-left: 5px;">` + userEmail.split('@')[0] + `</span>
                        </a>
                        <button onclick="logoutClient()" style="background: none; border: 1px solid #ff4757; color: #ff4757; padding: 4px 8px; cursor: pointer; border-radius: 4px; font-size: 13px;">Đăng xuất</button>
                    </div>
                `;
            } else {
                // Chưa đăng nhập -> Trả về giao diện Icon User chuyển hướng sang trang login
                authContainer.innerHTML = `<a href="/login" class="icon-link"><i class="fas fa-user"></i></a>`;
            }
        });

        // 4. Định nghĩa Hàm đăng xuất
        function logoutClient() {
            if(confirm("Bạn có chắc chắn muốn đăng xuất khỏi hệ thống?")) {
                localStorage.removeItem('token');  // Xóa token khỏi client localStorage
                window.location.href = '/api/auth/logout'; // Ép trình duyệt dọn dẹp Cookie HttpOnly
            }
        }
    </script>
</body>
</html>