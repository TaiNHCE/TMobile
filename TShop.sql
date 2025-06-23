USE master;
GO
DROP DATABASE IF EXISTS TShop;
GO

CREATE DATABASE TShop;
GO
USE TShop;
GO

-- Roles
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

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    ImgURLLogo NVARCHAR(500),
    isActive BIT DEFAULT 1
);

CREATE TABLE CategoryDetailsGroup(
    CategoryDetailsGroupID INT PRIMARY KEY IDENTITY,
    NameCategoryDetailsGroup NVARCHAR(500) NOT NULL,
    CategoryID INT NOT NULL FOREIGN KEY REFERENCES Categories(CategoryID) ON DELETE CASCADE
);

CREATE TABLE CategoryDetails (
    CategoryDetailID INT PRIMARY KEY IDENTITY,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID) ON DELETE NO ACTION,
    AttributeName NVARCHAR(100) NOT NULL,
    CategoryDetailsGroupID INT FOREIGN KEY REFERENCES CategoryDetailsGroup(CategoryDetailsGroupID) ON DELETE CASCADE
);

CREATE TABLE Brands (
    BrandID INT PRIMARY KEY IDENTITY,
    BrandName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    ImgURLLogo NVARCHAR(500),
    isActive BIT DEFAULT 1
);

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
    Activate BIT DEFAULT 1,
    ContactPerson NVARCHAR(100),
    SupplyGroup NVARCHAR(100),
    Description NVARCHAR(MAX)
);

-- Products: Sửa khóa ngoại cho phép NULL để hỗ trợ ON DELETE SET NULL
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY,
    ProductName NVARCHAR(100),
    Description NVARCHAR(MAX),
    Price DECIMAL(10, 2),
    Discount INT,
    Stock INT,
    Status NVARCHAR(100),
    SupplierID INT NULL FOREIGN KEY REFERENCES Suppliers(SupplierID) ON DELETE SET NULL,
    CategoryID INT NULL FOREIGN KEY REFERENCES Categories(CategoryID) ON DELETE SET NULL,
    BrandID INT NULL FOREIGN KEY REFERENCES Brands(BrandID) ON DELETE SET NULL,
    IsFeatured BIT,
    IsBestSeller BIT,
    IsNew BIT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdateAt DATETIME DEFAULT GETDATE(),
    WarrantyPeriod INT,
    isActive BIT default 0
);

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
	ImageURL4 NVARCHAR(500),
	ProductDetailID INT FOREIGN KEY REFERENCES ProductDetails(ProductDetailID) ON DELETE CASCADE
);

SELECT p.ProductDetailID, p.ProductID, p.CategoryDetailID, p.AttributeValue, ip.ImageURL1, ip.ImageURL2, ip.ImageURL3,
                ip.ImageURL4
                FROM ProductDetails p
                JOIN ImgProductDetails ip ON p.ProductDetailID = ip.ProductDetailID

