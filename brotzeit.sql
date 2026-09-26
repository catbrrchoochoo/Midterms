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
   AddressLabel VARCHAR(10), -- "Home" or "Work" or "School"
   AddressLine VARCHAR(50),
   PostalCode VARCHAR(10), -- "8000"
   PRIMARY KEY (AddressID),
   FOREIGN KEY (CustomerID)
   REFERENCES Customer(CustomerID)
);

--bayquen
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

-- renamed
CREATE TABLE Orders ( 
    OrderID INTEGER,
    CustomerID INTEGER,
    StoreID INTEGER,
    OrderDateTime DATETIME,
    OrderTypeID INTEGER,
    OrderStatus VARCHAR(30),
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
    FOREIGN KEY (OrderTypeID) REFERENCES OrderType(OrderTypeID)
);

-- diaz
CREATE TABLE OrderItem (
  OrderItemID INTEGER,
  OrderID INTEGER,
  MenuItemID INTEGER,
  Quantity INTEGER,
  UnitPrice DECIMAL(5,2),
  Subtotal DECIMAL(10,2),
  PRIMARY KEY (OrderItemID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
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
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (AddressID) REFERENCES AddressBook(AddressID)
);

CREATE TABLE Payment (
    PaymentID INTEGER,
    OrderID INTEGER,
    PaymentMethodID INTEGER,
    PaymentAmount DECIMAL(10,2),
    PaymentStatus VARCHAR(20),
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID)
);

-- insert data next
INSERT INTO Customer VALUES
(10001, 'Anna Lim', 'anna.lim@email.com', '+6591234567', NULL),
(10002, 'Marcus Tan', 'marcus.tan@email.com', '+6598765432', 'Tan Solutions'),
(10003, 'Sofia Lee', 'sofia.lee@email.com', '+6595551234', NULL),
(10004, 'Daniel Wong', 'daniel.wong@email.com', '+6598877665', NULL),
(10005, 'Rachel Ng', 'rachel.ng@email.com', '+6593344556', 'Ng Trading');


INSERT INTO Store VALUES
(20001, 'Brotzeit VivoCity', '+6562728815', '1 HarbourFront Walk, Singapore'),
(20002, 'Brotzeit Raffles City', '+6563379944', '252 North Bridge Road, Singapore'),
(20003, 'Brotzeit Westgate', '+6564632691', '3 Gateway Drive, Singapore'),
(20004, 'Brotzeit Stanley Street', '+6562234590', '30 Stanley Street, Singapore');


INSERT INTO OrderType VALUES
(1, 'Pickup'),
(2, 'Delivery');


INSERT INTO Category VALUES
(30001, 'Bundles'),
(30002, 'Starters'),
(30003, 'Mains'),
(30004, 'Sides'),
(30005, 'Desserts'),
(30006, 'Beverages');


INSERT INTO AddressBook VALUES
(40001, 10001, '10 Orchard Road', 'Home', '#05-12', '238840'),
(40002, 10001, '1 Raffles Place', 'Office', '#20-01', '048616'),
(40003, 10002, '25 Marina Boulevard', 'Office', '#14-03', '018989'),
(40004, 10003, '8 Sentosa Gateway', 'Home', '#03-15', '098269'),
(40005, 10004, '15 Clementi Road', 'Home', '#07-02', '129748'),
(40006, 10005, '20 Jurong East Street', 'Office', '#10-05', '609601');


INSERT INTO PaymentMethod VALUES
(50001, 10001, 'Card', 'Visa', '4821'),
(50002, 10002, 'Card', 'Mastercard', '7742'),
(50003, 10003, 'Card', 'Visa', '1098'),
(50004, 10004, 'Card', 'Mastercard', '5512'),
(50005, 10005, 'Card', 'Visa', '8803');


INSERT INTO MenuItem VALUES
(60001, 30002, 'Pretzel', 'Traditional German baked pretzel', 8.00, 'Available'),
(60002, 30003, 'Pork Knuckle', 'Crispy roasted pork knuckle', 42.00, 'Available'),
(60003, 30003, 'Chicken Schnitzel', 'Breaded chicken schnitzel', 28.00, 'Available'),
(60004, 30004, 'Truffle Fries', 'Fries with truffle seasoning', 12.00, 'Available'),
(60005, 30005, 'Apple Strudel', 'Warm apple strudel dessert', 14.00, 'Available'),
(60006, 30006, 'Apple Juice', 'Chilled apple juice', 6.00, 'Available'),
(60007, 30001, 'Brotzeit Family Bundle', 'Selection of Brotzeit favourites', 88.00, 'Available'),
(60008, 30003, 'Sausage Platter', 'Assorted German sausages', 36.00, 'Unavailable');


INSERT INTO Orders VALUES
(70001, 10001, 20001, '2026-09-24 12:30:00', 2, 'Completed'),
(70002, 10002, 20002, '2026-09-24 13:15:00', 1, 'Completed'),
(70003, 10003, 20003, '2026-09-24 18:00:00', 2, 'Preparing'),
(70004, 10004, 20004, '2026-09-25 11:00:00', 1, 'Completed'),
(70005, 10005, 20001, '2026-09-25 14:20:00', 2, 'Preparing');


