       Category.CategoryName,
       MenuItem.ItemName,
       Variant.VariantName,
       OrderItem.Quantity,
       OrderItem.UnitPrice,
       OrderItem.Subtotal
FROM OrderItem
INNER JOIN Orders
ON OrderItem.OrderID = Orders.OrderID
INNER JOIN MenuItem
ON OrderItem.MenuItemID = MenuItem.MenuItemID
INNER JOIN Category
ON MenuItem.CategoryID = Category.CategoryID
LEFT JOIN Variant
ON OrderItem.VariantID = Variant.VariantID
ORDER BY Orders.OrderID, OrderItem.OrderItemID;


-- shows modifiers selected for completed orders
SELECT Orders.OrderID,
       MenuItem.ItemName,
       Modifier.ModifierName,
       ModifierChoice.ChoiceName,
       ModifierChoice.AdditionalPrice,
       OrderModifier.Quantity
FROM OrderModifier
INNER JOIN OrderItem
ON OrderModifier.OrderItemID = OrderItem.OrderItemID
INNER JOIN Orders
ON OrderItem.OrderID = Orders.OrderID
INNER JOIN MenuItem
ON OrderItem.MenuItemID = MenuItem.MenuItemID
INNER JOIN ModifierChoice
ON OrderModifier.ModifierChoiceID = ModifierChoice.ModifierChoiceID
INNER JOIN Modifier
ON ModifierChoice.ModifierID = Modifier.ModifierID;


-- shows promotions used in customer orders
SELECT Orders.OrderID,
       Customer.CustomerName,
       Promotion.PromoCode,
       Promotion.PromoDescription,
       OrderPromotion.DiscountAmount
FROM OrderPromotion
INNER JOIN Orders
ON OrderPromotion.OrderID = Orders.OrderID
INNER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
INNER JOIN Promotion
ON OrderPromotion.PromotionID = Promotion.PromotionID;


-- shows customer saved addresses
SELECT Customer.CustomerName,
       AddressBook.AddressLabel,
       AddressBook.Address,
       AddressBook.AddressLine,
       AddressBook.PostalCode
FROM Customer
INNER JOIN AddressBook
ON Customer.CustomerID = AddressBook.CustomerID;


-- shows delivery details
SELECT Customer.CustomerName,
       Orders.OrderID,
       Delivery.DeliveryStatus,
       Delivery.DeliveryDateTime,
       AddressBook.Address,
       AddressBook.AddressLine,
       AddressBook.PostalCode
FROM Delivery
INNER JOIN Orders
ON Delivery.OrderID = Orders.OrderID
INNER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
INNER JOIN AddressBook
ON Delivery.AddressID = AddressBook.AddressID;


-- shows payment details
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


-- shows only currently available menu items
SELECT Category.CategoryName,
       MenuItem.ItemName,
       MenuItem.ItemPrice
FROM MenuItem
INNER JOIN Category
ON MenuItem.CategoryID = Category.CategoryID
WHERE MenuItem.Availability = 'Available'
ORDER BY Category.CategoryID, MenuItem.MenuItemID;
