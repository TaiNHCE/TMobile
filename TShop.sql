CREATE DATABASE TShop
GO
USE TShop
GO

-- Roles: Quản lý các vai trò người dùng trong hệ thống (Admin, Customer, Staff,...)
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY IDENTITY,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    RoleID INT NOT NULL FOREIGN KEY REFERENCES Roles(RoleID),
    EmailVerified BIT DEFAULT 0,
    ProfileImageURL NVARCHAR(500)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,  -- Trùng với AccountID
    AccountID INT UNIQUE FOREIGN KEY REFERENCES Accounts(AccountID),
    FullName NVARCHAR(100),
    PhoneNumber NVARCHAR(15),
    BirthDate DATE,
    Gender NVARCHAR(10)
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,  -- Trùng với AccountID
    AccountID INT UNIQUE FOREIGN KEY REFERENCES Accounts(AccountID),
    FullName NVARCHAR(100),
    PhoneNumber NVARCHAR(15),
    BirthDate DATE,
    Gender NVARCHAR(10),
    Position NVARCHAR(100),
    HiredDate DATE
);

CREATE TABLE Admins (
    AdminID INT PRIMARY KEY,  -- Trùng với AccountID
    AccountID INT UNIQUE FOREIGN KEY REFERENCES Accounts(AccountID),
    FullName NVARCHAR(100),
    PhoneNumber NVARCHAR(15),
    BirthDate DATE,
    Gender NVARCHAR(10),
    Level INT DEFAULT 1
);

-- Categories: Quản lý các nhóm sản phẩm (điện thoại, máy tính,...)
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
	CreatedAt DATETIME DEFAULT GETDATE(),
	ImgURLLogo NVARCHAR(500),
	isActive BIT default 1
);

-- Nhóm thuộc tính (ví dụ: Thiết kế, Cấu hình, Tính năng, Xuất xứ, v.v.)
CREATE TABLE CategoryDetailsGroup(
	CategoryDetailsGroupID int PRIMARY KEY IDENTITY,
	NameCategoryDetailsGroup NVARCHAR(500) NOT NULL,
	CategoryID INT NOT NULL FOREIGN KEY REFERENCES Categories(CategoryID) ON DELETE CASCADE
)

insert into CategoryDetailsGroup(NameCategoryDetailsGroup, CategoryID)
values
      ('Configuration & Memory', 1),
	  ('Camera & Display', 1),
	  ('Battery & Charging', 1),
	  ('Utilities', 1),
	  ('Connectivity', 1),
	  ('Design & Materials', 1)

-- CategoryDetails: Các thuộc tính chi tiết thuộc về từng danh mục (ví dụ: RAM, Kích thước, Chất liệu)
CREATE TABLE CategoryDetails (
    CategoryDetailID INT PRIMARY KEY IDENTITY,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID) ON DELETE NO ACTION,
    AttributeName NVARCHAR(100) NOT NULL  ,
	CategoryDetailsGroupID INT FOREIGN KEY REFERENCES CategoryDetailsGroup(CategoryDetailsGroupID) ON DELETE CASCADE,
);

insert into CategoryDetails(CategoryID, AttributeName, CategoryDetailsGroupID)
values (1, 'Operating System', 1),
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
	   (1, 'Brand', 6)

-- Brands: Thông tin các thương hiệu sản phẩm
CREATE TABLE Brands (
    BrandID INT PRIMARY KEY IDENTITY,
    BrandName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
	ImgURLLogo NVARCHAR(500),
	isActive BIT default 1
);

-- Suppliers: Thông tin nhà cung cấp sản phẩm
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY,
    TaxID NVARCHAR(20) NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255),
    PhoneNumber NVARCHAR(50),
    Address NVARCHAR(500),
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastModify DATETIME,
    Deleted BIT DEFAULT 0,
    Activate BIT DEFAULT 1
);


