-- hellooo, add comment with your last name before each entity like ginawa ko below so kabalo ko aha mo naghelp
-- matic 10 sa eval basta may ginawa kayo thanksu, i'll check this saturday night lang para ipolish n whatevs

-- bayquen
CREATE TABLE Customer (
  CustomerID INTEGER,
  CustomerName VARCHAR(50),
  CustomerEmail VARCHAR(100),
  CustomerPhoneNumber VARCHAR(20),
  OrganizationName VARCHAR(100),
  PRIMARY KEY (CustomerID)
);

-- bayquen
CREATE TABLE Store (
  -- test
  StoreID INTEGER,
  StoreName VARCHAR(50),
  StorePhoneNumber VARCHAR(20),
  StoreAddress VARCHAR(100),
  PRIMARY KEY (StoreID)
);

-- atienza
CREATE TABLE OrderType ( 
  OrderTypeID INTEGER, 
  OrderTypeName VARCHAR(30),
  PRIMARY KEY (OrderTypeID)
);

-- diaz
CREATE TABLE Category (
  CategoryID INTEGER,
  CategoryName VARCHAR(50),
  PRIMARY KEY (CategoryID) 
);

-- atienza
CREATE TABLE AddressBook (
   AddressID INTEGER,
   CustomerID INTEGER,
   Address VARCHAR(100), 
   AddressLabel  VARCHAR(10), -- "Home" or "Work" or "School"
   AddressLine VARCHAR(50),
   PostalCode INT(4), -- "8000"
   PRIMARY KEY (AddressID),
   FOREIGN KEY (CustomerID)
   REFERENCES Customer(CustomerID)
);

--bayquen
CREATE TABLE PaymentMethod (

);

CREATE TABLE MenuItem (

);

-- might change name of this entity, kay mag error siya if dili nako butngan ug ingana from akong gisearch (feel free to erase this comment)
CREATE TABLE `Order` ( 

);

-- diaz
CREATE TABLE OrderItem (
  OrderItemID INTEGER,
  OrderID INTEGER,
  MenuItemID INTEGER,
  Quantity INTEGER,
  UnitPrice DECIMAL(10,2),
  Subtotal DECIMAL(10,2),
  PRIMARY KEY (OrderItemID),
  FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
  FOREIGN KEY (MenuItemID) REFERENCES MenuItem(MenuItemID) 
);

-- diaz
CREATE TABLE Delivery (
  DeliveryID INTEGER,
  OrderID INTEGER,
  AddressID INTEGER,
  DeliveryStatus VARCHAR(20),
  DeliveryDateTime DATETIME,
  PRIMARY KEY (DeliveryID),
  FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
  FOREIGN KEY (AddressID) REFERENCES AddressBook(AddressID)
);

CREATE TABLE Payment (

);

-- insert data next
