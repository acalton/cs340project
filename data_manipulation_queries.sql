
-- to get all orders for order page
SELECT order_id, customer_id, order_date_time FROM Orders;

-- to get all customers for customer page
SELECT customer_id, full_name, phone_number, email FROM Customers;

-- to get all products for product page
SELECT product_id, product_type_id, ore_id, gem_id, num_gems, product_name, description FROM Products;

-- to get all product_types for product_type page
SELECT product_type_id, product_type_price, num_ore_req, description FROM Product_Types;

-- to get all ore for ore page
SELECT ore_id, ore_name, price_per_ore, description FROM Ore;

-- to get all gemstones for gem page
SELECT gem_id, gem_name, gem_price, description FROM Gemstones;

-------------------------
--INSERTS for the entity tables

INSERT INTO Orders (customer_id, order_date_time) VALUES (:customer_id_input, :order_date_time_input);
INSERT INTO Customers (full_name, phone_number, email) VALUES (:full_name_input, :phone_number_input, :email_input);
INSERT INTO Products (product_type_id, ore_id, gem_id, num_gems, product_name, description) VALUES (:product_type_id_input, :ore_id_input, :gem_id_input, :num_gems_input, :product_name_input, :description_input);
INSERT INTO Product_Types (product_type_price, num_ore_req, description) VALUES (:product_type_price_input, :num_ore_req_input, :description_input);
INSERT INTO Ore (ore_name, price_per_ore, description) VALUES (:ore_name_input, :price_per_ore_input, :description_input);
INSERT INTO Gems (gem_name, gem_price, description) VALUES (:gem_name_input, :gem_price_input, :description_input);

-- update
UPDATE Orders SET customer_id = :customer_id_input, order_date_time = :order_date_time_input WHERE order_id = :order_id_from_form;
UPDATE Products SET product_type_id = :product_type_id_input, ore_id = :ore_id_input, gem_id = :gem_id_input, num_gems = :num_gems_input, product_name = :product_name_input, description = :description_input WHERE product_id = :product_id_input;

-- DELETE
DELETE FROM Orders WHERE order_id = :order_id_from_order_page;
DELETE FROM Products WHERE product_id = :product_id_from_product_page;