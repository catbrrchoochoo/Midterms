-- hellooo, add comment with your last name before each entity like ginawa ko below so kabalo ko aha mo naghelp


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
  StoreID INTEGER,
  StoreName VARCHAR(50),
  StorePhoneNumber VARCHAR(20),
  StoreAddress VARCHAR(150),
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
  AddressLabel VARCHAR(10),
  AddressLine VARCHAR(50),
  PostalCode VARCHAR(10),
  PRIMARY KEY (AddressID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


-- bayquen
CREATE TABLE PaymentMethod (
  PaymentMethodID INTEGER,
  CustomerID INTEGER,
  MethodType VARCHAR(30),
  CardCompany VARCHAR(30),
  CardLastFour VARCHAR(4),
  PRIMARY KEY (PaymentMethodID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE MenuItem (
  MenuItemID INTEGER,
  CategoryID INTEGER,
  ItemName VARCHAR(100),
  ItemDescription VARCHAR(255),
  ItemPrice DECIMAL(5,2),
  Availability VARCHAR(20),
  PRIMARY KEY (MenuItemID),
  FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);


-- enriquez
-- stores versions of an item such as normal or truffle
CREATE TABLE Variant (
  VariantID INTEGER,
  MenuItemID INTEGER,
  VariantName VARCHAR(50),
  VariantPrice DECIMAL(5,2),
  PRIMARY KEY (VariantID),
  FOREIGN KEY (MenuItemID) REFERENCES MenuItem(MenuItemID)
);


-- enriquez
-- stores groups of optional choices such as add on drinks
CREATE TABLE Modifier (
  ModifierID INTEGER,
  ModifierName VARCHAR(50),
  MinimumSelection INTEGER,
  MaximumSelection INTEGER,
