create database [PAinT Shop (LAb Db Project)]
GO
use [PAinT Shop (LAb Db Project)]
go
create table StaffBio(
	StaffId char(5) not null,
	StaffName varchar(50) not null,
	StaffGender varchar(15) not null,
	StaffDoB Date not null,
	StaffSalary bigint not null,
	constraint pk_bioStaff primary key(StaffId),
	constraint cond_bioStaffId check(StaffId like 'ST[0-9][0-9][0-9]'),
	constraint cond_bioStaffName check (len(StaffName)>2),
	constraint cond_bioStaffGender check (StaffGender in ('Male','Female')),
	constraint cond_bioStaffSalary check (StaffSalary between 1000000 and 20000000 )
)
go
Create table StaffTypePosition(
	StaffPositionId char(5) not null,
	PositionName varchar(40) not null,
	constraint PK_StaffTypePosition primary key (StaffpositionId),
	constraint cond_PositionName check (len(PositionName)>2),
	constraint cond_StaffPositionId check(StaffPositionId like 'SP[0-9][0-9][0-9]') 
)
go
create table StaffPosition(
	StaffPositionId char(5),
	StaffId char(5),
	constraint cond_staffPosId check(StaffPositionId like 'SP[0-9][0-9][0-9]'),
	constraint PK_StaffPosition primary key(StaffPositionId, StaffId),
	Constraint FK_StaffBio foreign key (StaffId) references StaffBio(StaffId),
	constraint FK_StaffTypePosition foreign key (StaffPositionId) references StaffTypePosition(StaffPositionId)
)
go
create table VendorBio(
	VendorId char(5) not null,
	VendorName varchar(30)not null,
	VendorWorkPhoneNumber varchar(20)not null,
	VendorAddress varchar(60)not null,
	constraint cond_VendorName check (len(VendorName)>2),
	constraint cond_WorkPhoneNumber check (VendorWorkPhoneNumber like '08%'),
	constraint cond_VendorID check (VendorId like 'VE[0-9][0-9][0-9]'),
	constraint PK_VendorBio primary key(VendorId)
)
go
create table ColorType(
	ColorId char(5) not null,
	ColorName varchar(70),
	constraint PK_ColorType primary key(ColorId),
	constraint cond_ColorId check (ColorId like 'CO[0-9][0-9][0-9]'),
	constraint cond_ColorName check (len(ColorName)>2)
)
go
create table Paint(
	PaintId char(5) not null,
	constraint cond_PaintId check(PaintId like 'PA[0-9][0-9][0-9]'),
	constraint PK_PaintId primary key(PaintId),
	Stock int not null,
	Price bigint not null,
	constraint cond_Price check (Price >1000),
	constraint cond_Stock check (Stock >=0),
	ColorId char(5) not null,
	constraint FK_ColorId foreign key(ColorId) references ColorType(ColorId)
)
go
create table CustomerBio(
	CustomerId char(5) not null,
	CustomerName varchar(30) not null,
	CustomerPhoneNumber varchar(20) not null,
	CustomerAddress varchar(60) not null,
	CustomerGender varchar(17) not null,
	CustomerDoB date not null,
	constraint PK_CustomerID primary key(CustomerId),
	constraint cond_CustomerId check (CustomerId like 'CU[0-9][0-9][0-9]'),
	constraint cond_CustomerName check (len(CustomerName )>2),
	constraint cond_CustomerPhoneNumber check (CustomerPhoneNumber like '08%'),
	constraint cond_CustomerGender check (CustomerGender in ('Male','Female')) 
)
go
create table PurchasePaymentType(
	PurchasePaymentTypeId char(6) not null,
	PurchasePaymentName varchar(50) not null,
	constraint PK_PurchasePaymentype primary key (PurchasePaymentTypeId),
	constraint cond_PK_PurchasePaymentype check(PurchasePaymentTypeId like 'PPT[0-9][0-9][0-9]'),
	constraint cond_PurchasePaymentName check (PurchasePaymentName in ('Cash','Consignment','TermPayment'))
)
go
create table SalePaymentType(
	SalePaymentTypeId char(6) not null,
	SalePaymentName varchar(50) not null,
	constraint PK_SalePaymentypeId primary key (SalePaymentTypeId),
	constraint cond_PK_SalePaymentype check(SalePaymentTypeId like 'PT[0-9][0-9][0-9]'),
	constraint cond_SalePaymentName check (SalePaymentName in ('Cash','QRis','Credit','Debit'))
)
go
create table PurchaseHeaderTransaction(
	 PurchaseTransactionID char (5),
	 constraint PK_PurchaseHeaderID primary key (PurchaseTransactionID),
	 constraint cond_PurchaseHeaderID check (PurchaseTransactionID like 'PR[0-9][0-9][0-9]'),
	 VendorId char(5) not null,
	 HandleStaffId char(5) not null ,
	 TransactionDate date not null,
	 PurchasepaymentTypeId char(6) not null,
	 constraint cond_PurchaseTransactionDate check (Year(TransactionDate)=2021),
	 constraint FK_VendorId_PurchaseHeaderTransaction
		foreign key (VendorId) references VendorBio(VendorId)
)
go
create table PurchaseDetailTransaction(
	PurchaseTransactionID char(5) not null,
	PaintId char(5) not null,
	qtyBuy int not null,1`
)
go
create table SaleTransactionHeader (
	HandleStaff char(5) not null,
	SaleID char(5) not null,
	TypeofSale varchar(20) not null,
	CustomerId char(5)not null,
	SaleDate date not null,
	constraint PK_SaleTransactionheader primary key(SaleID),
	constraint cond_SaleIdTransactionHeader check (SaleID like 'SA[0-9][0-9][0-9]'),
	constraint cond_SaleTransactionDate check (Year(SaleDate)=2021)

)
go
create table SaleTransactionDetail (
	SaleID char(5) not null,
	PaintId char(5) not null,
	qtySale int not null

)



use master


select GETDATE()

drop database [PAinT Shop (LAb Db Project)]

