CREATE DATABASE NguyenVuAnhKhoaDB

USE NguyenVuAnhKhoaDB

CREATE TABLE UserAccount(
	ID  bigint IDENTITY(1,1) primary key,
	Username varchar(50) null,
	Password varchar(32) null,
	Status nvarchar(30) null
)

CREATE TABLE Category(
	ID bigint IDENTITY(1,1) primary key,
	Name nvarchar(100) null,
	Description nvarchar(255) null 
)

CREATE TABLE Product(
	ID bigint IDENTITY(1,1) primary key,
	Name nvarchar(250) null,
	UnitCost decimal(18,0) null,
	Quantity int null,
	Image nvarchar(250) null,
	Description nvarchar(255) null,
	Status nvarchar(30) null,
	ProductType bigint null,
	constraint fk_Product_Category foreign key (ProductType) references Category(ID)
)

ALTER TABLE Product
ALTER COLUMN Status int null

/*1. Code thêm dữ liệu bảng Tài khoản*/
INSERT INTO UserAccount(Username,Password,Status)
VALUES ('yenthanh','thanh123',N'Active'),
	   ('vinhquang','quangquang',N'Active'),
	   ('vanthanh','thanhthanh',N'Blocked'),
	   ('duy','duy123',N'Active'),
	   ('chinh','chinh123',N'Active'),
	   ('quang','quang111',N'Blocked'),
	   ('huuthinh','thinhthinh',N'Active'),
	   ('ngocthao','12345',N'Blocked');
/*2. Code thêm dữ liệu bảng Danh mục*/
INSERT INTO Category (Name, Description)
VALUES (N'Giày Bitis', N'Một thương hiệu lâu năm của Việt Nam'),
	   (N'Giày Bitas',N'Dù ra đời muộn hơn nhiều loại giày nhưng chất lượng vẫn đứng đầu'),
	   (N'Giày Tâm Anh',N'Với 20 năm kinh nghiệm và được đánh giá rất cao trong thị trường'),
	   (N'Giày Midaz',N'Một trong những tên tuổi rất nổi tiếng về giày sneaker ở Việt Nam'),
	   (N'Giày RieNivan',N'Thành lập năm 2012 tại Đà Nẵng đến nay đã có chỗ đứng trên thị trường'),
	   (N'Giày Juno',N'Thương hiệu giày nữ số một Việt Nam');
/*3. Code tạo bảng SanPham*/
INSERT INTO Product(Name,UnitCost,Quantity,Image,Description,Status,ProductType)
VALUES  (N'Giày Sandal Xốp Nam',2000000,200,N'anh1',N'Đế su mềm mại khi đi lại, phù hợp cho học sinh',1,1),
		(N'Giày Para40 News',4500000,250,N'anh2',N'Với thiết kế chắc chắn, bó sát chân hỗ trợ hoạt động thể thao',1,1),
		(N'Giày Sandal TRP X50',3000000,250,N'anh3',N'Thích hợp cho các bạn nữ, phù hợp cho dân văn phòng',1,2),
		(N'Giày Sport X51',3200000,150,N'anh4',N'Thiết kế sang trọng với những chi tiết sắc sảo',1,2),
		(N'Giày Eva Pun',4000000,300,N'anh5',N'Được thiết kế từ những nhà tạo mẫu giày tốt nhất nên chất lượng rất tốt',1,3),
		(N'Giày Evan ATT50',3700000,350,N'anh6',N'Đế giày thoát ẩm giúp bàn chân bạn luôn mềm mại',1,3),
		(N'Giày Patrick Vans',4500000,450,N'anh7',N'Những chất liệu tốt nhất tạo nên đôi giày nên',1,4),
		(N'Giày Sandal Nữ 2021',2000000,300,N'anh8',N'Kết cấu phá cách theo kịp thời đại khiến nó thật tuyệt',1,4),
		(N'Giày Sandal Nam 2021',4000000,270,N'anh9',N'Trẻ trung năng động đó là những gì đôi giày này mang lại cho bạn',1,5),
		(N'Giày Sandal Nữ 2021',2000000,380,N'anh10',N'Bạn không có nhiều tiền, không lo vì đôi giày này đáp ứng cho bạn',1,5);
		
