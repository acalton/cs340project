
-- to get all orders for order page
SELECT order_id, customer_id, order_date_time FROM Orders;

-- to get all orders for order page using aliases and displaying customer name instead of customer id
SELECT Orders.order_id 'Order ID', Customers.full_name 'Customer Name', Orders.order_date_time 'Time of Order'
FROM Orders
INNER JOIN Customers ON Orders.customer_id = Customers.customer_id;

-- to get all customers for customer page
SELECT customer_id, full_name, phone_number, email FROM Customers;

-- to get all products for product page
SELECT product_id, product_type_id, ore_id, IFNULL(gem_id, 'None'), num_gems, product_name, IFNULL(description, 'None') FROM Products;

-- to get all products for product page displaying product_type, ore, and gem names instead of their ID
SELECT Products.product_id 'Product ID', Product_Types.product_type_name 'Product Type', Ore.ore_name 'Ore', IFNULL(Gemstones.gem_name, 'None') AS 'Gem', Products.num_gems 'Gem Quantity', Products.product_name 'Product Name', IFNULL(Products.description, 'None') AS 'Description'
FROM Products
INNER JOIN Product_Types ON Products.product_type_id = Product_Types.product_type_id
INNER JOIN Ore ON Products.ore_id = Ore.ore_id
INNER JOIN Gemstones ON Products.gem_id = Gemstones.gem_id;



--  update query to sum the product price of a product based on ore and gems
UPDATE Products 
SET product_price = (
    SELECT Ore.price_per_ore*Product_Types.num_ore_req + Gemstones.gem_price*Products.num_gems AS 'product price' FROM Products 
    INNER JOIN Product_Types ON Products.product_type_id = Product_Types.product_type_id
    INNER JOIN Ore ON Products.ore_id = Ore.ore_id
    INNER JOIN Gemstones ON Products.gem_id = Gemstones.gem_id
    WHERE product_id = :product_id)
WHERE product_id = :product_id;



-- to get all product_types for product_type page
SELECT product_type_id, product_type_price, num_ore_req, IFNULL(description, 'None') FROM Product_Types;

-- to get all ore for ore page
SELECT ore_id, ore_name, price_per_ore, IFNULL(description, 'None') FROM Ore;

-- to get all gemstones for gem page
SELECT gem_id, gem_name, gem_price, IFNULL(description, 'None') FROM Gemstones;

-- used in gem page to search for gems less than a certain price
SELECT gem_name, gem_price FROM Gemstones WHERE gem_price <= :gem_price_input;

-- select statement for intersection table
SELECT order_has_product_id, order_id, product_id, total_price FROM Orders_has_Products;



--    query for total_price of intersection table, sums the price of the products from the same order ID
UPDATE Orders_has_Products
SET total_price = ( 
    SELECT SUM(Products.product_price) AS 'total price'
    FROM Orders_has_Products
    INNER JOIN Products ON Orders_has_Products.product_id = Products.product_id 
    WHERE Orders_has_Products.order_id = :Orders_has_Products.order_id
)
WHERE Orders_has_Products.order_id = :Orders_has_Products.order_id ;








----------------------------------------------------------
-- select statements for dropdowns utilizing names instead of id
SELECT product_type_name FROM Product_Types;
SELECT ore_name FROM Ore;
SELECT gem_name FROM Gemstones;
SELECT full_name from Customers;

-------------------------
--INSERTS for the entity tables

INSERT INTO Orders (customer_id, order_date_time) 
    VALUES (:customer_id_input, :order_date_time_input);

INSERT INTO Customers (full_name, phone_number, email) 
    VALUES (:full_name_input, :phone_number_input, :email_input);

INSERT INTO Products (product_type_id, ore_id, gem_id, num_gems, product_name, description, product_price) 
    VALUES (:product_type_id_input, :ore_id_input, :gem_id_input, :num_gems_input, :product_name_input, :description_input, :product_price);

INSERT INTO Product_Types (product_type_price, num_ore_req, description) 
    VALUES (:product_type_price_input, :num_ore_req_input, :description_input);

INSERT INTO Ore (ore_name, price_per_ore, description) 
    VALUES (:ore_name_input, :price_per_ore_input, :description_input);

INSERT INTO Gems (gem_name, gem_price, description) 
    VALUES (:gem_name_input, :gem_price_input, :description_input);


-- update
UPDATE Orders 
    SET customer_id = :customer_id_input, order_date_time = :order_date_time_input 
    WHERE order_id = :order_id_from_form;

UPDATE Products 
    SET product_type_id = :product_type_id_input, ore_id = :ore_id_input, gem_id = :gem_id_input, num_gems = :num_gems_input, product_name = :product_name_input, description = :description_input 
    WHERE product_id = :product_id_input;

-- DELETE
DELETE FROM Orders WHERE order_id = :order_id_from_order_page;

DELETE FROM Products WHERE product_id = :product_id_from_product_page;