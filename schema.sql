USE sport;
-- ALTER TABLE category MODIFY created_at DATETIME(0);
-- ALTER TABLE category MODIFY updated_at DATETIME(0);
-- ALTER TABLE category MODIFY created_by_id BIGINT NULL;
-- ALTER TABLE category MODIFY updated_by_id BIGINT NULL;
-- ALTER TABLE permission ADD name VARCHAR(255);

INSERT INTO permission (code, name) VALUES ('USER_READ', 'Xem user');
INSERT INTO permission (code, name) VALUES ('USER_CREATE', 'Thêm user');
INSERT INTO permission (code, name) VALUES ('USER_UPDATE', 'Sửa user');
INSERT INTO permission (code, name) VALUES ('USER_DELETE', 'Xoá user');

INSERT INTO permission (code, name) VALUES ('ROLE_READ', 'Xem role');
INSERT INTO permission (code, name) VALUES ('ROLE_CREATE', 'Thêm role');
INSERT INTO permission (code, name) VALUES ('ROLE_UPDATE', 'Sửa role');
INSERT INTO permission (code, name) VALUES ('ROLE_DELETE', 'Xoá role');

INSERT INTO permission (code, name) VALUES ('PRODUCT_READ', 'Xem sản phẩm');
INSERT INTO permission (code, name) VALUES ('PRODUCT_CREATE', 'Thêm sản phẩm');
INSERT INTO permission (code, name) VALUES ('PRODUCT_UPDATE', 'Sửa sản phẩm');
INSERT INTO permission (code, name) VALUES ('PRODUCT_DELETE', 'Xoá sản phẩm');

INSERT INTO permission (code, name) VALUES ('ORDER_READ', 'Xem đơn hàng');
INSERT INTO permission (code, name) VALUES ('ORDER_UPDATE', 'Cập nhật đơn hàng');