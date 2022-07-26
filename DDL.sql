SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

--Ashley Calton
--Rongabriel Gan

DROP TABLE IF EXISTS `Customers`;
CREATE TABLE `Customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL,
  `phone_number` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `Gemstones`;
CREATE TABLE `Gemstones` (
  `gem_id` int(11) NOT NULL AUTO_INCREMENT,
  `gem_name` varchar(100) NOT NULL,
  `gem_price` decimal(12,2) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`gem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date_time` datetime NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `Orders_has_Products`;
CREATE TABLE `Orders_has_Products` (
  `order_has_product_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `total_price` decimal(12,2) NOT NULL,
  PRIMARY KEY (`order_has_product_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  FOREIGN KEY (`order_id`) REFERENCES `Orders` (`order_id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `Products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `Ore`;
CREATE TABLE `Ore` (
  `ore_id` int(11) NOT NULL AUTO_INCREMENT,
  `ore_name` varchar(100) NOT NULL,
  `price_per_ore` decimal(12,2) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ore_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `Products`;
CREATE TABLE `Products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_type_id` int(11) NOT NULL,
  `ore_id` int(11) NOT NULL,
  `gem_id` int(11) DEFAULT NULL,
  `num_gems` int(11) NOT NULL DEFAULT 0,
  `product_name` varchar(100) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `product_type_id` (`product_type_id`),
  KEY `ore_id` (`ore_id`),
  KEY `gem_id` (`gem_id`),
  FOREIGN KEY (`product_type_id`) REFERENCES `Product_Types` (`product_type_id`) ON DELETE CASCADE,
  FOREIGN KEY (`ore_id`) REFERENCES `Ore` (`ore_id`) ON DELETE CASCADE,
  FOREIGN KEY (`gem_id`) REFERENCES `Gems` (`gem_id`) ON DELETE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `Product_Types`;
CREATE TABLE `Product_Types` (
  `product_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_type_name` varchar(100) NOT NULL,
  `product_type_price` decimal(12,2) NOT NULL,
  `num_ore_req` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`product_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO Customers (full_name, phone_number, email)
VALUES ('Ned Stark',
'000-111-2222',
'lord0winterfell@yahoo.com'
),
('Dalinar Kholin',
'333-444-5555',
'bondsmith@aol.com'
),
('Samwise Gamgee',
'666-777-8888',
'sam_gam@gmail.com'
);

INSERT INTO Gemstones (gem_name, gem_price, description)
VALUES ('Diamond',
1000.00,
'Sizable, clear diamond'
),
('Sapphire',
750.00,
'Deep blue sapphire'
),
('Peridot',
100.00,
'August birthstone'
);

INSERT INTO Ore (ore_name, price_per_ore, description)
VALUES ('Iron',
75.00,
'Strong, mid-priced'
),
('Copper',
90.00,
NULL),
('Steel',
50.00,
'Affordable but reliable'
);

INSERT INTO Product_Types (product_type_name, product_type_price, num_ore_req, description)
VALUES ('Greatsword',
250.00,
6,
'A two-handed greatsword for the strongest of warriors'
),
('Dagger',
60.00,
2,
'An easily concealable but deadly dagger'
),
('Halfhelm',
100.00,
4,
'A sturdy helmet for a foot soldier'
);

INSERT INTO Products (product_type_id, ore_id, gem_id, num_gems, product_name, description)
VALUES ((SELECT product_type_id FROM Product_Types WHERE product_type_name = 'Greatsword'),
(SELECT ore_id FROM Ore WHERE ore_name = 'Steel'),
(SELECT gem_id FROM Gemstones WHERE gem_name = 'Sapphire'),
2,
'Big Sword',
'Steel greatsword with sapphires embedded in the hilt'
),
((SELECT product_type_id FROM Product_Types WHERE product_type_name = 'Dagger'),
(SELECT ore_id FROM Ore WHERE ore_name = 'Iron'),
(SELECT gem_id FROM Gemstones WHERE gem_name = 'Diamond'),
1,
'Clever Dagger',
'A flashy iron dagger with a single diamond in the hilt'
),
((SELECT product_type_id FROM Product_Types WHERE product_type_name = 'Halfhelm'),
(SELECT ore_id FROM Ore WHERE ore_name = 'Copper'),
NULL,
0,
'Halfling Halfhelm',
'A modest but durable helm'
);

INSERT INTO Orders (customer_id, order_date_time)
VALUES ((SELECT customer_id FROM Customers WHERE full_name = 'Ned Stark'),
'2022-06-08 08:50:02'),
((SELECT customer_id FROM Customers WHERE full_name = 'Dalinar Kholin'),
'2022-07-01 06:30:10'),
((SELECT customer_id FROM Customers WHERE full_name = 'Samwise Gamgee'),
'2022-06-19 11:20:33');

INSERT INTO Orders_has_Products (order_id, product_id)
VALUES ((SELECT order_id FROM Orders WHERE order_date_time = '2022-06-08 08:50:02'),
(SELECT product_id FROM Products WHERE product_name = 'Big Sword')),
((SELECT order_id FROM Orders WHERE order_date_time = '2022-07-01 06:30:10'),
(SELECT product_id FROM Products WHERE product_name = 'Clever Dagger')),
((SELECT order_id FROM Orders WHERE order_date_time = '2022-06-19 11:20:33'),
(SELECT product_id FROM Products WHERE product_name = 'Halfling Halfhelm'));

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