-- Products: Thông tin sản phẩm chính, gồm tên, mô tả, giá, kho, trạng thái,...
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY,
    ProductName NVARCHAR(100),
    Description NVARCHAR(MAX),
    Price DECIMAL(10, 2),
    Discount INT,
    Stock INT,
    Status NVARCHAR(100),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID) ON DELETE SET NULL,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID) ON DELETE SET NULL,
    BrandID INT FOREIGN KEY REFERENCES Brands(BrandID) ON DELETE SET NULL,
    IsFeatured BIT,
    IsBestSeller BIT,
	IsNew BIT,
    CreatedAt DATETIME DEFAULT GETDATE(),
	UpdateAt DATETIME DEFAULT GETDATE(),
	--thời gian bảo hành
    WarrantyPeriod INT,
	isActive BIT default 1
);

-- ProductImages: Hình ảnh sản phẩm
CREATE TABLE ProductImages (
    ImageID INT PRIMARY KEY IDENTITY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    ImageURL NVARCHAR(500),
    AltText NVARCHAR(255)
);

-- ProductDetails: Lưu giá trị thuộc tính cụ thể của sản phẩm theo từng thuộc tính danh mục (ví dụ: RAM = 8GB)
CREATE TABLE ProductDetails (
    ProductDetailID INT PRIMARY KEY IDENTITY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    CategoryDetailID INT FOREIGN KEY REFERENCES CategoryDetails(CategoryDetailID) ON DELETE CASCADE,
    AttributeValue NVARCHAR(255)  
);

CREATE TABLE ImgProductDetails(
	ImageURL1 NVARCHAR(500),
	ImageURL2 NVARCHAR(500),
	ImageURL3 NVARCHAR(500),
	ImageURL4 NVARCHAR(500)
	ProductDetailID INT FOREIGN KEY REFERENCES ImgProductDetails(ProductDetailID) ON DELETE CASCADE
)

-- ProductVariants: Các biến thể sản phẩm theo màu sắc, kích thước,... với số lượng và giá riêng
CREATE TABLE ProductVariants (
    VariantID INT PRIMARY KEY IDENTITY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    Color NVARCHAR(50),
    Storage NVARCHAR(50),           -- Thêm nếu có nhiều biến thể như 128GB, 256GB
    Quantity INT,
    Price DECIMAL(10,2),
    Discount INT DEFAULT 0,         -- Phần trăm giảm giá (0–100)
    SKU NVARCHAR(50) UNIQUE,
    ImageURL NVARCHAR(500),         -- Ảnh riêng cho biến thể
    IsActive BIT DEFAULT 1          -- Có đang hiển thị hay không
);


-- Inventory: Quản lý tồn kho sản phẩm và biến thể, cập nhật số lượng mới nhất
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    VariantID INT NULL FOREIGN KEY REFERENCES ProductVariants(VariantID) ON DELETE NO ACTION,
    Quantity INT,
    LastUpdated DATETIME DEFAULT GETDATE()
);

-- Feedbacks: Đánh giá sản phẩm từ người dùng, gồm điểm đánh giá và bình luận
CREATE TABLE Feedbacks (
    FeedbackID INT PRIMARY KEY IDENTITY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE CASCADE,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsVisible BIT DEFAULT 1
);

-- FeedbackReplies: Phản hồi bình luận từ nhân viên hoặc admin trên đánh giá sản phẩm
CREATE TABLE FeedbackReplies (
    ReplyID INT PRIMARY KEY IDENTITY,
    FeedbackID INT FOREIGN KEY REFERENCES Feedbacks(FeedbackID) ON DELETE CASCADE,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE NO ACTION,
    ReplyContent NVARCHAR(MAX),
    RepliedAt DATETIME DEFAULT GETDATE(),
    IsPublic BIT DEFAULT 1
);

-- Cart: Giỏ hàng của người dùng, mỗi người dùng có một giỏ hàng duy nhất
CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY,
    AccountID INT UNIQUE FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE CASCADE,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- CartItems: Các mặt hàng trong giỏ hàng, có thể kèm biến thể sản phẩm
CREATE TABLE CartItems (
    CartItemID INT PRIMARY KEY IDENTITY,
    CartID INT FOREIGN KEY REFERENCES Cart(CartID) ON DELETE CASCADE,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE NO ACTION,
    VariantID INT NULL FOREIGN KEY REFERENCES ProductVariants(VariantID) ON DELETE NO ACTION,
    Quantity INT,
    AddedAt DATETIME DEFAULT GETDATE()
);

