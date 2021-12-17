-- Productlines --
CREATE TABLE `Productlines` (
  `Productline` VARCHAR(50) NOT NULL,
  `Description` VARCHAR(4000) DEFAULT NULL,
  PRIMARY KEY (`Productline`)
);
INSERT INTO Productlines (Productline,`Description`)VALUES 
('Dell-Laptop','Dell help  your personal productivity with the best peripherals for your home or home office setup.'),
('Hp-laptop','HP is gaming laptops are good, too, especially at lower prices. The HP Pavilion 17 and the HP Omen 15 both feature in our Best Gaming Laptops'),
('Samsung-Mobile','Samsung Galaxy 6.5inch PLS TFT display with 720 X 1600 pixel resolution. Samsung has powered the phone with a Qualcomm snapdragon 450 Octa-core'),
('Computer','A computer is a machine that can be programmed to carry out sequences of arithmetic or logical operations automatically. Modern computers can perform'),
('Hard-disk','A computer is hard drive is a device consisting of several hard disks, read/write heads, a drive motor to spin the disks, and a small amount of circuitry, all sealed in a metal case to protect the disks from dust'),
('Mac Mini','Mac mini is perfect for a surprising range of uses. And with the powerful M1 chip'),
('I-mac','iMac — beautiful, intuitive all-in-one desktops with incredible processors, a Retina display, and the world most advanced desktop operating system.')
;
-- Offices --
CREATE TABLE `Offices` (
  `OfficeCode` INT (10) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `Address` VARCHAR(50) NOT NULL,
  `postalCode` INT (15) NOT NULL,
  PRIMARY KEY (`OfficeCode`)
);
INSERT INTO Offices(OfficeCode,phone,Address,postalCode) VALUES
('320','9821214521','kathmandu','3203'),
('412','082565214','pokhara','4124'),
('329','08245610','Dang','3293'),
('483','9861890232','Butwal','4834'),
('789','01721550','Dharan','7897'),
('672','082560971','Biratnagar','6726');

-- Employees --
CREATE TABLE `Employees` (
  `Employee_Id` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `OfficeCode` INT (10) NOT NULL,
  `Position` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Employee_Id`),
  KEY `OfficeCode` (`OfficeCode`),
  CONSTRAINT `Employees` FOREIGN KEY (`OfficeCode`) REFERENCES `Offices` (`OfficeCode`)
   );
   INSERT INTO Employees (Employee_Id,`Name`,email,OfficeCode,`Position`) VALUES
(1092,'Chitey paudel','chitey@gmail.com',320,'Manager'),
(1011,'Manish Aryhal','Aryal@gmail.com',329,'Officer'),
(3002,'Saroj Neupane','Sneuapnaey@gmail.com',412,'Banch Manager'),
(9081,'paudel ramita','ramita123@gmail.com',483,'Marketing Manager'),
(4532,'manusi pandeys','pandeyse@gmail.com',789,'Officer');

-- Customers --
  CREATE TABLE `Customers` (
  `Customer_Id` INT NOT NULL,
  `Customer_Name` VARCHAR(50) NOT NULL,
  `Phone` VARCHAR(50) NOT NULL,
  `Address` VARCHAR(50) NOT NULL,
  `CustomersNumber` INT DEFAULT NULL,
  `ProductName` VARCHAR(70) NOT NULL,
  KEY `Customer_Id` (`Customer_Id`),
  KEY `ProductName` (`ProductName`),
  CONSTRAINT `Customers` FOREIGN KEY (`Customer_Id`) REFERENCES `Employees` (`Employee_Id`)
);
INSERT INTO Customers (Customer_Id,Customer_Name,Phone,Address,CustomersNumber,ProductName)VALUES
(3002,'Acharya Karan','9876524355','ktm',63,'Dell-laptop 320model'),
(9081,'Karan bk','9871012145','dang',41,'Computer new 14inch'),
(3002,'Bujel Karan','9256548521','birgujn',120,'Hard-disk 500gb'),
(4532,'Manish Karan pandey','9854762102','bhw',89,'I-mac 123rc'),
(9081,'khann tara','9824548794','rolpa',258,'Samsung-Mobile 4gb ram'),
(1011,'bherraj bapana','9876201452','pyuthan',603,'Mac mini 13pro'),
(1092,'Amaninks adhikari','9741251582','makanpur',311,'Hp-laptop 2389model');
 -- Products --
CREATE TABLE `Products` (
  `ProductCode` VARCHAR(15) NOT NULL,
  `ProductName` VARCHAR(70) NOT NULL,
  `Productline` VARCHAR(50) NOT NULL,
  `ProductScale` VARCHAR(10) NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  KEY `ProductName` (`ProductName`),
  KEY `Productline` (`Productline`),
  CONSTRAINT `ProductName` FOREIGN KEY (`ProductName`) REFERENCES `Customers` (`ProductName`),
  CONSTRAINT `Products` FOREIGN KEY (`Productline`) REFERENCES `Productlines` (`Productline`)
);

INSERT INTO Products(ProductCode,ProductName,Productline,ProductScale,Price) VALUES
('220','Dell-laptop 320model','Computer','3:6','68000.98'),
('220','Hard-disk 500gb','Hard-disk','2:15','8000.98'),
('220','Computer new 14inch','Computer','1:8','56988.58'),
('220','I-mac 123rc','Mac Mini','8:10','168000.80');

-- Payments --
CREATE TABLE `Payments` (
  `Customer_Id` INT NOT NULL,
  `CheckNumber` INT NOT NULL,
  `PaymentDate` DATE NOT NULL,
  `Amount` INT NOT NULL,
  PRIMARY KEY (`CheckNumber`),
  KEY `Customer_Id` (`Customer_Id`),
  CONSTRAINT `Payments` FOREIGN KEY (`Customer_Id`) REFERENCES `Customers` (`Customer_Id`)
);

INSERT INTO `Payments`(Customer_Id,CheckNumber,PaymentDate,Amount) VALUES
(3002,3020101,'2078-12-19',10900),
(9081,5821101,'2074-09-19',12900),
(4532,1214542,'2078-02-28',17900),
(3002,9623115,'2077-07-16',19300),
(1011,7012552,'2078-09-09',8500),
(1092,1000276,'2072-11-11',6900);

-- Orders --
CREATE TABLE `Orders` (
  `Order_Num` INT NOT NULL,
  `Order_Date` DATE NOT NULL,
  `Required_Date` DATE NOT NULL,
  `Shipped_Date` DATE DEFAULT NULL,
  `Status` VARCHAR(15) NOT NULL,
  `Comments` TEXT,
  `Customer_Id` INT NOT NULL,
  PRIMARY KEY (`Order_Num`),
  KEY `Customer_Id` (`Customer_Id`),
  CONSTRAINT `Orders` FOREIGN KEY (`Customer_Id`) REFERENCES `Customers` (`Customer_Id`)
);

INSERT INTO Orders (Order_Num,Order_Date,Required_Date,Shipped_Date,`Status`,Comments,Customer_Id)VALUES
(10101,'2078-08-18','2078-09-02','2078-09-01','shipped','Availability',1092),
(10108,'2078-08-18','2078-09-02','2078-09-01','Unshipped','Aftersome time Availability',1011);
