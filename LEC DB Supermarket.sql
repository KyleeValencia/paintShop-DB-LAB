create database [Supermarket]
GO
use [Supermarket]
go
create table StaffBio(
	StaffId char(8) not null,
	StaffName varchar(50),
	StaffGender varchar(15) not null,
	StaffDoB Date not null,
	StaffSalary bigint not null,
	constraint cond_staffId check(StaffId like 'ST[0-9][0-9][0-9][0-9][0-9][0-9]'),
	constraint pk_bioStaff primary key(StaffId),
	constraint cond_BioStaffName check (len(StaffName)>2),
	constraint cond_BioStaffGender check (StaffGender in ('Male','Female')),
	constraint cond_BioStaffSalary check (StaffSalary between 1000000 and 20000000 )
)
go

/*
	-- One staff could have more than one position so that 
		one some of the position they table have its own subsidy 
		that not affect by its annual salary
	-- So, Making a List of Staff data and its position, since one staff could have multiple 
	-- Position
*/
Create table StaffTypePosition(
	StaffPositionId char(5) not null,
	PositionName varchar(40) not null,	
	StaffPositionSalary bigint not null,
	StaffPositionSubsidy bigint default 0,
	constraint PK_StaffTypePosition primary key (StaffpositionId),
	constraint cond_StaffTypePositionName check (len(PositionName)>2),
	constraint cond_StaffTypePositionId check(StaffPositionId like 'SP[0-9][0-9][0-9]') 
)
go
create table StaffListPosition(
	StaffId char(5) not null,
	StaffPositionId char(5) not null,
	constraint FK_StaffIdPositionList foreign key(StaffId) references StaffBio(StaffId),
	constraint FK_StaffPositionIdPositionList foreign key (StaffPositionId) references StaffTypePosition(StaffPositionId)
)
go
create table Supplier(
	SupplierId char(5) not null,
	SupplierName varchar(30)not null,
	SupplierWorkPhoneNumber varchar(20)not null,
	SupplierAddress varchar(60)not null,
	constraint cond_SupplierName check (len(SupplierName)>2),
	constraint cond_SupplierWorkPhoneNumber check (SupplierWorkPhoneNumber like '08%'),
	constraint PK_SupplierBio primary key(SupplierId)
)
go
/*
  Create trigger to reduce stock from Sale 
  and Trigger to add stock from purchase 
  (Combine trigger and Procedure)
*/
/*
	Can one product come from multiple Supplier ?
*/
create table Product (
	ProductId char (12) not null,
	ProductName varchar (20) not null,
	Stock int not null,
	ReOrderStock int not null,-- The quantity for an item to ensure the store doesn't run out product
	OrderStock int not null -- The limit of item should be keep for an item to ensure it not overflow,
	constraint PK_ProductId primary key(ProductId)
)
go
create table ProductCategory(
	ProductCategoryId char(8) not null,
	ProductCategoryName varchar(100) not null,
	constraint UNQ_ProductCategoryName unique(ProductCategoryName),
	constraint PK_ProductNameCategoryId primary key(ProductCategoryId)
)
go
create table ProductDataAndCategoryList(
	ProductId char(12) not null,
	ProductCategoryId char(8) not null,
	constraint CK_ProductDataAndCategoryList primary key(ProductId, ProductCategoryId),
	constraint FK_ProductIdProductDataAndCategoryList foreign key(ProductId) 
		references Product(ProductId),
	constraint FK_ProductCategoryIdProductDataAndCategoryList 
		foreign key(ProductCategoryId) references ProductCategory(ProductCategoryId)
)
go
-- One supplier can have more than one product given
create table SupplierProduct (
	SupplierId char(5) not null,
	ProductId char(12) not null,
	constraint FK_ProductListSupplierId foreign key(SupplierId) references Supplier(SupplierId),
	constraint FK_ProductListProductId foreign key (ProductId) references Product(ProductId),
	constraint CK_SupplierProduct primary key(SupplierId,ProductId)
)
go
create table PurchasePaymentType (
	PurchasePaymentTypeName varchar(30) not null,
	PurchasePaymentTypeID char(6) not null,
	constraint PK_PurchasePaymentTypeID primary key(PurchasePaymentTypeId) ,
	constraint UNQ_PurchasePaymentTypeName unique(PurchasePaymentTypeName),
	constraint UNQ_PurchasepaymentTypeID unique(PurchasePaymentTypeID)
)
go
create table PurchaseTransactionHeader (
	HandleStaff char(5) not null,
	PurchaseTransactionID char(5) not null,
	TypeofPurchase varchar(20) not null,
	SupplierId char(5)not null,
	PurchaseDate date not null,
	constraint PK_PurchaseTransactionheader primary key(PurchaseTransactionID)
)
go
create table PurchaseTransactionDetail(
	PurchaseTransactionID char(5) not null,
	ProductId char (6) not null,
	qtyPurchase int not null,
	PurchasePaymentTypeId char(6) not null,
	constraint FK_PurchaseTransactionID_TransactionDetail 
		foreign key (PurchaseTransactionID) 
	constraint FK_ProductID_PurchaseDetail foreign key(ProductId)
		references Product(ProductId),
		references PurchaseTransactionHeader(PurchaseTransactionID ),
	constraint CK_PurchaseTransactionDetail 
		primary key(PurchaseTransactionID, ProductId),
	constraint cond_qtyPurchase check (qtyPurchase > 0)
)
go
create table Customerbio(
	CustomerID char(42) not null,
	CustomerPhoneNumber char(20) not null,
	CustomerName varchar(30) not null,
	CustomerGender varchar(15) not null,
	CustomerType varchar(20) not null,
	constraint PK_Customerbio primary key(CustomerID), 
	constraint cond_CustomerTypeBio check(CustomerType in ('Member','Normal')
)
go
create table SaleTransactionHeader (
	HandleStaffID char(5) not null,
	SaleID char(5) not null,
	TypeofSale varchar(20) not null,
	CustomerId char(5)not null,
	SaleDate date not null,
	SalePaymentType char(6) not null,
	constraint PK_SaleTransactionheader primary key(SaleID),
	constraint FK_HandleStaffSaleHeader foreign key(HandleStaffID)
		references StaffBio(StataffId)

)
go
create table SaleTransactionDetail (
	SaleID char(5) not null,
	ProductId char(5) not null,
	qty int not null,
	constraint CK_SaleTransactionDetail primary key(SaleID, ProductId),
	constraint FK_SaleTransactionDetail_ProductId foreign key(ProductId)
		references Product(ProductId),
	constraint FK_SaleTransactionDetail_SaleId foreign key(SaleId)
		references SaleTransactionHeader(SaleID)
)

      