-- ProductViewHistory: Lịch sử xem sản phẩm của người dùng, phục vụ phân tích hành vi
CREATE TABLE ProductViewHistory (
    ViewID INT PRIMARY KEY IDENTITY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE NO ACTION,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    ViewTime DATETIME DEFAULT GETDATE()
);

-- ShippingAddresses: Địa chỉ giao hàng của người dùng, có thể có nhiều địa chỉ, đánh dấu mặc định
CREATE TABLE ShippingAddresses (
    AddressID INT PRIMARY KEY IDENTITY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE CASCADE,
    RecipientName NVARCHAR(100),
    Phone NVARCHAR(15),
    AddressLine NVARCHAR(255),
    Ward NVARCHAR(100),
    District NVARCHAR(100),
    City NVARCHAR(100),
    PostalCode NVARCHAR(10),
    IsDefault BIT DEFAULT 0
);

-- Vouchers: Mã giảm giá, gồm mã, phần trăm giảm, ngày hết hạn
CREATE TABLE Vouchers (
    VoucherID INT PRIMARY KEY IDENTITY,
    Code NVARCHAR(50) UNIQUE NOT NULL,
    DiscountPercent INT,
    ExpiryDate DATETIME,
    MinOrderAmount DECIMAL(10,2),
    MaxDiscountAmount DECIMAL(10,2),
    UsageLimit INT,
    UsedCount INT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- OrderStatus: Trạng thái đơn hàng (Pending, Processing, Shipped, Delivered, Cancelled)
CREATE TABLE OrderStatus (
    StatusID INT PRIMARY KEY IDENTITY,
    StatusName NVARCHAR(50) NOT NULL 
);

-- Orders: Thông tin đơn hàng người dùng, trạng thái, địa chỉ giao hàng, mã giảm giá
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE NO ACTION,
    OrderDate DATETIME DEFAULT GETDATE(),
    StatusID INT FOREIGN KEY REFERENCES OrderStatus(StatusID),
    ShippingAddressID INT FOREIGN KEY REFERENCES ShippingAddresses(AddressID),
    VoucherID INT NULL FOREIGN KEY REFERENCES Vouchers(VoucherID),
    TotalAmount DECIMAL(12,2),
    ShippingFee DECIMAL(10,2),
    DiscountAmount DECIMAL(10,2),
    OrderNotes NVARCHAR(MAX),
    EstimatedDeliveryDate DATETIME
);

-- OrderItems: Chi tiết các sản phẩm trong đơn hàng, có thể có biến thể, số lượng, giá bán
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID) ON DELETE CASCADE,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE NO ACTION,
    VariantID INT NULL FOREIGN KEY REFERENCES ProductVariants(VariantID) ON DELETE NO ACTION,
    Quantity INT,
    UnitPrice DECIMAL(10,2)
);

-- Payments: Thông tin thanh toán cho đơn hàng, phương thức, trạng thái và ngày thanh toán
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID) ON DELETE CASCADE,
    PaymentMethod NVARCHAR(50),
    PaymentStatus NVARCHAR(50),
    PaidDate DATETIME,
    Amount DECIMAL(12,2)
);

-- PurchaseOrders: Quản lý đơn hàng nhập hàng từ nhà cung cấp (staff tạo đơn nhập)
CREATE TABLE PurchaseOrders (
    PurchaseOrderID INT PRIMARY KEY IDENTITY,
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID),
    OrderDate DATETIME DEFAULT GETDATE(),
    ExpectedDeliveryDate DATETIME,
    Status NVARCHAR(50),
    Notes NVARCHAR(MAX),
    TotalAmount DECIMAL(12,2)
);

-- PurchaseOrderDetails: Chi tiết sản phẩm trong đơn hàng nhập, số lượng và giá nhập
CREATE TABLE PurchaseOrderDetails (
    DetailID INT PRIMARY KEY IDENTITY,
    PurchaseOrderID INT FOREIGN KEY REFERENCES PurchaseOrders(PurchaseOrderID) ON DELETE CASCADE,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE NO ACTION,
    Quantity INT,
    UnitPrice DECIMAL(10,2)
);