INSERT INTO OrderItem VALUES
(80001, 70001, 60002, 1, 42.00, 42.00),
(80002, 70001, 60001, 2, 8.00, 16.00),
(80003, 70001, 60006, 2, 6.00, 12.00),
(80004, 70002, 60003, 1, 28.00, 28.00),
(80005, 70002, 60004, 1, 12.00, 12.00),
(80006, 70003, 60007, 1, 88.00, 88.00),
(80007, 70003, 60005, 1, 14.00, 14.00),
(80008, 70004, 60002, 1, 42.00, 42.00),
(80009, 70004, 60006, 1, 6.00, 6.00),
(80010, 70005, 60003, 2, 28.00, 56.00),
(80011, 70005, 60001, 1, 8.00, 8.00);


INSERT INTO Delivery VALUES
(90001, 70001, 40001, 'Delivered', '2026-09-24 13:20:00'),
(90002, 70003, 40004, 'On the way', '2026-09-24 19:00:00'),
(90003, 70005, 40006, 'Preparing', '2026-09-25 15:10:00');


INSERT INTO Payment VALUES
(91001, 70001, 50001, 70.00, 'Paid'),
(91002, 70002, 50002, 40.00, 'Paid'),
(91003, 70003, 50003, 102.00, 'Paid'),
(91004, 70004, 50004, 48.00, 'Paid'),
(91005, 70005, 50005, 64.00, 'Paid');


-- shows all customer records
SELECT * FROM Customer;

-- shows all store records
SELECT * FROM Store;

-- shows the available order types such as pickup and delivery
SELECT * FROM OrderType;

-- shows all menu categories
SELECT * FROM Category;

-- shows all saved customer addresses
SELECT * FROM AddressBook;

-- shows all saved customer payment methods
SELECT * FROM PaymentMethod;

-- shows all menu items and their details
SELECT * FROM MenuItem;

-- shows all customer orders
SELECT * FROM Orders;

-- shows all individual items included in orders
SELECT * FROM OrderItem;

-- shows all delivery records
SELECT * FROM Delivery;

-- shows all payment records
SELECT * FROM Payment;


-- shows menu items together with their category
SELECT MenuItem.MenuItemID,
       MenuItem.ItemName,
       MenuItem.ItemDescription,
       MenuItem.ItemPrice,
       Category.CategoryName
FROM MenuItem
INNER JOIN Category
ON MenuItem.CategoryID = Category.CategoryID;


-- shows which customer made each order and its status
SELECT Customer.CustomerName,
       Orders.OrderID,
       Orders.OrderDateTime,
       Orders.OrderStatus
FROM Customer
INNER JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;


-- shows each order together with the customer, store, and order type
SELECT Customer.CustomerName,
       Orders.OrderID,
       Store.StoreName,
       OrderType.OrderTypeName
FROM Orders
INNER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
INNER JOIN Store
ON Orders.StoreID = Store.StoreID
INNER JOIN OrderType
ON Orders.OrderTypeID = OrderType.OrderTypeID;


-- shows the menu items included in each order and their quantity and price
SELECT Orders.OrderID,
       MenuItem.ItemName,
       OrderItem.Quantity,
       OrderItem.UnitPrice,
       OrderItem.Subtotal
FROM OrderItem
INNER JOIN Orders
ON OrderItem.OrderID = Orders.OrderID
INNER JOIN MenuItem
ON OrderItem.MenuItemID = MenuItem.MenuItemID;


-- shows each customer together with their saved addresses
SELECT Customer.CustomerName,
       AddressBook.AddressLabel,
       AddressBook.Address,
       AddressBook.AddressLine,
       AddressBook.PostalCode
FROM Customer
INNER JOIN AddressBook
ON Customer.CustomerID = AddressBook.CustomerID;


-- shows delivery details together with the customer and delivery address
SELECT Customer.CustomerName,
       Orders.OrderID,
       Delivery.DeliveryStatus,
       Delivery.DeliveryDateTime,
       AddressBook.Address
FROM Delivery
INNER JOIN Orders
ON Delivery.OrderID = Orders.OrderID
INNER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
INNER JOIN AddressBook
ON Delivery.AddressID = AddressBook.AddressID;


-- shows payment details together with the customer and payment method
SELECT Customer.CustomerName,
       Orders.OrderID,
       Payment.PaymentAmount,
       Payment.PaymentStatus,
       PaymentMethod.MethodType,
       PaymentMethod.CardCompany
FROM Payment
INNER JOIN Orders
ON Payment.OrderID = Orders.OrderID
INNER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
INNER JOIN PaymentMethod
ON Payment.PaymentMethodID = PaymentMethod.PaymentMethodID;


-- shows only menu items that are currently available
SELECT MenuItem.ItemName,
       MenuItem.ItemPrice
FROM MenuItem
WHERE MenuItem.Availability = 'Available';
