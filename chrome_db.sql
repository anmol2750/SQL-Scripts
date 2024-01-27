CREATE DATABASE IF NOT EXISTS chrome;

SHOW DATABASES;

USE chrome;

-- begin::role--
CREATE TABLE role (
	role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    is_deleted BOOLEAN NOT NULL DEFAULT 0, 
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::role--
-- begin::permission--
CREATE TABLE permission (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    permission_name VARCHAR(50) NOT NULL UNIQUE,
    is_deleted BOOLEAN NOT NULL DEFAULT 0, 
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::permission--
-- begin::role permission--
CREATE TABLE role_permission (
    role_permission_id INT AUTO_INCREMENT PRIMARY KEY,
    role_ref_id INT,
    permission_ref_id INT,
    is_deleted BOOLEAN NOT NULL DEFAULT 0, 
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_ref_id) REFERENCES role(role_id),
    FOREIGN KEY (permission_ref_id) REFERENCES permission(permission_id)
);
-- end::role permission--
-- begin::user--
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    company_name VARCHAR(100),
    email VARCHAR(50),
    password VARCHAR(50),
    is_deleted BOOLEAN NOT NULL DEFAULT 0,
    role_ref_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_ref_id) REFERENCES role(role_id)
);
-- end::user--
-- begin::contact number--
CREATE TABLE contact_number (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    contact_number VARCHAR(20) NOT NULL UNIQUE,
    user_ref_id INT,
    vendor_ref_id INT,
    is_deleted BOOLEAN NOT NULL DEFAULT 0,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_ref_id) REFERENCES user(user_id),
    FOREIGN KEY (vendor_ref_id) REFERENCES vendor(vendor_id)
);
-- end::contact number--
-- begin::address--
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(100),
    location VARCHAR(100),
	country_ref_id INT,
    state_ref_id INT,
    city_ref_id INT,
    user_ref_id INT,
    vendor_ref_id INT,
    is_deleted BOOLEAN NOT NULL DEFAULT 0,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_ref_id) REFERENCES user(user_id),
	FOREIGN KEY (vendor_ref_id) REFERENCES vendor(vendor_id),
	FOREIGN KEY (country_ref_id) REFERENCES country(country_id),
    FOREIGN KEY (state_ref_id) REFERENCES state(state_id),
    FOREIGN KEY (city_ref_id) REFERENCES city(city_id)
);
-- end::address--
-- begin::country--
CREATE TABLE country (
	country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(40) NOT NULL UNIQUE,
    is_deleted Boolean NOT NULL DEFAULT 0,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::country--
-- begin::state--
CREATE TABLE state (
	state_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(30) NOT NULL UNIQUE,
    country_ref_id INT,
    is_deleted Boolean NOT NULL DEFAULT 0,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (country_ref_id) REFERENCES country(country_id)
);
-- end::state--
-- begin::city--
CREATE TABLE city (
	city_id INT AUTO_INCREMENT PRIMARY KEY,
	city_name VARCHAR(30) NOT NULL UNIQUE,
    post_code INT NOT NULL UNIQUE,
    state_ref_id INT,
    is_deleted Boolean NOT NULL DEFAULT 0,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (state_ref_id) REFERENCES state(state_id)
);
-- end::city--
-- begin::vendor--
CREATE TABLE vendor (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    company_site VARCHAR(50),
    bussiness_ref_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (bussiness_ref_id) REFERENCES type_of_bussiness(bussiness_id)
); 
-- end::vendor--

ALTER TABLE vendor
DROP COLUMN brand_name;

ALTER TABLE vendor
ADD COLUMN company_name VARCHAR(50) NOT NULL;

-- begin::type of business--
CREATE TABLE type_of_bussiness (
	bussiness_id INT AUTO_INCREMENT PRIMARY KEY,
    bussiness_type VARCHAR(30),
	is_deleted Boolean NOT NULL DEFAULT 0,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::type of business--
-- begin::category--
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT 0,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::category--
-- begin::vendor category--
CREATE TABLE vendor_category(
	vendor_category_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_ref_id INT,
    category_ref_id INT,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(vendor_ref_id) REFERENCES vendor(vendor_id),
    FOREIGN KEY(category_ref_id) REFERENCES category(category_id)
);
-- end::vendor category--
-- begin::product--
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    brand_name VARCHAR(50) NOT NULL,
    description VARCHAR(250),
    is_deleted BOOLEAN NOT NULL DEFAULT 0,
	category_ref_id INT,
    price_ref_id INT,
    color_ref_id INT,
    size_ref_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(category_ref_id) REFERENCES category(category_id),
    FOREIGN KEY(price_ref_id) REFERENCES price(price_id),
    FOREIGN KEY(color_ref_id) REFERENCES color(color_id),
    FOREIGN KEY(size_ref_id) REFERENCES size(size_id)
);
-- end::product--

ALTER TABLE product
DROP COLUMN brand_name;

-- begin::brand name--
CREATE TABLE brand (
	brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(50) NOT NULL UNIQUE,
    is_deleted BOOLEAN NOT NULL DEFAULT 0,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::brand name--
-- begin::price--
CREATE TABLE price (
	price_id INT AUTO_INCREMENT PRIMARY KEY,
    price DECIMAL(10, 2) NOT NULL ,
	is_deleted BOOLEAN NOT NULL DEFAULT 0,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::price--
-- begin::size--
CREATE TABLE size (
	size_id INT AUTO_INCREMENT PRIMARY KEY,
    size VARCHAR(10),
	is_deleted BOOLEAN NOT NULL DEFAULT 0,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::size--
-- begin::color--
CREATE TABLE color (
	color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(20) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT 0,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::color--
-- begin::image--
CREATE TABLE image (
	image_id INT AUTO_INCREMENT PRIMARY KEY,
	image_url VARCHAR(255),
	image_type_ref_id INT,
    entity_id INT,
	is_deleted BOOLEAN NOT NULL DEFAULT 0,
	Uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (entity_id) REFERENCES product(product_id),
    FOREIGN KEY (entity_id) REFERENCES vendor(vendor_id),
    FOREIGN KEY (entity_id) REFERENCES user(user_id),
    FOREIGN KEY (image_type_ref_id) REFERENCES image_type(image_type_id)
);
-- end::image--
-- begin::image type--
CREATE TABLE image_type (
	image_type_id INT AUTO_INCREMENT PRIMARY KEY,
    image_type_name VARCHAR(30) NOT NULL UNIQUE,
    is_deleted BOOLEAN NOT NULL DEFAULT 0,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- end::image type--
-- begin::product vendor--
CREATE TABLE product_vendor (
	product_vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    product_ref_id INT NOT NULL,
    vendor_ref_id INT NOT NULL,
	created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_ref_id) REFERENCES product(product_id),
    FOREIGN KEY (vendor_ref_id) REFERENCES vendor(vendor_id)
);
-- end::product vendor--

    