-- Notifications: Thông báo cho người dùng (reply feedback, order updates, etc.)
CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY IDENTITY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE NO ACTION,
    Title NVARCHAR(255),
    Message NVARCHAR(MAX),
    Type NVARCHAR(50),
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    RelatedEntityID INT NULL,
    RelatedEntityType NVARCHAR(50) NULL
);

-- Activity Logs: Ghi log hoạt động của staff/admin
CREATE TABLE ActivityLogs (
    LogID INT PRIMARY KEY IDENTITY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE NO ACTION,
    Action NVARCHAR(255),
    EntityType NVARCHAR(50),
    EntityID INT,
    Details NVARCHAR(MAX),
    IPAddress NVARCHAR(45),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Indexes for better performance
-- Sản phẩm
CREATE INDEX IX_Products_CategoryID ON Products(CategoryID);
CREATE INDEX IX_Products_BrandID ON Products(BrandID);
CREATE INDEX IX_Products_Status ON Products(Status);
CREATE INDEX IX_Products_IsFeatured ON Products(IsFeatured);
CREATE INDEX IX_Products_IsBestSeller ON Products(IsBestSeller);

-- Đơn hàng
CREATE INDEX IX_Orders_AccountID ON Orders(AccountID);
CREATE INDEX IX_Orders_StatusID ON Orders(StatusID);
CREATE INDEX IX_Orders_OrderDate ON Orders(OrderDate);

-- Đánh giá sản phẩm
CREATE INDEX IX_Feedbacks_ProductID ON Feedbacks(ProductID);
CREATE INDEX IX_Feedbacks_AccountID ON Feedbacks(AccountID);

-- Lịch sử xem sản phẩm
CREATE INDEX IX_ProductViewHistory_AccountID ON ProductViewHistory(AccountID); 
CREATE INDEX IX_ProductViewHistory_ProductID ON ProductViewHistory(ProductID);

-- Thông báo
CREATE INDEX IX_Notifications_AccountID ON Notifications(AccountID); 
CREATE INDEX IX_Notifications_IsRead ON Notifications(IsRead);

-- ** INSERT DỮ LIỆU **--
-- Insert default data
INSERT INTO Roles (RoleName) VALUES 
('Admin'),
('Staff'),
('Customer');

--Insert data Categories table
INSERT INTO Categories(CategoryName, Description, ImgURLLogo)
VALUES 
    ('Phone', 'Mobile phones and smartphones', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNCzd8XHEQEMejkLb560ADY_9IGrldxg6nWg&s'),
    ('Laptop', 'Portable personal computers', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Nmgin512ZU5KsiS-hnC97bYEc6Mq-biHSg&s'),
    ('Watch', 'Wristwatches and smartwatches', 'https://static.vecteezy.com/system/resources/thumbnails/002/387/785/small/handwatch-icon-free-vector.jpg'),
    ('Accessories', 'Electronic accessories like keyboards, mice, etc.', 'https://png.pngtree.com/png-clipart/20220604/original/pngtree-headphone-icon-png-png-image_7930757.png');

-- Insert data Brand table
INSERT INTO Brands(BrandName, Description, CategoryID, ImgURLLogo)
VALUES 
    -- Phone
    ('Apple', 'High-end smartphones and devices', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZnl0smicihjEpIXL3HAI0KWl_CjfgOaPHYg&s'),
    ('Samsung', 'Innovative phones and electronics', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVcD6BUP0xnW08x7FdMF0NMQm0YwYPqdINFQ&s'),
    ('Vivo', 'Affordable smartphones with good cameras', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRvuqh5XKkE1gGrJlwK3OgW6BrW8U97SWSwQ&s'),
    ('Oppo', 'Smartphones with stylish design', 1, 'https://icons.veryicon.com/png/o/application/animaui/oppo-fill-round.png'),

    -- Laptop
    ('Asus', 'Gaming and productivity laptops', 2, 'https://cdn4.iconfinder.com/data/icons/flat-brand-logo-2/512/asus-512.png'),
    ('HP', 'Reliable business and personal laptops', 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/HP_logo_2012.svg/2048px-HP_logo_2012.svg.png'),
    ('Dell', 'High-performance business laptops', 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Dell_Logo.svg/1200px-Dell_Logo.svg.png'),
    ('Lenovo', 'Versatile laptops for all needs', 2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ9geCMoK8K_1E5T2ZOPUHrkW4eBvKjVZbNw&s'),

    -- Watch
    ('Orient', 'Classic Japanese wristwatches', 3, 'https://cdn.worldvectorlogo.com/logos/orient-1.svg'),
    ('Citizent', 'Stylish and durable watches', 3, 'https://1000logos.net/wp-content/uploads/2023/07/Citizen-logo.jpg'),
    ('G-Shock', 'Shock-resistant digital watches', 3, 'https://cdn.worldvectorlogo.com/logos/g-shock-casio.svg'),
    ('Tissot', 'Swiss-made luxury watches', 3, 'https://images.seeklogo.com/logo-png/29/2/tissot-logo-png_seeklogo-298018.png'),

    -- Accessories
    ('Bose', 'Premium audio accessories', 4, 'https://cdn.iconscout.com/icon/free/png-256/free-bose-logo-icon-download-in-svg-png-gif-file-formats--brand-company-logos-icons-1580027.png?f=webp'),
    ('Corsair', 'Gaming accessories and peripherals', 4, 'https://cwsmgmt.corsair.com/press/CORSAIRLogo2020_stack_K.png'),
    ('Sennheiser', 'High-quality headphones and audio gear', 4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK_r95cM0gXNX33JMZJG9AD8igo813hwqjrQ&s'),
    ('SteelSeries', 'Professional gaming accessories', 4, 'https://upload.wikimedia.org/wikipedia/en/7/7f/Steelseries-logo.png');

-- Insert data Suppliers table
INSERT INTO Suppliers (TaxID, Name, Email, PhoneNumber, Address, CreatedDate, LastModify, Deleted, Activate)
VALUES 
('0101234567', 'Apple Inc.', 'contact@apple.com', '028-12345678', '1 Infinite Loop, Cupertino, CA',
 '2022-01-01 09:00:00.000', NULL, 0, 1),

('0102345678', 'Samsung Electronics', 'support@samsung.com', '028-23456789', 'Samsung Town, Seoul, South Korea',
 '2021-03-15 08:30:00.000', '2023-04-20 09:45:00.000', 0, 1),

('0103456789', 'Sony Corporation', 'info@sony.com', NULL, NULL,
 '2020-07-10 11:15:00.000', '2023-03-25 14:20:00.000', 0, 1),

('0104567890', 'Xiaomi Corporation', 'contact@xiaomi.com', NULL, NULL,
 '2019-11-05 13:45:00.000', '2023-02-10 16:00:00.000', 0, 1),

('0105678901', 'HP Inc.', 'sales@hp.com', NULL, NULL,
 '2018-06-12 07:50:00.000', '2023-01-30 12:10:00.000', 0, 1),

('0106789012', 'Dell Technologies', 'support@dell.com', '028-67890123', 'One Dell Way, Round Rock, TX',
 '2017-05-20 10:00:00.000', '2023-04-18 11:30:00.000', 0, 1),

('0107890123', 'Macbook (Apple)', 'macbook@apple.com', '028-78901234', '1 Infinite Loop, Cupertino, CA',
 '2022-02-15 09:20:00.000', '2023-05-02 10:45:00.000', 0, 1),

('0108901234', 'AsusTek Computer Inc.', 'service@asus.com', '028-89012345', 'No. 15, Li-Te Rd., Beitou, Taipei',
 '2021-08-22 14:35:00.000', '2023-04-27 13:50:00.000', 0, 1);

 -- Insert data Product table
 insert into Products([ProductName], [Description], [Price], [Discount], [Stock], [Status], [SupplierID], [CategoryID], [BrandID], IsNew, [IsFeatured], [IsBestSeller], [WarrantyPeriod])
VALUES
      ('IPhone 15 Pro Max', N'High-end smartphone with A17 Pro chip', 19990000, 0, 40, 'In stock', 1, 1, 1, 1, 1, 0, 12),
	  ('IPhone 14 Pro', 'ProMotion 120Hz display, Dynamic Island', 17590000, 5, 20, 'In stock', 1, 1, 1, 0, 1, 0, 12),
	  ('IPhone 13', 'Powerful A15 Bionic chip, dual camera, long-lasting battery', 11690000, 5, 20, 'In stock', 1, 1, 1, 1, 1, 0, 12),
	  ('IPhone 14', 'A15 Bionic chip, improved camera, familiar design', 12790000, 0, 20, 'In stock', 1, 1, 1, 0, 1, 0, 12),
	  ('IPhone 15', 'A15 Bionic chip, improved camera, familiar design', 29990000, 0, 20, 'In stock', 1, 1, 1, 1, 1, 1, 12),

	  ('Samsung Galaxy S23', 'Compact flagship with Snapdragon 8 Gen 2 chip and 50MP camera', 6900000, 5, 20, 'In stock', 1, 1, 2, 1, 1, 1, 12),
	  ('Samsung Galaxy Z Fold5', 'Premium foldable display, powerful performance, seamless multitasking', 16990000, 5, 20, 'In stock', 1, 1, 2, 0, 1, 1, 12),
	  ('Samsung Galaxy A54', '120Hz Super AMOLED display, 50MP camera with OIS stabilization.', 12990000, 5, 20, 'In stock', 1, 1, 2, 0, 0, 0, 12),
	  ('Samsung Galaxy A74', 'Large display, powerful chip, long-lasting 5000mAh battery.', 29990000, 0, 20, 'In stock', 1, 1, 2, 0, 1, 1, 12),
	  ('Samsung Galaxy Z Flip5', 'Stylish foldable design, 120Hz AMOLED display, powerful processor', 9900000, 0, 20, 'In stock', 1, 1, 2, 0, 0, 1, 12),

	
	update Products set [Discount] = 0 where ProductID = 10
-- insert data productImage table
insert into ProductImages(ProductID, ImageURL, AltText)
VALUES (1, 'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-600x600.jpg', 'Product image of iPhone 15 Pro Max – modern and premium smartphone design'),
	   (2, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_m_13_1_2_2_1.png', 'Product image of iPhone 14 Pro – sleek design with advanced features'),
	   (3, 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-midnight-2-600x600.jpg', 'Product image of iPhone 13 – stylish design with powerful performance'),
	   (4, 'https://cdn.tgdd.vn/Products/Images/42/240259/iPhone-14-plus-thumb-xanh-600x600.jpg', 'Product image of iPhone 14 – elegant design with improved camera and performance'),
	   (5, 'https://cdn.tgdd.vn/Products/Images/42/303891/iphone-15-plus-128gb-xanh-thumb-600x600.jpg', 'Product image of iPhone 15 – refined design with powerful A16 chip'), 

	   (6, 'https://cdn.xtmobile.vn/vnt_upload/product/10_2023/thumbs/(600x600)_crop_samsung-galaxy-s23-fe-xtmobile.png', 'Samsung Galaxy S23 – sleek design, powerful chip, and pro-grade camera system'), 
	   (7, 'https://bizweb.dktcdn.net/thumb/grande/100/263/281/products/z-fold-5-6.jpg?v=1690514247173', 'Samsung Galaxy Z Fold5 unfolded, showcasing its large inner display and sleek foldable design'), 
	   (8, 'https://bizweb.dktcdn.net/100/215/078/products/10055112-dien-thoai-samsung-galaxy-a54-5g-8gb-128gb-den-1-92cb5f8e-4dcf-45a5-853c-703c88b150d6.jpg?v=1697535278957', 'Samsung Galaxy A54 smartphone with a sleek design and triple rear cameras'), 
	   (9, 'https://cdn.tgdd.vn/Products/Images/42/298376/samsung-galaxy-a74-600x600.jpg', 'Samsung Galaxy A74 concept smartphone with sleek design and quad rear cameras'), 
	   (10, 'https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_z_flip5_tim.png', 'Samsung Galaxy Z Flip5 folded, showing its cover screen with widgets and notifications'), 

INSERT INTO OrderStatus (StatusName) VALUES 
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled');

GO