-- Roles
INSERT INTO Roles (RoleName) VALUES ('Admin'),('Staff'),('Customer');

-- Accounts
INSERT INTO Accounts (AccountID, Email, PasswordHash, CreatedAt, IsActive, RoleID, EmailVerified, ProfileImageURL)
VALUES
(4, N'tanmnce182352@fpt.edu.vn', N'e10adc3949ba59abbe56e057f20f883e', '2025-06-12T10:30:39.293', 1, 1, 0, NULL),
(5, N'user1@example.com', N'E10ADC3949BA59ABBE56E057F20F883E', '2025-06-12T13:57:31.773', 1, 2, 0, NULL),
(6, N'user2@example.com', N'E10ADC3949BA59ABBE56E057F20F883E', '2025-06-12T13:57:31.773', 1, 2, 0, NULL);

-- Staff 
INSERT INTO Staff (StaffID, AccountID, FullName, PhoneNumber, BirthDate, Gender, Position, HiredDate)
VALUES
(1, 5, N'Nguyen Van Minh', N'0912345678', '1995-05-20', N'Male', N'IT Support', '2023-01-15'),
(2, 6, N'Tran Thi Lan', N'0987654321', '1998-08-10', N'Female', N'HR Manager', '2022-09-01');

-- Categories
INSERT INTO Categories (CategoryName, Description, ImgURLLogo) VALUES
('Phone', 'Mobile phones and smartphones', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNCzd8XHEQEMejkLb560ADY_9IGrldxg6nWg&s'),
('Laptop', 'Portable personal computers', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Nmgin512ZU5KsiS-hnC97bYEc6Mq-biHSg&s'),
('Watch', 'Wristwatches and smartwatches', 'https://static.vecteezy.com/system/resources/thumbnails/002/387/785/small/handwatch-icon-free-vector.jpg'),
('Accessories', 'Electronic accessories like keyboards, mice, etc.', 'https://png.pngtree.com/png-clipart/20220604/original/pngtree-headphone-icon-png-png-image_7930757.png');

-- Brands
INSERT INTO Brands (BrandName, Description, CategoryID, ImgURLLogo) VALUES
('Apple', 'High-end smartphones and devices', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZnl0smicihjEpIXL3HAI0KWl_CjfgOaPHYg&s'),
('Samsung', 'Innovative phones and electronics', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVcD6BUP0xnW08x7FdMF0NMQm0YwYPqdINFQ&s'),
('Vivo', 'Affordable smartphones with good cameras', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRvuqh5XKkE1gGrJlwK3OgW6BrW8U97SWSwQ&s'),
('Oppo', 'Smartphones with stylish design', 1, 'https://icons.veryicon.com/png/o/application/animaui/oppo-fill-round.png'),
('Asus', 'Gaming and productivity laptops', 2, 'https://cdn4.iconfinder.com/data/icons/flat-brand-logo-2/512/asus-512.png'),
('HP', 'Reliable business and personal laptops', 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/HP_logo_2012.svg/2048px-HP_logo_2012.svg.png'),
('Dell', 'High-performance business laptops', 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Dell_Logo.svg/1200px-Dell_Logo.svg.png'),
('Lenovo', 'Versatile laptops for all needs', 2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ9geCMoK8K_1E5T2ZOPUHrkW4eBvKjVZbNw&s'),
('Orient', 'Classic Japanese wristwatches', 3, 'https://cdn.worldvectorlogo.com/logos/orient-1.svg'),
('Citizen', 'Stylish and durable watches', 3, 'https://1000logos.net/wp-content/uploads/2023/07/Citizen-logo.jpg'),
('G-Shock', 'Shock-resistant digital watches', 3, 'https://cdn.worldvectorlogo.com/logos/g-shock-casio.svg'),
('Tissot', 'Swiss-made luxury watches', 3, 'https://images.seeklogo.com/logo-png/29/2/tissot-logo-png_seeklogo-298018.png'),
('Bose', 'Premium audio accessories', 4, 'https://cdn.iconscout.com/icon/free/png-256/free-bose-logo-icon-download-in-svg-png-gif-file-formats--brand-company-logos-icons-1580027.png?f=webp'),
('Corsair', 'Gaming accessories and peripherals', 4, 'https://cwsmgmt.corsair.com/press/CORSAIRLogo2020_stack_K.png'),
('Sennheiser', 'High-quality headphones and audio gear', 4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK_r95cM0gXNX33JMZJG9AD8igo813hwqjrQ&s'),
('SteelSeries', 'Professional gaming accessories', 4, 'https://upload.wikimedia.org/wikipedia/en/7/7f/Steelseries-logo.png');

INSERT INTO Suppliers (TaxID, Name, Email, PhoneNumber, Address, CreatedDate, LastModify, Deleted, Activate, ContactPerson, SupplyGroup, Description) VALUES
('942404110', 'Apple Vietnam', 'support@apple.com', '(408) 996-1010', '1 Apple Park Way, Cupertino, CA 95014, USA', GETDATE(), GETDATE(), 0, 1, 'John Carter', 'Phones', N'High‑end smartphones and devices'),
('132951153', 'Samsung Vietnam', 'support@samsung.com', '(888) 480-5675', '85 Challenger Rd, Ridgefield Park, NJ, USA', GETDATE(), GETDATE(), 0, 1, 'Kim Minho', 'Phones', N'Innovative phones and electronics'),
('203075737', 'Vivo Vietnam', 'global@vivo.com', '650-688-0818', 'Dongguan, China', GETDATE(), GETDATE(), 0, 1, 'Nguyen Hoang Dung', 'Phones', N'Affordable smartphones with good cameras'),
('945607443', 'Oppo Vietnam', 'support@oppo.com', '1-800-103-7733', 'Dongguan, China', GETDATE(), GETDATE(), 0, 1, 'Pham Quynh Trang', 'Phones', N'Smartphones with stylish design'),
('770378476', 'Asus Vietnam', 'support@asus.com', '(510) 608-4508', 'Taipei, Taiwan', GETDATE(), GETDATE(), 0, 1, 'Ly Thanh Nhan', 'Laptops', N'Gaming and productivity laptops'),
('0300539709', 'HP Vietnam', 'support@hp.com', '+1 650-857-1501', 'Palo Alto, California, USA', GETDATE(), GETDATE(), 0, 1, 'Jessica Hill', 'Laptops', N'Reliable business and personal laptops'),
('800890963', 'Dell Vietnam', 'support@dell.com', '800-289-3355', 'Round Rock, Texas, USA', GETDATE(), GETDATE(), 0, 1, 'Michael Dell', 'Laptops', N'High‑performance business laptops'),
('522449153', 'Lenovo Vietnam', 'support@lenovo.com', '(919) 237-8600', 'Beijing, China', GETDATE(), GETDATE(), 0, 1, 'Tran Van Phuc', 'Laptops', N'Versatile laptops for all needs'),
('010512072', 'Orient Vietnam', 'info@orient-watch.com', '+81-3-5334-4111', 'Tokyo, Japan', GETDATE(), GETDATE(), 0, 1, 'Haruki Yamamoto', 'Watches', N'Classic Japanese wristwatches'),
('118643745', 'Citizen Vietnam', 'contact@citizenwatch.com', '(212) 497-9732', 'Tokyo, Japan', GETDATE(), GETDATE(), 0, 1, 'Nguyen Thi Mai', 'Watches', N'Stylish and durable watches'),
('112215214', 'Casio Vietnam', 'support@gshock.com', '800-706-2534', 'Tokyo, Japan', GETDATE(), GETDATE(), 0, 1, 'Watanabe Kenji', 'Watches', N'Shock‑resistant digital watches'),
('112322310', 'Tissot Vietnam', 'info@tissotwatches.com', '(866) 462-0050', 'Le Locle, Switzerland', GETDATE(), GETDATE(), 0, 1, 'Emile Morel', 'Watches', N'Swiss‑made luxury watches'),
('042655386', 'Bose Vietnam', 'support@bose.com', '508-766-7000', 'Framingham, Massachusetts, USA', GETDATE(), GETDATE(), 0, 1, 'David Barnes', 'Accessories', N'Premium audio accessories'),
('770362371', 'Corsair Vietnam', 'support@corsair.com', '888-222-4346', 'Fremont, California, USA', GETDATE(), GETDATE(), 0, 1, 'Ngo Thi Linh', 'Accessories', N'Gaming accessories and peripherals'),
('131988840', 'Sennheiser Vietnam', 'info@sennheiser.com', '860-434-9190', 'Wedemark, Germany', GETDATE(), GETDATE(), 0, 1, 'Le Minh Tam', 'Accessories', N'High‑quality headphones and audio gear'),
('771299321', 'SteelSeries Vietnam', 'contact@steelseries.com', '0904000004', 'Copenhagen, Denmark', GETDATE(), GETDATE(), 0, 1, 'Frederik Andersen', 'Accessories', N'Professional gaming accessories');


-- Products
INSERT INTO Products (ProductName, Description, Price, Discount, Stock, Status, SupplierID, CategoryID, BrandID, IsNew, IsFeatured, IsBestSeller, WarrantyPeriod)
VALUES
('iPhone 15 Pro Max', 'Apple flagship 2024 smartphone', 32990000, 0, 50, 'In stock', 1, 1, 1, 1, 1, 1, 12),
('iPhone 14 Pro', 'ProMotion display, Dynamic Island, powerful A16 chip', 27990000, 5, 30, 'In stock', 1, 1, 1, 0, 1, 1, 12),
('iPhone 13', 'Dual camera, A15 Bionic chip, reliable battery', 18990000, 7, 24, 'In stock', 1, 1, 1, 0, 0, 0, 12),
('iPhone 15', 'A16 Bionic chip, advanced camera, modern design', 24990000, 0, 20, 'In stock', 1, 1, 1, 1, 1, 0, 12),
('Samsung Galaxy S23', 'Snapdragon 8 Gen 2, 120Hz AMOLED, premium design', 20990000, 3, 40, 'In stock', 2, 1, 2, 1, 1, 1, 12),
('Samsung Galaxy Z Fold5', 'Large foldable display, multitasking, 4400mAh battery', 35990000, 2, 20, 'In stock', 2, 1, 2, 0, 1, 1, 12),
('Samsung Galaxy A54', '50MP main camera, 5000mAh battery, 120Hz AMOLED', 11990000, 0, 18, 'In stock', 2, 1, 2, 1, 0, 0, 12),
('Samsung Galaxy A74', 'Quad camera, Snapdragon chip, 5000mAh battery', 13990000, 2, 16, 'In stock', 2, 1, 2, 1, 1, 0, 12),
('HP Pavilion 15', 'Business laptop, Intel i5 12th Gen, 16GB RAM', 15500000, 10, 10, 'In stock', 6, 2, 6, 1, 0, 0, 24),
('Dell XPS 13', 'Ultra-thin, 13" FHD display, Intel i7', 23500000, 8, 6, 'In stock', 7, 2, 7, 1, 1, 1, 24),
('Orient Sun&Moon', 'Elegant automatic wristwatch', 7000000, 0, 12, 'In stock', 9, 3, 9, 0, 0, 1, 24),
('Corsair K95 RGB Keyboard', 'Mechanical gaming keyboard, RGB lighting', 3500000, 5, 30, 'In stock', 14, 4, 14, 1, 1, 0, 12),
('SteelSeries Mouse', 'High precision gaming mouse, 16000 DPI', 1200000, 4, 24, 'In stock', 16, 4, 16, 1, 0, 0, 12);

-- ProductImages
INSERT INTO ProductImages (ProductID, ImageURL, AltText) VALUES
(1, 'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-600x600.jpg', 'iPhone 15 Pro Max product image'),
(2, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_m_13_1_2_2_1.png', 'iPhone 14 Pro product image'),
(5, 'https://cdn.xtmobile.vn/vnt_upload/product/10_2023/thumbs/(600x600)_crop_samsung-galaxy-s23-fe-xtmobile.png', 'Samsung Galaxy S23 product image'),
(9, 'https://cdn.tgdd.vn/Products/Images/44/249334/hp-pavilion-15-eg2035tx-i5-7c0q2pa-600x600.jpg', 'HP Pavilion 15 laptop image'),
(11, 'https://cdn.tgdd.vn/Products/Images/7264/247463/orient-sun-and-moon-fak00006b0-2-600x600.jpg', 'Orient Sun&Moon watch image');

-- ImportStocks (phiếu nhập hàng)
INSERT INTO ImportStocks (SupplierID, AccountID, StaffID, ImportDate, TotalAmount, IsCompleted) VALUES
(1, 5, 1, '2025-06-23', 43000000, 1),
(2, 5, 1, '2025-06-23', 57500000, 1),
(2, 8, 5,'2025-06-22', 24000000, 1),    
(2, 9, 5,'2025-06-10', 15000000, 1 ),    
(2, 10, 3,'2025-06-1', 25000000, 1);

-- ImportStockDetails (chi tiết nhập hàng)
INSERT INTO ImportStockDetails (ImportID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 5, 33000000),
(1, 2, 3, 28000000),
(1, 3, 4, 22000000),
(2, 5, 6, 26000000),
(2, 6, 2, 21000000),
(2, 7, 10, 11500000);


INSERT INTO ShippingAddresses (AccountID, RecipientName, Phone, AddressLine, Ward, District, City, PostalCode, IsDefault) VALUES
(5, N'Le Thi Hoa', '0923456789', N'45 Tran Hung Dao', N'Phu Hoi', N'Hue City', N'Thue Thien Hue', '530000', 1),
(6, N'Tran Minh Tuan', '0934567890', N'123 Nguyen Trai', N'Lam Son', N'Thanh Hoa', N'Thanh Hoa', '440000', 1);


-- CategoryDetailsGroup
INSERT INTO CategoryDetailsGroup (NameCategoryDetailsGroup, CategoryID) VALUES
('Configuration & Memory', 1),
('Camera & Display', 1),
('Battery & Charging', 1),
('Utilities', 1),
('Connectivity', 1),
('Design & Materials', 1);

-- CategoryDetails
INSERT INTO CategoryDetails (CategoryID, AttributeName, CategoryDetailsGroupID) VALUES
(1, 'Operating System', 1),
(1, 'Processor (CPU)', 1),
(1, 'Processor Speed', 1),
(1, 'Graphics Processing Unit (GPU)', 1),
(1, 'RAM', 1),
(1, 'Storage Capacity', 1),
(1, 'Available Storage', 1),
(1, 'Contacts', 1),

(1, 'Rear Camera Resolution', 2),
(1, 'Rear Camera Video Recording', 2),
(1, 'Rear Camera Flash', 2),
(1, 'Rear Camera Features', 2),
(1, 'Front Camera Resolution', 2),
(1, 'Front Camera Features', 2),
(1, 'Display Technology', 2),
(1, 'Screen Resolution', 2),
(1, 'Wide Display', 2),
(1, 'Peak Brightness', 2),
(1, 'Touchscreen Glass', 2),

(1, 'Battery Capacity', 3),
(1, 'Battery Type', 3),
(1, 'Maximum Charging Support', 3),
(1, 'Battery Technology', 3),

(1, 'Advanced Security', 4),
(1, 'Special Features', 4),
(1, 'Water and Dust Resistance', 4),
(1, 'Voice Recording', 4),
(1, 'Video Playback', 4),
(1, 'Music Playback', 4),

(1, 'Mobile Network', 5),
(1, 'SIM', 5),
(1, 'Wifi', 5),
(1, 'GPS', 5),
(1, 'Bluetooth', 5),
(1, 'Charging/Connectivity Port', 5),
(1, 'Headphone Jack', 5),

(1, 'Design', 6),
(1, 'Material', 6),
(1, 'Dimensions & Weight', 6),
(1, 'Release Date', 6),
(1, 'Brand', 6);