insert into ImgProductDetails(ImageURL1, ImageURL2, ImageURL3, ImageURL4, ProductDetailID)
VALUES
		('https://cdn.tgdd.vn/Products/Images/42/305659/iphone-15-pro-max-blue-1-750x500.jpg', 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/305659/iphone-15-pro-max-titan-xanh-2-638629415390443671-750x500.jpg', 'https://cdn.tgdd.vn/Products/Images/42/305659/iphone-15-pro-max-blue-3-750x500.jpg', 'https://cdn.tgdd.vn/Products/Images/42/305659/iphone-15-pro-max-blue-4-750x500.jpg', 1);

CREATE TABLE ProductVariants (
    VariantID INT PRIMARY KEY IDENTITY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    Color NVARCHAR(50),
    Storage NVARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    Discount INT DEFAULT 0,
    SKU NVARCHAR(50) UNIQUE,
    ImageURL NVARCHAR(500),
    IsActive BIT DEFAULT 1
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    VariantID INT NULL FOREIGN KEY REFERENCES ProductVariants(VariantID) ON DELETE NO ACTION,
    Quantity INT,
    LastUpdated DATETIME DEFAULT GETDATE()
);

CREATE TABLE Feedbacks (
    FeedbackID INT PRIMARY KEY IDENTITY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE CASCADE,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsVisible BIT DEFAULT 1
);

CREATE TABLE FeedbackReplies (
    ReplyID INT PRIMARY KEY IDENTITY,
    FeedbackID INT FOREIGN KEY REFERENCES Feedbacks(FeedbackID) ON DELETE CASCADE,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE NO ACTION,
    ReplyContent NVARCHAR(MAX),
    RepliedAt DATETIME DEFAULT GETDATE(),
    IsPublic BIT DEFAULT 1
);

CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY,
    AccountID INT UNIQUE FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE CASCADE,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE CartItems (
    CartItemID INT PRIMARY KEY IDENTITY,
    CartID INT FOREIGN KEY REFERENCES Cart(CartID) ON DELETE CASCADE,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE NO ACTION,
    VariantID INT NULL FOREIGN KEY REFERENCES ProductVariants(VariantID) ON DELETE NO ACTION,
    Quantity INT,
    AddedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE ProductViewHistory (
    ViewID INT PRIMARY KEY IDENTITY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID) ON DELETE NO ACTION,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    ViewTime DATETIME DEFAULT GETDATE()
);

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
    CreatedAt DATETIME DEFAULT GETDATE(),
    Description NVARCHAR(MAX)
);
select * from OrderStatus
CREATE TABLE OrderStatus (
    StatusID INT PRIMARY KEY IDENTITY,
    StatusName NVARCHAR(50) NOT NULL 
);

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

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID) ON DELETE CASCADE,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE NO ACTION,
    VariantID INT NULL FOREIGN KEY REFERENCES ProductVariants(VariantID) ON DELETE NO ACTION,
    Quantity INT,
    UnitPrice DECIMAL(10,2)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID) ON DELETE CASCADE,
    PaymentMethod NVARCHAR(50),
    PaymentStatus NVARCHAR(50),
    PaidDate DATETIME,
    Amount DECIMAL(12,2)
);

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

CREATE TABLE PurchaseOrderDetails (
    DetailID INT PRIMARY KEY IDENTITY,
    PurchaseOrderID INT FOREIGN KEY REFERENCES PurchaseOrders(PurchaseOrderID) ON DELETE CASCADE,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID) ON DELETE NO ACTION,
    Quantity INT,
    UnitPrice DECIMAL(10,2)
);

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

-- Indexes
CREATE INDEX IX_Products_CategoryID ON Products(CategoryID);
CREATE INDEX IX_Products_BrandID ON Products(BrandID);
CREATE INDEX IX_Products_Status ON Products(Status);
CREATE INDEX IX_Products_IsFeatured ON Products(IsFeatured);
CREATE INDEX IX_Products_IsBestSeller ON Products(IsBestSeller);
CREATE INDEX IX_Orders_AccountID ON Orders(AccountID);
CREATE INDEX IX_Orders_StatusID ON Orders(StatusID);
CREATE INDEX IX_Orders_OrderDate ON Orders(OrderDate);
CREATE INDEX IX_Feedbacks_ProductID ON Feedbacks(ProductID);
CREATE INDEX IX_Feedbacks_AccountID ON Feedbacks(AccountID);
CREATE INDEX IX_ProductViewHistory_AccountID ON ProductViewHistory(AccountID); 
CREATE INDEX IX_ProductViewHistory_ProductID ON ProductViewHistory(ProductID);
CREATE INDEX IX_Notifications_AccountID ON Notifications(AccountID); 
CREATE INDEX IX_Notifications_IsRead ON Notifications(IsRead);

-- Data Roles
INSERT INTO Roles (RoleName) VALUES ('Admin'),('Staff'),('Customer');

