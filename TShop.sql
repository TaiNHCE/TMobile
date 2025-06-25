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
    isActive BIT default 1
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
		(N'user2@example.com', N'E10ADC3949BA59ABBE56E057F20F883E', CAST(N'2025-06-12T13:57:31.773' AS DateTime), 1, 2, 0, NULL)

-- Data Categories
INSERT INTO Categories(CategoryName, Description, ImgURLLogo) VALUES
('Air Conditioners', 'Efficient and reliable air conditioners for every space. Stay cool with top brands and modern technology', 'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750841627/depositphotos_130063318-stock-illustration-air-conditioner-icon-in-outline_jos8kt.jpg'),
('Washing Machine', 'Powerful and efficient washing machines for easy and effective laundry every day', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNyCsLeZiCL1Y5_Kxt6Z4TkiVV700_NA5NzA&s'),
('Television', 'Explore high-quality TVs with stunning visuals and smart features for your entertainment needs', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYDpCUdtFj7NPKgzFiYSImhOovVDokPu6wDA&s'),
('Fridge', 'Keep your food fresh with energy-efficient and spacious refrigerators from top brands', 'https://cdn-icons-png.flaticon.com/512/3474/3474313.png'),
('Rice Cookers', 'Cook delicious rice effortlessly with compact, durable, and modern rice cookers', 'https://cdn-icons-png.flaticon.com/512/181/181157.png');

insert into CategoryDetailsGroup(NameCategoryDetailsGroup, CategoryID)
values
--Tên tiêu đề thông tin kỹ thuật của máy lanh
      ('Product Information', 1),
	  ('Power Consumption', 1),
	  ('Air Purification Capability', 1),
	  ('Cooling Technology', 1),
	  ('Utilities ', 1),
	  ('Installation Dimensions', 1),

	  ('Overview', 2),
	  ('Power Consumption', 2),
	  ('Washing Technology', 2),
	  ('Control Panel and Features', 2),
	  ('Installation Dimensions', 2),

	  ('Overview', 3),
	  ('Image Technology', 3),
	  ('Utilities', 3),
	  ('Audio Technology', 3),
	  ('Connectivity Ports', 3),
	  ('Installation Dimensions', 3),

	  ('Overview', 4),
	  ('Power Consumption', 4),
	  ('Preservation and Cooling Technology', 4),
	  ('Utilities', 4),
	  ('Installation Dimensions', 4),
	  
	  ('Overview', 5),
	  ('Inner Pot', 5),
	  ('Cooking Technologies and Functions', 5),
	  ('Control Panel and Features', 5),
	  ('Installation Dimensions', 5);

insert into CategoryDetails(CategoryID, AttributeName, CategoryDetailsGroupID)
values (1, 'Machine Type', 1),
       (1, 'Inverter', 1),
	   (1, 'Cooling Capacity', 1),
	   (1, 'Effective Cooling Range', 1),
	   (1, 'Average Noise Level', 1),
	   (1, 'Product Line', 1),
	   (1, 'Made in', 1),
	   (1, 'Warranty Period for Indoor Unit and Outdoor Unit', 1),
	   (1, 'Compressor Warranty Period', 1),
	   (1, 'Condenser Material', 1),
	   (1, 'Gas Type', 1),

	   (1, 'Power Consumption', 2),
	   (1, 'Energy Label', 2),
	   (1, 'Energy-Saving Technology', 2),

	   (1, 'Lọc bụi, kháng khuẩn, khử mùi:', 3), 

	   (1, 'Airflow Mode', 4),
	   (1, 'Fast Cooling Technology', 4),

	   (1, 'Features', 5),

	   (1, 'Indoor Unit Dimensions', 6),
	   (1, 'Indoor Unit Weight', 6),
	   (1, 'Outdoor Unit Dimensions', 6),
	   (1, 'Outdoor Unit Weight', 6),
	   (1, 'Copper Pipe Installation Length', 6),
	   (1, 'Maximum Installation Height Difference between Indoor and Outdoor Units', 6),
	   (1, 'Power Input', 6),
	   (1, 'Operating Voltage', 6),
	   (1, 'Copper Pipe Size', 6),
	   (1, 'Max Indoor Units Connectable', 6),
	   (1, 'Brand', 6),

	   ------ máy giặt -----
	   (2, 'Type of washing machine', 7),
	   (2, 'Tub', 7),
	   (2, 'Washing volume', 7),
	   (2, 'Number of users', 7),
	   (2, 'Engine Type', 7),
	   (2, 'Maximum spin speed', 7),
	   (2, 'Tub Material', 7),
	   (2, 'Case Material', 7),
	   (2, 'Machine Door Material', 7),
	   (2, 'Made in', 7),
	   (2, 'Launch year', 7),
	   (2, 'Engine Warranty Period', 7),
	   
	   (2, 'Engine Warranty Period', 8),
	   (2, 'Engine Warranty Period', 8),

	   (2, 'Program', 9),
	   (2, 'Washing technology', 9),

	   (2, 'Control Panel', 10),
	   (2, 'Utilities', 10),

	   (2, 'Dimensions - Volume', 11),
	   (2, 'Water Supply Pipe Length', 11),
	   (2, 'Drain Pipe Length', 11),
	   (2, 'Firm', 11),

	   ------Tivi ---------
	   (3, 'TV Type', 12),
	   (3, 'Screen Size', 12),
	   (3, 'Resolution', 12),
	   (3, 'Screen Type', 12),
	   (3, 'Operating System', 12),
	   (3, 'Stand Material', 12),
	   (3, 'TV bezel material', 12),
	   (3, 'Place of Manufacture', 12),
	   (3, 'Launch year', 12),

	   (3, 'Imaging Technology', 13),
	   (3, 'Processor', 13),
	   (3, 'Real Scan Frequency', 13),

	   (3, 'Control your TV with your phone', 14),
	   (3, 'Voice Control', 14),
	   (3, 'Project from your phone to your TV', 14),
	   (3, 'Smart Remote', 14),
	   (3, 'Popular Applications', 14),
	   (3, 'Other smart gadgets', 14),

	   (3, 'Total Speaker Power', 15),
	   (3, 'Number of Speakers', 15),
	   (3, 'Surround Sound', 15),

	   (3, 'Internet Connection', 16),
	   (3, 'Wireless Connection', 16),
	   (3, 'USB', 16),
	   (3, 'Image and audio receiving port', 16),
	   (3, 'Audio Output Port', 16),

	   (3, 'Size with legs, table set', 17),
	   (3, 'Weight with legs', 17),
	   (3, 'Footless, wall-mounted size', 17),
	   (3, 'Footless Weight', 17),
	   (3, 'Firm', 17)
	   select * from Products
-- Data Brands
INSERT INTO Brands(BrandName, Description, CategoryID, ImgURLLogo) VALUES
('Panasonic', '', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFgrxUMQQfftPQY0y_vDvEFs5Athmo8laMLA&s'),
('Daikin', '', 1, 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/DAIKIN_logo.svg/2560px-DAIKIN_logo.svg.png'),
('AQUA', '', 1, 'https://ew.aquavietnam.com.vn/Libraries/dist/img/logo_login.png'),
('LG', '', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMNHP5lG5pKBUMtnKkbkqBIbvlQgmc5CRS2w&s'),

('LG', '', 2, 'https://cdn4.iconfinder.com/data/icons/flat-brand-logo-2/512/asus-512.png'),
('Panasonic', '', 2, 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/HP_logo_2012.svg/2048px-HP_logo_2012.svg.png'),
('Aqua', '', 2, 'https://ew.aquavietnam.com.vn/Libraries/dist/img/logo_login.png'),
('Samsung', '', 2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQINM0EBPdB0YdD24RYHd_7qYkZWmDxf010JA&s'),

('TCL', '', 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT704Obg1HKDbMlQN5y9mQ3yqGyrioyBtKY_w&s'),
('Sony', '', 3, 'https://1000logos.net/wp-content/uploads/2023/07/Citizen-logo.jpg'),
('Xiaomi', '', 3, 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Xiaomi_logo_%282021-%29.svg/512px-Xiaomi_logo_%282021-%29.svg.png'),
('LG', '', 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMNHP5lG5pKBUMtnKkbkqBIbvlQgmc5CRS2w&s'),

('Samsung', '', 4, 'https://cdn.iconscout.com/icon/free/png-256/free-bose-logo-icon-download-in-svg-png-gif-file-formats--brand-company-logos-icons-1580027.png?f=webp'),
('LG', '', 4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMNHP5lG5pKBUMtnKkbkqBIbvlQgmc5CRS2w&s'),
('Toshiba', '', 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Toshiba_logo.svg/1280px-Toshiba_logo.svg.png'),
('Sharp', '', 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Toshiba_logo.svg/1280px-Toshiba_logo.svg.png'),

('CUCKOO', '', 5, 'https://homedec.com.my/wp-content/uploads/2024/10/logo_cuckoo_new-1024x352.webp'),
('SUNHOUSE', '', 5, 'https://binhphu.com/wp-content/uploads/2022/09/logo-sunhouse-to.png'),
('Panasonic', '', 5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFgrxUMQQfftPQY0y_vDvEFs5Athmo8laMLA&s'),
('Toshiba', '', 5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Toshiba_logo.svg/1280px-Toshiba_logo.svg.png');

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
insert into Products([ProductName], [Description], [Price], [Discount], [SupplierID], [CategoryID], [BrandID], IsNew, [IsFeatured], [IsBestSeller], [WarrantyPeriod])
VALUES
------- máy lạnh ------->
		----panasonic------
		('Panasonic Inverter Air Conditioner 1 HP CU/CS-PU9AKH-8', '', 11990000, 0, 1, 1, 1, 1, 1, 0, 12),
		('Panasonic Inverter Air Conditioner 1.5 HP CU/CS-U12BKH-8', '', 17790000, 5, 1, 1, 1, 0, 1, 0, 12),
		('Panasonic Inverter Air Conditioner 1.5 HP CU/CS-PU12AKH-8', '', 14590000, 5, 1, 1, 1, 1, 1, 0, 12),
		('Panasonic Inverter Air Conditioner 1 HP CU/CS-U9BKH-8', '', 14290000, 1, 1, 1, 1, 1, 0, 0, 12),
		('Panasonic Inverter Air Conditioner 1 HP CU/CS-XU9BKH-8', '', 14890000, 0, 1, 1, 1, 1, 1, 1, 12),


		-------Daikin-------
		('Daikin Inverter Air Conditioner 1 HP ATKB25YVMV', '', 10390000, 5, 1, 1, 2, 1, 1, 1, 12),
		('Daikin Inverter Air Conditioner 1.5 HP ATKF35ZVMV', '', 13290000, 5, 1, 1, 2, 0, 1, 1, 12),
		('Daikin Inverter Air Conditioner 1.5 HP ATKB35YVMV', '', 13290000, 5, 1, 1, 2, 0, 0, 0, 12),
		('Daikin Inverter Air Conditioner 1 HP ATKF25ZVMV', '', 12290000, 0, 1, 1, 2, 0, 1, 1, 12),
		('Daikin Inverter 2 HP Air Conditioner FTKB50ZVMV', '', 19090000, 0, 1, 1, 2, 0, 0, 1, 12),

		--------Aqua--------
		('AQUA Inverter Air Conditioner 1 HP AQA-RV10QA3', '', 8290000, 5, 1, 1, 3, 1, 1, 1, 12),
		('Aqua Inverter Air Conditioner 1.5 HP AQA-RV13QA3', '', 10790000, 5, 1, 1, 3, 1, 0, 0, 12),
		('AQUA Inverter Air Conditioner 1.5 HP AQA-RUV13RB3', '', 10390000, 5, 1, 1, 3, 0, 1, 1, 12),
		('AQUA Inverter Air Conditioner 1 HP AQA-RUV10RB3', '', 9590000, 5, 1, 1, 3, 1, 1, 0, 12),
		('AQUA Inverter 2 HP AQA-RV18QE Air Conditioner', '', 14640000, 5, 1, 1, 3, 1, 1, 1, 12),

		---------LG---------
		('LG Inverter Air Conditioner 1.5 HP IEC12M1', '', 11590000, 5, 1, 1, 4, 0, 1, 0, 12),
		('LG Inverter Air Conditioner 1 HP IDC09M1', '', 9890000, 5, 1, 1, 4, 1, 0, 1, 12),
		('LG Inverter 2 HP IEC18M1 Air Conditioner', '', 18790000, 5, 1, 1, 4, 1, 1, 1, 12),
		('LG Inverter Air Conditioner 2.5 HP IEC24M1', '', 19690000, 5, 1, 1, 4, 0, 1, 0, 12),
		('LG Inverter 2 HP IEC18M1 Air Conditioner', '', 1879000, 5, 1, 1, 4, 1, 0, 1, 12),
------- máy lạnh ------->


------- máy giặt ------->
		-----------LG-------------
		('LG AI DD Inverter Washing Machine 12 kg FV1412S4W', '', 1099000, 5, 1, 1, 5, 0, 1, 1, 12),
		('LG Inverter washer dryer washes 15 kg - dryers 8 kg F2515RNTG', '', 22440000, 5, 1, 1, 5, 0, 1, 0, 12),
		('LG TurboDrum Inverter Washing Machine 12 kg T2512VBTB', '', 8750000, 5, 1, 1, 5, 1, 0, 0, 12),
		('LG Inverter washing machine 9 kg FB1209S6M', '', 8150000, 5, 1, 1, 5, 1, 1, 0, 12),
		('LG TurboDrum Inverter washing machine 14 kg T2514VBTB', '', 954000, 5, 1, 1, 5, 0, 0, 1, 12),

		--------Panasonic----------
		('Panasonic Inverter Washing Machine 9 kg NA-V90FA1LVT', '', 10250000, 5, 1, 1, 6, 0, 1, 1, 12),
		('Panasonic 8.2 kg washing machine NA-F82Y01DRV', '', 5190000, 5, 1, 1, 6, 1, 1, 1, 12),
		('Panasonic Inverter Washing Machine 10 kg NA-V10FA1LVT', '', 11250000, 5, 1, 1, 6, 1, 0, 1, 12),
		('Panasonic Inverter Washing Machine 11.5 kg NA-V115FA1LV', '', 13250000, 5, 1, 1, 6, 0, 1, 0, 12),
		('Panasonic Inverter Washing Machine 11.5 Kg NA-FD115X3BV', '', 11350000, 5, 1, 1, 6, 1, 0, 0, 12),

		--------AQUA--------------
		('Aqua Inverter washing machine 10 kg AQW-DR100JT BK', '', 6750000, 5, 1, 1, 7, 1, 1, 0, 12),

		---------SAMSUNG-----------
		('Samsung AI EcoBubble Inverter Washing Machine 10 kg WW10DG6U34LBSV', '', 6750000, 5, 1, 1, 8, 0, 1, 0, 12),
------- máy giặt ------->
	  
------- tivi ------->
		--------TCL-------
		('Google TV TCL AI 4K 55 inch 55P635', '', 7990000, 5, 1, 1, 9, 1, 0, 0, 12),
		('Google TV TCL FHD 32 Inch 32S5400', '', 3990000, 5, 1, 1, 9, 1, 1, 0, 12),
		('Google TV TCL AI 4K 55 inch 55P79B Pro', '', 8990000, 5, 1, 1, 9, 0, 0, 1, 12),
		('Google TV QLED TCL AI FHD 40 Inch 40S5K', '', 5590000, 5, 1, 1, 9, 0, 0, 1, 12),
		('Google QLED TV TCL AI FHD 43 inch 43S5K', '', 6390000, 5, 1, 1, 9, 1, 0, 1, 12),
	  
		-------SONY-----------
		('Google TV Sony 4K 55 inch K-55S30', '', 17890000, 5, 1, 1, 10, 1, 1, 0, 12),
		('Google TV Sony 4K 43 Inch K-43S30', '', 13290000, 5, 1, 1, 10, 1, 0, 1, 12),
		('Sony 32-inch Google TV KD-32W830K', '', 74900000, 5, 1, 1, 10, 0, 0, 1, 12),
		('Google TV Sony 4K 65 inch K-65S30', '', 21890000, 5, 1, 1, 10, 1, 0, 0, 12),
		('Google TV Sony 4K 50 inch K-50S30', '', 15890000, 5, 1, 1, 10, 0, 0, 1, 12),

		--------XIAOMI------------
		('Google TV Xiaomi A 32-inch L32M8-P2SEA', '', 15890000, 5, 1, 1, 11, 0, 1, 1, 12),

		-------LG------------------
		('LG AI 4K 55 Inch 55B4PSA Smart OLED TV', '', 15890000, 5, 1, 1, 12, 0, 1, 1, 12),
------- tivi ------->

--------- Tu Lanh ---------
		-----SAMSUNG
		('Samsung Inverter Refrigerator 280 liters RB27N4010BU/SV', '', 8570000, 5, 1, 1, 13, 0, 1, 0, 12),

		-----LG
		('LG Inverter Refrigerator 374 liters LTD37BLM', '', 11650000, 5, 1, 1, 14, 1, 1, 0, 12),

		----- Toshiba
		('Toshiba Inverter Refrigerator 233 Liters GR-RT303WE-PMV(52)', '', 6070000, 5, 1, 1, 15, 0, 1, 0, 12),

		----- Sharp
		 ('Sharp Inverter Refrigerator 181 liters SJ-X198V-SL', '', 4870000, 5, 1, 1, 16, 1, 0, 1, 12),
--------- Tu Lanh ---------

----- Noi com---------
		-----CUCKOO
		('Cuckoo 1.8 Liter Lid Rice Cooker CR-1001V/RDWHCRVNCV', '', 720000, 5, 1, 1, 17, 1, 0, 1, 12),

		----Sonhouse
		('Sunhouse mama 1.8 liter rice cooker SHD8903', '', 1790000, 5, 1, 1, 18, 1, 0, 0, 12),

		----Panasonic
		('Panasonic 1.8 Liter Lid Rice Cooker SR-MVN18LRAX', '', 1230000, 5, 1, 1, 19, 1, 0, 1, 12),

		----Toshiba
		('Toshiba 1.8 Liter Electric Rice Cooker RC-18DR2PV(K)', '', 2690000, 5, 1, 1, 20, 1, 0, 1, 12),
----- Noi com---------
	  
-- insert data productImage table
insert into ProductImages(ProductID, ImageURL, AltText)
VALUES (1, 'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750867614/panasonic-inverter-1-hp-cu-cs-pu9akh-8top-tskt2-700x467_ubai4v.jpg', ''),
	   (2, 'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750867954/panasonic-inverter-1-5-hp-cu-cs-u12bkh-8-1-638780035748790504-700x467_lcq8ot.jpg', ''),
	   (3, 'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868219/panasonic-inverter-1-5-hp-cu-cs-pu12akh-81-700x467_gbffjp.jpg', ''),
	   (4, 'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868532/panasonic-inverter-1-hp-cu-cs-u9bkh-8-1-638780021958928979-700x467_ystmyq.jpg', ''),
	   (5, 'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868940/panasonic-inverter-1-hp-cu-cs-xu9bkh-8-1-638780894032602969-700x467_dyr9ep.jpg', ''), 

	   (6, 'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750869381/daikin-inverter-1-hp-atkb25yvmv-2-1-700x467_r09zwi.jpg', ''), 
	   (7, 'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750869934/daikin-inverter-1-5-hp-atkf35zvmv-1-638750579827970962-700x467_rqs9gd.jpg', ''), 
	   (8, 'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750870900/daikin-inverter-1-5-hp-atkb35yvmv-1-1-700x467_oclaeh.jpg', ''), 
	   (9, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/334523/daikin-inverter-1-hp-atkf25zvmv-1-638790386136849036-700x467.jpg', ''), 
	   (10, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/334537/daikin-inverter-2-hp-ftkb50zvmv-1-638750376343080909-700x467.jpg', ''),

	   (11, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/333353/aqua-inverter-1-hp-aqa-rv10qa3-1-638711560560748727-700x467.jpg', ''),
	   (12, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/333468/aqua-inverter-1-hp-aqa-rv13qa3-1-638711565748974027-700x467.jpg', ''),
	   (13, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/335752/aqua-inverter-1-5-hp-aqa-ruv13rb3-1-638785968996852620-700x467.jpg', ''),
	   (14, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/335743/aqua-inverter-1-hp-aqa-ruv10rb3-1-638785963622756460-700x467.jpg', ''),
	   (15, 'https://cdn.tgdd.vn/Products/Images/2002/320851/aqua-inverter-2-hp-aqa-rv18qe-1-700x467.jpg', ''),

	   (16, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/333759/lg-inverter-1-5-hp-iec12m1-2-638715183481468155-700x467.jpg', ''),
	   (17, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/333737/lg-inverter-1-hp-idc09m1-1-638715204990762511-700x467.jpg', ''),
	   (18, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/333763/lg-inverter-2-hp-iec18m1-1-638715184210140009-700x467.jpg', ''),
	   (19, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/333764/lg-inverter-2-5-hp-v24win1-1-638715184758545562-700x467.jpg', ''),
	   (20, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/2002/333763/lg-inverter-2-hp-iec18m1-1-638715184210140009-700x467.jpg', ''),

	   (21, 'https://cdn.tgdd.vn/Products/Images/1944/310432/lg-inverter-12-kg-fv1412s4w-1-700x467.jpg', ''),
	   (22, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1944/337558/may-giat-say-lg-inverter-giat-15-kg-say-8-kg-f2515rntg-1-638814609623724873-700x467.jpg', ''),
	   (23, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1944/327649/may-giat-lg-turbodrum-inverter-12-kg-t2512vbtb-1-638615588462495944-700x467.jpg', ''),
	   (24, 'https://cdn.tgdd.vn/Products/Images/1944/321182/lg-ai-dd-inverter-9-kg-fb1209s6m-1-1-700x467.jpg', ''),
	   (25, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1944/327650/may-giat-lg-turbodrum-inverter-14-kg-t2514vbtb-1-638615584073916856-700x467.jpg', ''),

	   (26, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1944/328685/may-giat-panasonic-inverter-9-kg-na-v90fa1lvt-pop1-638645025162570085-700x467.jpg', ''),
	   (27, 'https://cdn.tgdd.vn/Products/Images/1944/313393/panasonic-82-kg-na-f82y01drv1-700x467.jpg', ''),
	   (28, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1944/328684/may-giat-panasonic-inverter-10-kg-na-v10fa1lvt-pop-638645010035613152-700x467.jpg', ''),
	   (29, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1944/333921/may-giat-panasonic-inverter-11-5-kg-na-v115fa1lv-638724650737574927-700x467.jpg', ''),
	   (30, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1944/334977/may-giat-panasonic-inverter-115-kg-na-fd115x3bv-638767058742763744-700x467.jpg', ''),

		(31, 'https://cdn.tgdd.vn/Products/Images/1944/325727/aqua-inverter-10-kg-aqw-dr100ujt-bk-1-700x467.jpg', ''),
		(32, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1944/336971/may-giat-samsung-ai-ecobubble-inverter-10-kg-ww10dg6u34lbsv-1-638804841229085649-700x467.jpg', ''),
		(33, 'https://cdn.tgdd.vn/Products/Images/1942/281936/google-tcl-4k-55-inch-55p635-1-700x467.jpg', ''),
		(34, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/306075/google-tivi-tcl-32-inch-32s5400-1-638684850852894164-700x467.jpg', ''),
		(35, 'https://cdn.tgdd.vn/Products/Images/1942/322218/google-tv-tcl-4k-tv-55p79b-pro-1-1-700x467.jpg', ''),

		(36, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/336230/google-tivi-qled-tcl-ai-fhd-40-inch-40s5k-1-638812686340425077-700x467.jpg', ''),
		(37, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/336231/google-tivi-qled-tcl-ai-fhd-43-inch-43s5k-1-638819855228258347-700x467.jpg', ''),
		(38, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/325313/google-tivi-sony-4k-55-inch-k-55s30-1-638703403753106159-700x467.jpg', ''),
		(39, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/325311/google-tivi-sony-4k-43-inch-k-43s30-1-638689079711422803-700x467.jpg', ''),
		(40, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/277446/google-sony-32-inch-kd-32w830k-1-638655611803101385-700x467.jpg', ''),

		(41, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/325310/google-tivi-sony-4k-65-inch-k-65s30-1-638689098054628599-700x467.jpg', ''),
		(42, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/325312/google-tivi-sony-4k-50-inch-k-50s30-1-638701667177607131-700x467.jpg', ''),
		(43, 'https://cdn.tgdd.vn/Products/Images/1942/312858/google-tivi-xiaomi-32-inch-l32m8-p2sea-2-1-700x467.jpg', ''),
		(44, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/324912/tivi-oled-lg-4k-55-inch-55b4psa-1-638688283604114834-700x467.jpg', ''),
		(45, 'https://cdn.tgdd.vn/Products/Images/1943/225858/samsung-rb27n4010bu-sv-2-700x467.jpg', ''),

		(46, 'https://cdn.tgdd.vn/Products/Images/1943/327795/tu-lanh-lg-inverter-374-lit-ltd37blm-1-700x467.jpg', ''),
		(47, 'https://cdn.tgdd.vn/Products/Images/1943/310651/tu-lanh-toshiba-inverter-233-lit-gr-rt303we-pmv-52-1-2-700x467.jpg', ''),
		(48, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1943/324909/tu-lanh-sharp-sj-x198v-sl-1-638637333153861688-700x467.jpg', ''),
		(49, 'https://cdn.tgdd.vn/Products/Images/1922/328318/noi-com-nap-gai-cuckoo-1-8-lit-cr-1001v-rdwhcrvncv-060824-102106-600x600.jpg', ''),
		(50, 'https://cdn.tgdd.vn/Products/Images/1922/131916/sunhouse-mama-shd8903-thumb-600x600-2.jpg', ''),

		(51, 'https://cdn.tgdd.vn/Products/Images/1922/293926/noi-com-nap-gai-18-lit-panasonic-sr-mvn18lrax-231222-023556-600x600.jpg', ''),
		(52, 'https://cdn.tgdd.vn/Products/Images/1922/220499/noi-com-dien-tu-toshiba-rc-18dr2pv-k-18l-thumb-600x600-1.jpg', '');

	  
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

insert into ImgProductDetails(ImageURL1, ImageURL2, ImageURL3, ImageURL4, ProductDetailID)
VALUES
		('https://res.cloudinary.com/dgnyskpc3/image/upload/v1750867699/panasonic-inverter-1-hp-cu-cs-pu9akh-8top-tskt3-700x467_cx5stl.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750867726/panasonic-inverter-1-hp-cu-cs-pu9akh-8top-tskt4-700x467_mli1as.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750867772/panasonic-inverter-1-hp-cu-cs-pu9akh-8top-tskt5-700x467_ym0g1p.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750867810/panasonic-inverter-1-hp-cu-cs-pu9akh-8top-tskt6-700x467_ovws2o.jpg', 1),

		('https://res.cloudinary.com/dgnyskpc3/image/upload/v1750867978/panasonic-inverter-1-5-hp-cu-cs-u12bkh-8-3-638780035761743776-700x467_hhq1hp.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868006/panasonic-inverter-1-5-hp-cu-cs-u12bkh-8-4-638780035767891775-700x467_isv4lf.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868043/panasonic-inverter-1-5-hp-cu-cs-u12bkh-8-5-638780035775454564-700x467_da2ihb.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868075/panasonic-inverter-1-5-hp-cu-cs-u12bkh-8-6-638780035783244576-700x467_oclfqi.jpg', 2),

		('https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868266/panasonic-inverter-1-5-hp-cu-cs-pu12akh-83-700x467_hoadln.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868297/panasonic-inverter-1-5-hp-cu-cs-pu12akh-84-700x467_wzemxy.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868352/panasonic-inverter-1-5-hp-cu-cs-pu12akh-85-700x467_g5sxzv.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868386/panasonic-inverter-1-5-hp-cu-cs-pu12akh-86-700x467_impwmz.jpg', 3),

		('https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868565/panasonic-inverter-1-hp-cu-cs-u9bkh-8-3-638780021976070349-700x467_ncak1j.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868603/panasonic-inverter-1-hp-cu-cs-u9bkh-8-4-638780021983791559-700x467_y5poga.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868631/panasonic-inverter-1-hp-cu-cs-u9bkh-8-5-638780021990807191-700x467_sy4lzr.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868687/panasonic-inverter-1-hp-cu-cs-u9bkh-8-6-638780021998769643-700x467_ommux4.jpg', 4),

		('https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868967/panasonic-inverter-1-hp-cu-cs-xu9bkh-8-3-638780894046853851-700x467_xoldec.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750868992/panasonic-inverter-1-hp-cu-cs-xu9bkh-8-4-638780894052956318-700x467_ozcvvk.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750869020/panasonic-inverter-1-hp-cu-cs-xu9bkh-8-5-638780894060378554-700x467_p11g7m.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750869051/panasonic-inverter-1-hp-cu-cs-xu9bkh-8-6-638780894069097585-700x467_cflkt1.jpg', 5),

		('https://res.cloudinary.com/dgnyskpc3/image/upload/v1750869576/daikin-inverter-1-hp-atkb25yvmv-3-1-700x467_foiogp.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750869629/daikin-inverter-1-hp-atkb25yvmv-4-1-700x467_ibb8dd.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750869783/daikin-inverter-1-hp-atkb25yvmv-6-1-700x467_ibmyli.jpg', 
		'https://res.cloudinary.com/dgnyskpc3/image/upload/v1750869822/daikin-inverter-1-hp-atkb25yvmv-7-1-700x467_nyqr2e.jpg', 6),

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
