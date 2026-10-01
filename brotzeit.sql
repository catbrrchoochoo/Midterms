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
-- stores different versions of a menu item such as normal or truffle
CREATE TABLE MenuItemVariant (
  VariantID INTEGER,
  MenuItemID INTEGER,
  VariantName VARCHAR(50),
  VariantPrice DECIMAL(5,2),
  PRIMARY KEY (VariantID),
  FOREIGN KEY (MenuItemID) REFERENCES MenuItem(MenuItemID)
);


-- enriquez
-- stores groups of optional add-ons
CREATE TABLE ModifierGroup (
  ModifierGroupID INTEGER,
  ModifierGroupName VARCHAR(50),
  MinimumSelection INTEGER,
  MaximumSelection INTEGER,
  PRIMARY KEY (ModifierGroupID)
);


-- enriquez
-- stores choices inside each modifier group
CREATE TABLE ModifierOption (
  ModifierOptionID INTEGER,
  ModifierGroupID INTEGER,
  ModifierOptionName VARCHAR(100),
  AdditionalPrice DECIMAL(5,2),
  PRIMARY KEY (ModifierOptionID),
  FOREIGN KEY (ModifierGroupID) REFERENCES ModifierGroup(ModifierGroupID)
);


-- enriquez
-- connects menu items to the modifier groups available for them
CREATE TABLE MenuItemModifier (
  MenuItemModifierID INTEGER,
  MenuItemID INTEGER,
  ModifierGroupID INTEGER,
  PRIMARY KEY (MenuItemModifierID),
  FOREIGN KEY (MenuItemID) REFERENCES MenuItem(MenuItemID),
  FOREIGN KEY (ModifierGroupID) REFERENCES ModifierGroup(ModifierGroupID)
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
  VariantID INTEGER,
  Quantity INTEGER,
  UnitPrice DECIMAL(5,2),
  Subtotal DECIMAL(10,2),
  PRIMARY KEY (OrderItemID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (MenuItemID) REFERENCES MenuItem(MenuItemID),
  FOREIGN KEY (VariantID) REFERENCES MenuItemVariant(VariantID)
);


-- enriquez
-- records modifiers actually selected by a customer
CREATE TABLE OrderItemModifier (
  OrderItemModifierID INTEGER,
  OrderItemID INTEGER,
  ModifierOptionID INTEGER,
  Quantity INTEGER,
  PRIMARY KEY (OrderItemModifierID),
  FOREIGN KEY (OrderItemID) REFERENCES OrderItem(OrderItemID),
  FOREIGN KEY (ModifierOptionID) REFERENCES ModifierOption(ModifierOptionID)
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
(10001, 'Rin Kusigaki', 'RKusigaki@email.com', '+6599183282', NULL),
(10002, 'Ryota Shinku', 'RyotaShinku@email.com', '+6598765432', 'Japan Solutions'),
(10003, 'Shin Hikagami', 'SHikagami@email.com', '+6595551234', NULL),
(10004, 'Gin Yosuke', 'GinYosuke@email.com', '+6598877665', NULL),
(10005, 'Nobara Fins', 'NFins@email.com', '+6593344556', 'Nobara Trading'),
(10006, 'Inosuke Ryuu', 'InosukeR@email.com', '+6533889510', NULL),
(10007, 'Hinata Shugen', 'HinataS@email.com', '+6558903722', 'Linear Corp'),
(10008, 'Jugen Morgen', 'JugenMorgen@email.com', '+6595598765', 'Survey Corps'),
(10009, 'Kin Jusuke', 'KinJusuke@email.com', '+6552907162', NULL),
(10010, 'Eren Rosuke', 'ErenRosuke@email.com', '+6535820185', 'Jin Poly');


-- actual brotzeit singapore stores
INSERT INTO Store VALUES
(20001, 'Brotzeit CBD', '+6597884230', '30 Stanley Street, Singapore 068739'),
(20002, 'Brotzeit Vivocity', '+6562728815', '1 HarbourFront Walk, #01-149, Singapore 098585'),
(20003, 'Brotzeit Raffles City', '+6568831534', '252 North Bridge Road, #01-17, Singapore 179103'),
(20004, 'Brotzeit Westgate', '+6564659874', '3 Gateway Drive, #01-04, Singapore 608532');


INSERT INTO OrderType VALUES
(1, 'Pickup'),
(2, 'Delivery');


-- all categories shown on the brotzeit online menu
INSERT INTO Category VALUES
(30001, 'Oktoberfest'),
(30002, 'Bundles'),
(30003, 'Signature & Platter'),
(30004, 'Schnitzel'),
(30005, 'Sausages'),
(30006, 'Classic'),
(30007, 'Brotzeit'),
(30008, 'Salad'),
(30009, 'Snacks'),
(30010, 'Sides'),
(30011, 'Desserts'),
(30012, 'Drinks'),
(30013, 'Bubbles & White Wine'),
(30014, 'Red Wines & Others'),
(30015, 'Alpine Spirits');


INSERT INTO AddressBook VALUES
(40001, 10001, '10 Orchard Road', 'Home', '#05-12', '238840'),
(40002, 10002, '1 Raffles Place', 'Office', '#20-01', '048616'),
(40003, 10003, '25 Marina Boulevard', 'Office', '#14-03', '018989'),
(40004, 10004, '8 Sentosa Gateway', 'Home', '#03-15', '098269'),
(40005, 10005, '15 Clementi Road', 'Home', '#07-02', '129748'),
(40006, 10006, '20 Jurong East Street', 'Office', '#10-05', '609601'),
(40007, 10007, '16 Market Street', 'Home', '#06-10', '048940'),
(40008, 10008, '5 Purvis Street', 'Office', '#18-06', '188584'),
(40009, 10009, '28 Beach Road', 'Home', '#07-02', '189762'),
(40010, 10010, '2 Marina Boulevard', 'Office', '#02-13', '018987');


INSERT INTO PaymentMethod VALUES
(50001, 10001, 'Card', 'Visa', '4821'),
(50002, 10002, 'Card', 'Mastercard', '7742'),
(50003, 10003, 'Card', 'Visa', '1098'),
(50004, 10004, 'Card', 'Mastercard', '5512'),
(50005, 10005, 'Card', 'Visa', '8803'),
(50006, 10006, 'Card', 'Mastercard', '5680'),
(50007, 10007, 'Card', 'Visa', '6610'),
(50008, 10008, 'Card', 'Mastercard', '2045'),
(50009, 10009, 'Card', 'Visa', '7244'),
(50010, 10010, 'Card', 'Mastercard', '9115');



-- all menu items shown on the brotzeit online menu
INSERT INTO MenuItem VALUES

-- oktoberfest
(60001, 30001, 'Oktoberfest Grand Party Bundle', 'Suitable for 10-15 persons', 598.00, 'Available'),
(60002, 30001, 'Oktoberfest Celebration Bundle', 'Suitable for 5-8 persons', 268.00, 'Available'),
(60003, 30001, 'Oktoberfest Mini Bundle', 'Suitable for 4-5 persons', 168.00, 'Available'),
(60004, 30001, 'Oktoberfest Platter', 'Signature Pork Knuckle, Crispy Roasted Pork Belly, sausages and sides', 158.00, 'Available'),
(60005, 30001, 'Crispy Roasted Pork Belly', 'Crispy Roasted Pork Belly, White Cabbage Salad, Traditional Bread Dumplings, Whole Grain Mustard Gravy', 48.00, 'Available'),
(60006, 30001, 'Stuffed Chicken Breast', 'Bacon Wrapped and Spinach Stuffed Chicken Breast with Mashed Potatoes and Creamy Chanterelle Mushrooms', 32.00, 'Available'),
(60007, 30001, 'Schnitzel "Munich Style"', 'Horseradish and Mustard Marinated Pork Schnitzel, Potato Cucumber Salad, Cranberry Sauce', 30.00, 'Available'),
(60008, 30001, 'Fish on Stick', 'BBQ Fish on Stick with Spiced Potato Wedges', 28.00, 'Available'),
(60009, 30001, 'Bread Dumplings with Chanterelles', 'Traditional Bread Dumplings with Creamy Chanterelle Mushroom Sauce', 25.00, 'Available'),
(60010, 30001, 'Regensburger Sausage', '220gm Smoked Pork and Beef Sausage, Bacon Sauerkraut, Roasted Potatoes', 25.00, 'Available'),
(60011, 30001, 'Chilli & Cheese Meatloaf', 'Hearty Chilli and Cheese Meatloaf, Potato Salad, Sunny Side Up Egg', 24.00, 'Available'),
(60012, 30001, 'Munich Weisswurst', 'Classic Munich Weisswurst with Baked Pretzel and Sweet Mustard', 19.00, 'Available'),
(60013, 30001, 'Gratinated Pretzel', 'Cheese and Onion Gratinated Bavarian Pretzel', 8.00, 'Available'),

-- bundles
(60014, 30002, 'Birthday Bundle (up to 10 persons)', 'Pretzel, Brotzeit Cold Cut, Brotzeit Platters, Apple Strudel and Chocolate Mud Cake', 330.00, 'Available'),

-- signature & platter
(60015, 30003, 'Signature Pork Knuckle', 'Signature Pork Knuckle, Potato Salad, Bacon Sauerkraut', 45.00, 'Available'),
(60016, 30003, 'Best of Brotzeit', 'Signature Pork Knuckle and Premium Sausage Selection for sharing', 90.00, 'Available'),
(60017, 30003, 'Signature Brotzeit Platter', 'Crispy Pork Knuckle, Bavarian Honey Glazed Pork Ribs, Pork Schnitzels and Premium Sausage Selection', 145.00, 'Available'),
(60018, 30003, 'Small Brotzeit Platter', 'Crispy Pork Knuckle, Half Oven Roasted Chicken, Premium Sausage Selection, Bacon Sauerkraut and Potato Salad', 120.00, 'Available'),

-- schnitzel
(60019, 30004, 'Wiener Schnitzel', 'Wiener Schnitzel with Parsley Potato and Cranberry Sauce', 42.00, 'Available'),
(60020, 30004, 'Pork Schnitzel', 'Pork Schnitzel, French Fries, Cranberry Sauce', 29.50, 'Available'),
(60021, 30004, 'Chicken Schnitzel', 'Chicken Schnitzel, Potato Salad, Cranberry Sauce', 29.50, 'Available'),
(60022, 30004, 'Grilled Chicken Schnitzel', 'Grilled Chicken Schnitzel, Butter Rice, Creamy Mushroom Sauce', 29.50, 'Available'),
(60023, 30004, 'Jägerschnitzel with Fries', 'Golden Fried Pork Schnitzel, French Fries, Creamy Mushroom Sauce', 34.00, 'Available'),
(60024, 30004, 'Jägerschnitzel with Butter Spätzle', 'Golden Fried Pork Schnitzel, Butter Spätzle, Creamy Mushroom Sauce', 34.00, 'Available'),

-- sausages
(60025, 30005, 'Sausage Platter', '600gm Premium Sausage Selection, Roasted Potatoes, Bacon Sauerkraut and Pickles', 45.00, 'Available'),
(60026, 30005, 'Berliner Currywurst', 'Original Berlin Currywurst, French Fries, Mayonnaise', 20.00, 'Available'),
(60027, 30005, 'Thüringer Sausage', 'Thüringer Snail Sausage, Mashed Potato, Bacon Sauerkraut, Onion Gravy', 22.00, 'Available'),
(60028, 30005, 'Nürnberger Sausages', 'Nürnberger Pork Sausages, Mashed Potatoes, Bacon Sauerkraut', 22.00, 'Available'),
(60029, 30005, 'Smoked Chicken Cheese Sausage', 'Smoked Chicken Cheese Sausages, Mashed Potato, Bacon Sauerkraut', 21.50, 'Available'),
(60030, 30005, 'Pork Cheese Sausage', 'Pork Cheese Sausage, White Cabbage Salad, Potato Salad, Horseradish', 22.00, 'Available'),
(60031, 30005, 'Farmers Bratwurst', 'Coarse Pork Bratwurst, Roasted Potatoes, Red Cabbage', 23.00, 'Available'),

-- classic
(60032, 30006, 'Bavarian Honey Ribs', 'Bavarian Honey Glazed Ribs, Spiced Potato Wedges, Dip', 36.00, 'Available'),
(60033, 30006, 'Half Oven Roasted Chicken', 'Half Oven Roasted Chicken, French Fries, Chicken Gravy', 29.50, 'Available'),
(60034, 30006, 'German Dumplings (V)', 'German Dumplings, Sauteed Kale, Tomatoes, Brown Butter', 22.00, 'Available'),
(60035, 30006, 'Goulashsoup', 'Paprika Spiced Goulash Soup, Salzstangerl', 18.00, 'Available'),
(60036, 30006, 'Cheese Spätzle (V)', 'Creamy Cheese Spätzle, Fried Onions', 22.50, 'Available'),
(60037, 30006, 'Ham & Cheese Spätzle', 'Creamy Ham and Cheese Spätzle', 24.00, 'Available'),

-- brotzeit
(60038, 30007, 'Brotzeit to Share', 'Premium Cold Cuts, Cheeses and Spreads served with Breadbasket', 45.00, 'Available'),
(60039, 30007, 'Brezn', 'Brezn with Butter', 5.00, 'Available'),
(60040, 30007, 'Brezn x 4', 'Brezn with Butter', 18.00, 'Available'),
(60041, 30007, 'Cheese Board', 'Artisan Cheese Selection', 18.00, 'Available'),
(60042, 30007, 'Black Pepper Bierwurst & Emmental Cheese', 'Airdried Black Pepper Sausage, Emmental Cheese, Pickles', 14.00, 'Available'),
(60043, 30007, 'Warm Knuckle', 'Pork Knuckle, Pickled Radish, White Cabbage Salad', 19.00, 'Available'),
(60044, 30007, 'Pork Knuckle Fladen', 'Pork Knuckle Fladen, Horseradish', 23.00, 'Available'),
(60045, 30007, 'Spinach & Cheese Fladen', 'Baby Spinach, Feta Cheese, Tomatoes', 22.00, 'Available'),
(60046, 30007, 'Bacon & Onion Fladen', 'Roasted Bacon and Onion, Green Chili', 22.00, 'Available'),
(60047, 30007, 'Breadbasket', 'Artisan Bread Selection, Butter', 12.00, 'Available'),

-- salad
(60048, 30008, 'Pork Knuckle Salad', 'Pork Knuckle Salad, Asian Dressing', 21.00, 'Available'),
(60049, 30008, 'Kale & Quinoa Salad', 'Crispy Kale Salad, Quinoa, Beetroot, Walnut, Feta Cheese', 21.00, 'Available'),
(60050, 30008, 'Superfood Salad', 'Superfood Salad, White Balsamic Dressing', 23.00, 'Available'),

-- snacks
(60051, 30009, 'French Fries', 'French Fries', 10.00, 'Available'),
(60052, 30009, 'Fried Button Mushroom', 'Fried Button Mushrooms', 14.00, 'Available'),
(60053, 30009, 'Crispy Emmental Cheese Sticks', 'Crispy Emmental Cheese Sticks, Cranberry Sauce', 14.00, 'Available'),
(60054, 30009, 'Pork Cracklings', 'Aerated Fried Pork Skin', 4.50, 'Available'),
(60055, 30009, 'Potato Wedges', 'Spiced Potato Wedges, Dip', 10.00, 'Available'),

-- sides
(60056, 30010, 'Bacon Sauerkraut', 'Bacon Sauerkraut', 8.50, 'Available'),
(60057, 30010, 'Mashed Potatoes', 'Mashed Potatoes', 8.50, 'Available'),
(60058, 30010, 'Small Mixed Side Salad', 'Small Mixed Side Salad', 8.50, 'Available'),
(60059, 30010, 'Potato Salad', 'Potato Salad', 8.50, 'Available'),
(60060, 30010, 'White Cabbage Salad', 'White Cabbage Salad', 8.50, 'Available'),
(60061, 30010, 'Red Cabbage', 'Red Cabbage', 8.50, 'Available'),
(60062, 30010, 'Sauteed Kale with Quinoa', 'Sauteed Kale with Quinoa', 8.50, 'Available'),
(60063, 30010, 'Butter Rice with Green Peas', 'Butter Rice with Green Peas', 6.00, 'Available'),
(60064, 30010, 'Potato Rösti', 'Butter Roasted Potato Rösti', 9.00, 'Available'),
(60065, 30010, 'Spätzle', 'German Egg Noodles', 8.50, 'Available'),

-- desserts
(60066, 30011, 'Apple Strudel', 'Apple Strudel with Vanilla Sauce', 16.00, 'Available'),
(60067, 30011, 'Chocolate Mud Cake', 'Chocolate Mud Cake', 13.50, 'Available'),
(60068, 30011, 'Brezn Churros', 'Churros, Cinnamon Sugar, Vanilla, Chocolate Sauce', 10.00, 'Available'),
(60069, 30011, 'Emperors Pancake', 'Shredded and Caramelised Emperors Pancake Souffle, Apple Sauce, Cranberry Sauce', 24.00, 'Available'),

-- drinks
(60070, 30012, 'BRLO Ciders Róse', NULL, 12.00, 'Available'),
(60071, 30012, 'BRLO Ciders Wild Berries', NULL, 12.00, 'Available'),
(60072, 30012, 'BRLO Grapefruit "Splash" Radler', NULL, 12.00, 'Available'),
(60073, 30012, 'Warsteiner Fresh (0% Alc)', NULL, 11.00, 'Available'),
(60074, 30012, 'Wostok 0.33L Organic Pear-Rosemary', 'Organic Pear-Rosemary', 11.00, 'Available'),
(60075, 30012, 'Wostok 0.33L Organic Lemon-mint', NULL, 11.00, 'Available'),
(60076, 30012, 'Wostok 0.33L Date-Pomegranate', NULL, 11.00, 'Available'),
(60077, 30012, 'SPEZI 0.33L', NULL, 7.00, 'Available'),
(60078, 30012, 'Coke Zero', NULL, 7.00, 'Available'),
(60079, 30012, 'Ginger Ale', NULL, 7.00, 'Available'),
(60080, 30012, 'Orange', NULL, 7.00, 'Available'),
(60081, 30012, 'Blueberry', NULL, 7.00, 'Available'),
(60082, 30012, 'Cloudy Apple', NULL, 7.00, 'Available'),

-- bubbles & white wine
(60083, 30013, 'Champagne Vollereaux Brut Reserve NV, Pierry, France', 'Pinot Noir, Chardonnay, Pinot Meunier', 86.40, 'Available'),
(60084, 30013, 'Bodegas Mitos, Cava Brut NV, Penedès, Spain', 'Macabeo, Chardonnay', 62.40, 'Available'),
(60085, 30013, 'Le Contesse Cin Cin Prosecco DOC Brut NV', 'Sparkling Prosecco from Veneto, Italy', 75.00, 'Available'),
(60086, 30013, 'Albert Glas, Pfalz, Germany', 'Riesling', 75.00, 'Available'),
(60087, 30013, '''OTU'', Marlborough, New Zealand', 'Sauvignon Blanc', 78.00, 'Available'),
(60088, 30013, 'Stift Göttweig Messwein, Kremstal, Austria', 'Grüner Veltliner', 75.00, 'Available'),
(60089, 30013, 'Tement, Kalk und Kreide, Steiermark, Austria', 'Sauvignon Blanc', 95.00, 'Available'),
(60090, 30013, 'Domaine Des Loges, Loire Valley, France', 'Chardonnay', 95.00, 'Available'),

-- red wines & others
(60091, 30014, 'Albert Glas, Pfalz, Germany', 'Dornfelder', 60.00, 'Available'),
(60092, 30014, 'Commissioner''s Block, Murray Darling, Australia', 'Shiraz', 85.00, 'Available'),
(60093, 30014, 'Reserve, Malat, Kremstal, Austria', 'Merlot', 89.00, 'Available'),
(60094, 30014, 'Vidal Fleury, Côtes-du-Rhône Villages, France', 'Syrah, Grenache, Mourvedre', 88.00, 'Available'),
(60095, 30014, 'Schwarz, The Butcher Pinot Noir', 'Pinot Noir', 92.00, 'Available'),
(60096, 30014, 'Kracher, Auslese Cuvée, Burgenland, Austria (375ml)', 'Chardonnay, Welschriesling', 62.00, 'Available'),
(60097, 30014, 'Purus Organic, England (0% alc.)', '100% Chardonnay', 58.00, 'Available'),

-- alpine spirits
(60098, 30015, 'SLYRS Malt Whisky', 'Alc. 40%, 0.7L', 86.40, 'Available'),
(60099, 30015, 'SLYRS Single Malt Whisky, Rum Cask', 'Alc. 46%, 0.7L', 148.00, 'Available'),
(60100, 30015, 'SLYRS Single Malt Whisky, Fifty-One', 'Alc. 51%, 0.7L', 158.00, 'Available'),
(60101, 30015, 'Wild Blackforest Vodka', 'Alc. 40%, 0.5L', 118.00, 'Available'),
(60102, 30015, 'WILD Haselnuss Gold (Hazelnut)', 'Alc. 35%, 0.7L', 98.00, 'Available'),
(60103, 30015, 'WILD Weinbergpfirsich-Gold (Vineyard Peach)', 'Alc. 35%, 0.7L', 98.00, 'Available'),
(60104, 30015, 'WILD Altes Pflimli-Gold (Old Plum)', 'Alc. 35%, 0.7L', 98.00, 'Available');



-- actual item variants found in the brotzeit source code
INSERT INTO MenuItemVariant VALUES
(61001, 60051, 'Normal', 10.00),
(61002, 60051, 'Truffle', 12.00),
(61003, 60057, 'Normal', 8.50),
(61004, 60057, 'Truffle', 10.00);



-- actual modifier group found in the brotzeit ordering site
INSERT INTO ModifierGroup VALUES
(62001, 'Add on Drinks', 0, 100);


INSERT INTO ModifierOption VALUES
(63001, 62001, 'BRLO Ciders Róse', 12.00),
(63002, 62001, 'BRLO Ciders Wild Berries', 12.00),
(63003, 62001, 'Warsteiner Fresh (0% Alc)', 11.00),
(63004, 62001, 'BRLO Grapefruit "Splash" Radler', 12.00),
(63005, 62001, 'Wostok 0.33L Organic Pear-Rosemary', 11.00),
(63006, 62001, 'Wostok 0.33L Organic Lemon-mint', 11.00),
(63007, 62001, 'Wostok 0.33L Date-Pomegranate', 11.00),
(63008, 62001, 'SPEZI 0.33L', 7.00);


-- sample menu items that have the add on drinks option
INSERT INTO MenuItemModifier VALUES
(64001, 60019, 62001),
(64002, 60023, 62001),
(64003, 60038, 62001),
(64004, 60043, 62001),
(64005, 60055, 62001);



-- 20 sample orders
INSERT INTO Orders VALUES
(70001, 10001, 20001, '2026-09-28 11:30:00', 2, 'Completed'),
(70002, 10002, 20002, '2026-09-28 12:15:00', 1, 'Completed'),
(70003, 10003, 20003, '2026-09-28 13:20:00', 2, 'Completed'),
(70004, 10004, 20004, '2026-09-28 14:10:00', 1, 'Completed'),
(70005, 10005, 20001, '2026-09-28 15:40:00', 2, 'Completed'),
(70006, 10006, 20002, '2026-09-28 17:00:00', 1, 'Completed'),
(70007, 10007, 20003, '2026-09-28 18:15:00', 2, 'Completed'),
(70008, 10008, 20004, '2026-09-28 19:30:00', 1, 'Completed'),
(70009, 10009, 20001, '2026-09-29 11:10:00', 2, 'Completed'),
(70010, 10010, 20002, '2026-09-29 12:25:00', 1, 'Completed'),
(70011, 10001, 20003, '2026-09-29 13:50:00', 2, 'Completed'),
(70012, 10002, 20004, '2026-09-29 14:40:00', 1, 'Completed'),
(70013, 10003, 20001, '2026-09-29 16:15:00', 2, 'Completed'),
(70014, 10004, 20002, '2026-09-29 17:25:00', 1, 'Completed'),
(70015, 10005, 20003, '2026-09-29 18:30:00', 2, 'Completed'),
(70016, 10006, 20004, '2026-09-30 11:45:00', 1, 'Completed'),
(70017, 10007, 20001, '2026-09-30 13:05:00', 2, 'Preparing'),
(70018, 10008, 20002, '2026-09-30 14:20:00', 1, 'Completed'),
(70019, 10009, 20003, '2026-09-30 17:35:00', 2, 'On the way'),
(70020, 10010, 20004, '2026-09-30 19:00:00', 1, 'Preparing');



-- items included in the 20 orders
-- variantid is null when the item has no selected variant
INSERT INTO OrderItem VALUES
(80001, 70001, 60015, NULL, 1, 45.00, 45.00),

-- truffle fries
(80002, 70001, 60051, 61002, 1, 12.00, 12.00),

(80003, 70002, 60019, NULL, 1, 42.00, 42.00),
(80004, 70002, 60078, NULL, 2, 7.00, 14.00),

(80005, 70003, 60025, NULL, 1, 45.00, 45.00),
(80006, 70003, 60039, NULL, 2, 5.00, 10.00),

(80007, 70004, 60004, NULL, 1, 158.00, 158.00),

(80008, 70005, 60021, NULL, 2, 29.50, 59.00),

(80009, 70006, 60032, NULL, 1, 36.00, 36.00),
(80010, 70006, 60066, NULL, 1, 16.00, 16.00),

(80011, 70007, 60069, NULL, 2, 24.00, 48.00),
(80012, 70007, 60077, NULL, 2, 7.00, 14.00),

(80013, 70008, 60050, NULL, 1, 23.00, 23.00),

-- normal mashed potatoes
(80014, 70008, 60057, 61003, 1, 8.50, 8.50),

(80015, 70009, 60003, NULL, 1, 168.00, 168.00),

(80016, 70010, 60015, NULL, 1, 45.00, 45.00),
(80017, 70010, 60066, NULL, 1, 16.00, 16.00),
(80018, 70010, 60078, NULL, 1, 7.00, 7.00),

(80019, 70011, 60038, NULL, 1, 45.00, 45.00),
(80020, 70011, 60041, NULL, 1, 18.00, 18.00),

(80021, 70012, 60033, NULL, 1, 29.50, 29.50),
(80022, 70012, 60063, NULL, 1, 6.00, 6.00),
(80023, 70012, 60079, NULL, 1, 7.00, 7.00),

(80024, 70013, 60017, NULL, 1, 145.00, 145.00),
(80025, 70013, 60066, NULL, 2, 16.00, 32.00),

(80026, 70014, 60026, NULL, 2, 20.00, 40.00),
(80027, 70014, 60051, 61001, 1, 10.00, 10.00),

(80028, 70015, 60001, NULL, 1, 598.00, 598.00),

(80029, 70016, 60024, NULL, 1, 34.00, 34.00),

-- truffle mashed potatoes
(80030, 70016, 60057, 61004, 1, 10.00, 10.00),

(80031, 70017, 60008, NULL, 1, 28.00, 28.00),
(80032, 70017, 60055, NULL, 1, 10.00, 10.00),
(80033, 70017, 60078, NULL, 2, 7.00, 14.00),

(80034, 70018, 60018, NULL, 1, 120.00, 120.00),
(80035, 70018, 60067, NULL, 1, 13.50, 13.50),

(80036, 70019, 60029, NULL, 2, 21.50, 43.00),
(80037, 70019, 60059, NULL, 1, 8.50, 8.50),

(80038, 70020, 60014, NULL, 1, 330.00, 330.00);



-- sample actual modifier selected by a customer
-- order 70011 added a spezi drink to brotzeit to share
INSERT INTO OrderItemModifier VALUES
(65001, 80019, 63008, 1);



-- only delivery orders have delivery records
INSERT INTO Delivery VALUES
(90001, 70001, 40001, 'Delivered', '2026-09-28 12:20:00'),
(90002, 70003, 40003, 'Delivered', '2026-09-28 14:15:00'),
(90003, 70005, 40005, 'Delivered', '2026-09-28 16:35:00'),
(90004, 70007, 40007, 'Delivered', '2026-09-28 19:05:00'),
(90005, 70009, 40009, 'Delivered', '2026-09-29 12:00:00'),
(90006, 70011, 40001, 'Delivered', '2026-09-29 14:45:00'),
(90007, 70013, 40003, 'Delivered', '2026-09-29 17:10:00'),
(90008, 70015, 40005, 'Delivered', '2026-09-29 19:30:00'),
(90009, 70017, 40007, 'Preparing', '2026-09-30 14:00:00'),
(90010, 70019, 40009, 'On the way', '2026-09-30 18:30:00');



-- one payment for every order
INSERT INTO Payment VALUES
(91001, 70001, 50001, 57.00, 'Paid'),
(91002, 70002, 50002, 56.00, 'Paid'),
(91003, 70003, 50003, 55.00, 'Paid'),
(91004, 70004, 50004, 158.00, 'Paid'),
(91005, 70005, 50005, 59.00, 'Paid'),
(91006, 70006, 50006, 52.00, 'Paid'),
(91007, 70007, 50007, 62.00, 'Paid'),
(91008, 70008, 50008, 31.50, 'Paid'),
(91009, 70009, 50009, 168.00, 'Paid'),
(91010, 70010, 50010, 68.00, 'Paid'),

-- includes the $7 spezi modifier
(91011, 70011, 50001, 70.00, 'Paid'),

(91012, 70012, 50002, 42.50, 'Paid'),
(91013, 70013, 50003, 177.00, 'Paid'),
(91014, 70014, 50004, 50.00, 'Paid'),
(91015, 70015, 50005, 598.00, 'Paid'),
(91016, 70016, 50006, 44.00, 'Paid'),
(91017, 70017, 50007, 52.00, 'Paid'),
(91018, 70018, 50008, 133.50, 'Paid'),
(91019, 70019, 50009, 51.50, 'Paid'),
(91020, 70020, 50010, 330.00, 'Paid');



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


-- shows all menu items together with their readable category name
SELECT MenuItem.MenuItemID,
       MenuItem.CategoryID,
       Category.CategoryName,
       MenuItem.ItemName,
       MenuItem.ItemDescription,
       MenuItem.ItemPrice,
       MenuItem.Availability
FROM MenuItem
INNER JOIN Category
ON MenuItem.CategoryID = Category.CategoryID
ORDER BY Category.CategoryID, MenuItem.MenuItemID;


-- shows all item variants such as normal and truffle
SELECT MenuItem.ItemName,
       MenuItemVariant.VariantID,
       MenuItemVariant.VariantName,
       MenuItemVariant.VariantPrice
FROM MenuItemVariant
INNER JOIN MenuItem
ON MenuItemVariant.MenuItemID = MenuItem.MenuItemID
ORDER BY MenuItem.MenuItemID, MenuItemVariant.VariantID;


-- shows all modifier groups and their choices
SELECT ModifierGroup.ModifierGroupName,
       ModifierOption.ModifierOptionID,
       ModifierOption.ModifierOptionName,
       ModifierOption.AdditionalPrice
FROM ModifierOption
INNER JOIN ModifierGroup
ON ModifierOption.ModifierGroupID = ModifierGroup.ModifierGroupID
ORDER BY ModifierGroup.ModifierGroupID, ModifierOption.ModifierOptionID;


-- shows which menu items support modifier groups
SELECT MenuItem.ItemName,
       ModifierGroup.ModifierGroupName
FROM MenuItemModifier
INNER JOIN MenuItem
ON MenuItemModifier.MenuItemID = MenuItem.MenuItemID
INNER JOIN ModifierGroup
ON MenuItemModifier.ModifierGroupID = ModifierGroup.ModifierGroupID;


-- shows all customer orders
SELECT * FROM Orders;


-- shows all individual items included in orders
SELECT * FROM OrderItem;


-- shows all selected order item modifiers
SELECT * FROM OrderItemModifier;


-- shows all delivery records
SELECT * FROM Delivery;


-- shows all payment records
SELECT * FROM Payment;


-- shows which customer made each order and its status
SELECT Customer.CustomerName,
       Orders.OrderID,
       Orders.OrderDateTime,
       Orders.OrderStatus
FROM Customer
INNER JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;


-- shows each order together with the customer, store and order type
SELECT Customer.CustomerName,
       Orders.OrderID,
       Store.StoreName,
       OrderType.OrderTypeName,
       Orders.OrderDateTime,
       Orders.OrderStatus
FROM Orders
INNER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
INNER JOIN Store
ON Orders.StoreID = Store.StoreID
INNER JOIN OrderType
ON Orders.OrderTypeID = OrderType.OrderTypeID;


-- shows ordered items including the selected variant
SELECT Orders.OrderID,
       MenuItem.ItemName,
       MenuItemVariant.VariantName,
       OrderItem.Quantity,
       OrderItem.UnitPrice,
       OrderItem.Subtotal
FROM OrderItem
INNER JOIN Orders
ON OrderItem.OrderID = Orders.OrderID
INNER JOIN MenuItem
ON OrderItem.MenuItemID = MenuItem.MenuItemID
LEFT JOIN MenuItemVariant
ON OrderItem.VariantID = MenuItemVariant.VariantID
ORDER BY Orders.OrderID, OrderItem.OrderItemID;


-- shows ordered items together with category name
SELECT Orders.OrderID,
       Category.CategoryName,
       MenuItem.ItemName,
       MenuItemVariant.VariantName,
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
LEFT JOIN MenuItemVariant
ON OrderItem.VariantID = MenuItemVariant.VariantID
ORDER BY Orders.OrderID, OrderItem.OrderItemID;


-- shows modifiers selected for ordered items
SELECT Orders.OrderID,
       MenuItem.ItemName,
       ModifierGroup.ModifierGroupName,
       ModifierOption.ModifierOptionName,
       ModifierOption.AdditionalPrice,
       OrderItemModifier.Quantity
FROM OrderItemModifier
INNER JOIN OrderItem
ON OrderItemModifier.OrderItemID = OrderItem.OrderItemID
INNER JOIN Orders
ON OrderItem.OrderID = Orders.OrderID
INNER JOIN MenuItem
ON OrderItem.MenuItemID = MenuItem.MenuItemID
INNER JOIN ModifierOption
ON OrderItemModifier.ModifierOptionID = ModifierOption.ModifierOptionID
INNER JOIN ModifierGroup
ON ModifierOption.ModifierGroupID = ModifierGroup.ModifierGroupID;


-- shows each customer together with their saved address
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
SELECT Category.CategoryName,
       MenuItem.ItemName,
       MenuItem.ItemPrice
FROM MenuItem
INNER JOIN Category
ON MenuItem.CategoryID = Category.CategoryID
WHERE MenuItem.Availability = 'Available'
ORDER BY Category.CategoryID, MenuItem.MenuItemID;