INSERT [dbo].[Accounts] ([Email], [PasswordHash], [CreatedAt], [IsActive], [RoleID], [EmailVerified], [ProfileImageURL]) 
VALUES 
		(N'tanmnce182352@fpt.edu.vn', N'e10adc3949ba59abbe56e057f20f883e', CAST(N'2025-06-12T10:30:39.293' AS DateTime), 1, 1, 0, NULL),
		(N'user1@example.com', N'E10ADC3949BA59ABBE56E057F20F883E', CAST(N'2025-06-12T13:57:31.773' AS DateTime), 1, 2, 0, NULL),
		(N'user2@example.com', N'E10ADC3949BA59ABBE56E057F20F883E', CAST(N'2025-06-12T13:57:31.773' AS DateTime), 1, 2, 0, NULL);

-- Data Categories
INSERT INTO Categories(CategoryName, Description, ImgURLLogo) VALUES
('Phone', 'Mobile phones and smartphones', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNCzd8XHEQEMejkLb560ADY_9IGrldxg6nWg&s'),
('Laptop', 'Portable personal computers', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Nmgin512ZU5KsiS-hnC97bYEc6Mq-biHSg&s'),
('Watch', 'Wristwatches and smartwatches', 'https://static.vecteezy.com/system/resources/thumbnails/002/387/785/small/handwatch-icon-free-vector.jpg'),
('Accessories', 'Electronic accessories like keyboards, mice, etc.', 'https://png.pngtree.com/png-clipart/20220604/original/pngtree-headphone-icon-png-png-image_7930757.png');

insert into CategoryDetailsGroup(NameCategoryDetailsGroup, CategoryID)
values
      ('Configuration & Memory', 1),
	  ('Camera & Display', 1),
	  ('Battery & Charging', 1),
	  ('Utilities', 1),
	  ('Connectivity', 1),
	  ('Design & Materials', 1);

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
	   (1, 'Brand', 6);

-- Data Brands
INSERT INTO Brands(BrandName, Description, CategoryID, ImgURLLogo) VALUES
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

INSERT INTO Suppliers (TaxID, Name, Email, PhoneNumber, Address, CreatedDate, LastModify, Deleted, Activate, ContactPerson, SupplyGroup, Description)
VALUES 
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
	  ('Samsung Galaxy Z Flip5', 'Stylish foldable design, 120Hz AMOLED display, powerful processor', 9900000, 0, 20, 'In stock', 1, 1, 2, 0, 0, 1, 12);
	  
	  
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
	   (10, 'https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_z_flip5_tim.png', 'Samsung Galaxy Z Flip5 folded, showing its cover screen with widgets and notifications');
	   select * from ImgProductDetails
	   
	   SELECT p.ProductDetailID, p.ProductID, p.CategoryDetailID, p.AttributeValue, ip.ImageURL1, ip.ImageURL2, ip.ImageURL3,
                ip.ImageURL4
                FROM ProductDetails p
                JOIN ImgProductDetails ip ON p.ProductDetailID = ip.ProductDetailID
                where p.ProductID = 1
insert into ProductDetails (ProductID, CategoryDetailID, AttributeValue)
VALUES	
		(1, 1, 'iOS 17'),
		(1, 2, 'Apple A17 Pro 6-core processor'),
		(1, 3, '3.78 GHz'),
		(1, 4, 'Apple 6-core GPU'),
		(1, 5, '8 GB'),
		(1, 6, '512 GB'),
		(1, 7, '497 GB'),
		(1, 8, 'Unlimited contacts'),

		(1, 9, 'Main: 48 MP, Ultra-wide: 12 MP, Telephoto: 12 MP'),
		(1, 10, 'HD 720p at 30fps'),
		(1, 10, 'Full HD 1080p at 60fps'),
		(1, 10, 'Full HD 1080p at 30fps'),
		(1, 10, 'Full HD 1080p at 25fps'),
		(1, 10, 'Full HD 1080p at 240fps'),
		(1, 10, 'Full HD 1080p at 120fps'),
		(1, 10, '4K 2160p at 60fps'),
		(1, 10, '4K 2160p at 30fps'),
		(1, 10, '4K 2160p at 25fps'),
		(1, 10, '4K 2160p at 24fps'),
		(1, 11, 'Yes'),
		(1, 12, 'RAW photo capture'),
		(1, 12, 'Optical zoom'),
		(1, 12, 'Digital zoom'),
		(1, 12, 'Portrait mode (bokeh effect)'),
		(1, 12, 'Time-Lapse'),
		(1, 12, 'Panorama'),
		(1, 12, 'Smart HDR 5'),
		(1, 12, 'Super resolution'),
		(1, 12, 'Macro photography '),
		(1, 12, 'ProRes video recording'),
		(1, 12, 'Slow-motion video'),
		(1, 12, 'Live Photos'),
		(1, 12, 'Ultra-wide angle'),
		(1, 12, 'Dolby Vision HDR '),
		(1, 12, 'Deep Fusion'),
		(1, 12, 'Cinematic mode'),
		(1, 12, 'Optical Image Stabilization (OIS)'),
		(1, 12, 'Action mode'),
		(1, 12, 'Night portrait'),
		(1, 12, 'Photographic styles / Color filters'),
		(1, 12, 'Night mode'),
		(1, 12, 'Photonic Engine'),
		(1, 13, '12 MP'),
		(1, 14, 'Smart HDR 5 '),
		(1, 14, 'Portrait mode (bokeh effect)'),
		(1, 14, 'Time-Lapse'),
		(1, 14, 'Retina Flash'),
		(1, 14, 'ProRes video recording'),
		(1, 14, 'Full HD video recording'),
		(1, 14, '4K video recording'),
		(1, 14, 'Slow-motion video'),
		(1, 14, 'AR Stickers'),
		(1, 14, 'Live Photos'),
		(1, 14, 'Deep Fusion'),
		(1, 14, 'Cinematic mode'),
		(1, 14, 'Night photography / Night mode'),
		(1, 14, 'Electronic Image Stabilization (EIS)'),
		(1, 14, 'Photographic styles / Color filters'),
		(1, 14, 'Photonic Engine'),
		(1, 15, 'OLED'),
		(1, 16, 'Super Retina XDR (1290 x 2796 Pixels)'),
		(1, 17, '6.7" display with 120Hz refresh rate'),
		(1, 18, '2000 nits'),
		(1, 19, 'Ceramic Shield glass'),
		(1, 20, '4422 mAh'),
		(1, 21, 'Li-Ion'),
		(1, 22, '20 W'),
		(1, 23, 'Power saving mode'),
		(1, 23, 'Fast charging'),
		(1, 23, 'Reverse wired charging'),
		(1, 23, 'MagSafe wireless charging'),
		(1, 23, 'Wireless charging'),
		(1, 24, 'Face ID facial recognition unlock'),
		(1, 25, 'Dolby Atmos audio'),
		(1, 25, 'Crash Detection'),
		(1, 25, 'Always-On Display (AOD)'),
		(1, 25, 'Dual speakers'),
		(1, 25, 'HDR10'),
		(1, 25, 'DCI-P3 color gamut'),
		(1, 25, 'True Tone technology'),
		(1, 25, 'Dolby Vision image technology'),
		(1, 25, 'HLG (Hybrid Log Gamma)'),
		(1, 25, 'Double-tap to wake'),
		(1, 25, 'Apple Pay'),
		(1, 26, 'IP68'),
		(1, 27, 'Built-in voice recording'),
		(1, 28, 'H.264(MPEG4-AVC)'),
		(1, 28, 'AV1'),
		(1, 28, 'ProRes'),
		(1, 28, 'HEVC'),
		(1, 29, 'MP3'),
		(1, 29, 'FLAC'),
		(1, 29, 'AAC'),
		(1, 30, '5G support'),
		(1, 31, '1 Nano SIM & 1 eSIM'),
		(1, 32, 'Wi-Fi MIMO'),
		(1, 32, 'Wi-Fi 802.11 a/b/g/n/ac/ax'),
		(1, 32, '6 GHz'),
		(1, 33, 'QZSS'),
		(1, 33, 'NavIC'),
		(1, 33, 'GPS'),
		(1, 33, 'GLONASS'),
		(1, 33, 'GALILEO'),
		(1, 33, 'BEIDOU'),
		(1, 34, 'v5.3'),
		(1, 35, 'Type-C'),
		(1, 36, 'Type-C'),
		(1, 37, 'Unibody design'),
		(1, 38, 'Titanium frame and reinforced glass back'),
		(1, 39, 'Dimensions: 159.9 x 76.7 x 8.25 mm; Weight: 221 g'),
		(1, 40, '09/2023'),
		(1, 41, 'iPhone (Apple).');

-- PurchaseOrders (6 orders for demo)
INSERT INTO PurchaseOrders (SupplierID, AccountID, OrderDate, ExpectedDeliveryDate, Status, Notes, TotalAmount) VALUES
(1, 1, '2025-06-01', '2025-06-05', 'Received', 'Apple order June', 48000),
(2, 2, '2025-06-02', '2025-06-07', 'Received', 'Samsung order June', 51000),
(6, 2, '2025-06-03', '2025-06-10', 'Processing', 'HP order June', 39100),
(7, 1, '2025-06-04', '2025-06-11', 'Pending', 'Dell order June', 31200),
(9, 3, '2025-06-05', '2025-06-13', 'Received', 'Orient batch', 10500),
(14, 3, '2025-06-06', '2025-06-12', 'Received', 'Corsair accessories', 20500);

-- PurchaseOrderDetails (using ProductID from above, consistent with the orders)
INSERT INTO PurchaseOrderDetails (PurchaseOrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 40, 1100),
(1, 2, 20, 850),
(2, 5, 35, 1050),
(2, 6, 20, 800),
(3, 9, 10, 1500),
(3, 10, 5, 1800),
(4, 10, 8, 1900),
(5, 2, 13, 1100),
(6, 3, 60, 45),
(6, 5, 25, 30);

INSERT INTO ShippingAddresses (AccountID, RecipientName, Phone, AddressLine, Ward, District, City, PostalCode, IsDefault)
VALUES 
(1, N'Nguyen Van An', '0912345678', N'12 Le Loi', N'Ben Nghe', N'District 1', N'Ho Chi Minh City', '700000', 1),
(2, N'Le Thi Hoa', '0923456789', N'45 Tran Hung Dao', N'Phu Hoi', N'Hue City', N'Thue Thien Hue', '530000', 1),
(3, N'Tran Minh Tuan', '0934567890', N'123 Nguyen Trai', N'Lam Son', N'Thanh Hoa', N'Thanh Hoa', '440000', 1);

INSERT INTO Orders(AccountID, OrderDate, StatusID, ShippingAddressID, VoucherID, TotalAmount, ShippingFee, DiscountAmount, OrderNotes, EstimatedDeliveryDate)
VALUES (1, '2025-06-12', 1, 1, NULL, 32990000, 0, 0, N'First order for Nguyen Van An', '2025-06-20');

INSERT INTO Orders(AccountID, OrderDate, StatusID, ShippingAddressID, VoucherID, TotalAmount, ShippingFee, DiscountAmount, OrderNotes, EstimatedDeliveryDate)
VALUES (2, '2025-06-16', 1, 2, NULL, 27990000, 0, 0, N'First order for Le Thi Hoa', '2025-06-20');

INSERT INTO Orders(AccountID, OrderDate, StatusID, ShippingAddressID, VoucherID, TotalAmount, ShippingFee, DiscountAmount, OrderNotes, EstimatedDeliveryDate)
VALUES (3, '2025-06-16', 1, 3, NULL, 20990000, 0, 0, N'First order for Tran Minh Tuan', '2025-06-20');

INSERT INTO Orders(AccountID, OrderDate, StatusID, ShippingAddressID, VoucherID, TotalAmount, ShippingFee, DiscountAmount, OrderNotes, EstimatedDeliveryDate)
VALUES (1, '2025-06-16', 1, 1, NULL, 15500000, 0, 0, N'Second order for Nguyen Van An', '2025-06-20');

INSERT INTO Orders(AccountID, OrderDate, StatusID, ShippingAddressID, VoucherID, TotalAmount, ShippingFee, DiscountAmount, OrderNotes, EstimatedDeliveryDate)
VALUES (2, '2025-06-1', 1, 2, NULL, 1200000, 0, 0, N'Second order for Le Thi Hoa', '2025-06-20');

INSERT INTO Orders(AccountID, OrderDate, StatusID, ShippingAddressID, VoucherID, TotalAmount, ShippingFee, DiscountAmount, OrderNotes, EstimatedDeliveryDate)
VALUES (1, '2025-06-12', 1, 1, NULL, 23500000, 0, 0, N'Order for Dell XPS 13', '2025-06-21');

-- For a Laptop
INSERT INTO Orders(AccountID, OrderDate, StatusID, ShippingAddressID, VoucherID, TotalAmount, ShippingFee, DiscountAmount, OrderNotes, EstimatedDeliveryDate)
VALUES (2, '2025-06-1', 1, 2, NULL, 15500000, 0, 0, N'Order for HP Pavilion 15', '2025-06-21');
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (7, 9, 1, 15500000);

-- For a Watch
INSERT INTO Orders(AccountID, OrderDate, StatusID, ShippingAddressID, VoucherID, TotalAmount, ShippingFee, DiscountAmount, OrderNotes, EstimatedDeliveryDate)
VALUES (3, '2025-06-1', 1, 3, NULL, 7000000, 0, 0, N'Order for Orient Sun&Moon', '2025-06-21');
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (8, 3, 1, 7000000);

-- For an Accessory
INSERT INTO Orders(AccountID, OrderDate, StatusID, ShippingAddressID, VoucherID, TotalAmount, ShippingFee, DiscountAmount, OrderNotes, EstimatedDeliveryDate)
VALUES (1, '2025-06-15', 1, 1, NULL, 3500000, 0, 0, N'Order for Corsair K95 RGB Keyboard', '2025-06-21');

INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (10, 1, 1, 3500000);

INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (11, 10, 1, 23500000);

INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (12, 1, 1, 32990000);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (13, 2, 1, 27990000);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (14, 5, 1, 20990000);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (15, 9, 1, 15500000);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (16, 10, 1, 1200000);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (17, 9, 1, 15500000);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (18, 3, 1, 3500000);
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES (18, 1, 1, 23500000);

-- Vouchers (4 codes)
INSERT INTO Vouchers (Code, DiscountPercent, ExpiryDate, MinOrderAmount, MaxDiscountAmount, UsageLimit, UsedCount, IsActive, Description)
VALUES
('SALE10', 10, '2025-12-31', 1000000, 500000, 100, 0, 1, '10% off for orders from 1,000,000 VND'),
('SUMMER20', 20, '2025-08-31', 2000000, 1000000, 50, 0, 1, '20% off for orders above 2,000,000 VND'),
('WELCOME5', 5, '2026-01-31', 500000, 200000, 500, 0, 1, '5% discount for new customers'),
('FREESHIP', 0, '2025-07-31', 300000, 0, 1000, 0, 1, 'Free shipping for orders over 300,000 VND');

-- OrderStatus
INSERT INTO OrderStatus (StatusName) VALUES
('Pending'),('Processing'),('Shipped'),('Delivered'),('Cancelled');
