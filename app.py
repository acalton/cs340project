from flask import Flask, render_template, request, redirect
from flask_mysqldb import MySQL
import os

# Adapted from: https://github.com/osu-cs340-ecampus/flask-starter-app

app = Flask(__name__)

 # database connection info
app.config["MYSQL_HOST"] = "classmysql.engr.oregonstate.edu"
app.config["MYSQL_USER"] = "cs340_caltona"
app.config["MYSQL_PASSWORD"] = "6694"
app.config["MYSQL_DB"] = "cs340_caltona"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

mysql = MySQL(app)


@app.route('/')
def home():
    return render_template("index.html")


@app.route('/customers', methods=["POST", "GET"])
def customers():
    if request.method == "POST":
        if request.form.get("Add_Customer"):
            full_name = request.form["full_name"]
            phone_number = request.form["phone_number"]
            email = request.form["email"]

            query = "INSERT INTO Customers (full_name, phone_number, email) VALUES (%s,%s,%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (full_name, phone_number, email))
            mysql.connection.commit()

            return redirect("/customers")

    if request.method == "GET":
        query = "SELECT customer_id, full_name, phone_number, email FROM Customers"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        return render_template("customers.j2", data=data)


@app.route('/gemstones', methods=["POST", "GET"])
def gemstones():
    if request.method == "POST":
        if request.form.get("Add_Gemstone"):
            gem_name = request.form["gem_name"]
            gem_price = request.form["gem_price"]
            description = request.form["description"]

            query = "INSERT INTO Gemstones (gem_name, gem_price, description) VALUES (%s,%s,%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (gem_name, gem_price, description))
            mysql.connection.commit()

            return redirect("/gemstones")

    if request.method == "GET":
        query = "SELECT gem_id, gem_name, gem_price, description FROM Gemstones"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()
        return render_template("gemstones.j2", data=data)


@app.route('/ore', methods=["POST", "GET"])
def ore():
    if request.method == "POST":
        if request.form.get("Add_Ore"):
            ore_name = request.form["ore_name"]
            price_per_ore = request.form["price_per_ore"]
            description = request.form["description"]

            query = "INSERT INTO Ore (ore_name, price_per_ore, description) VALUES (%s,%s,%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (ore_name, price_per_ore, description))
            mysql.connection.commit()

            return redirect("/ore")

    if request.method == "GET":
        query = "SELECT ore_id, ore_name, price_per_ore, description FROM Ore"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()
        return render_template("ore.j2", data=data)


@app.route('/product_types', methods=["POST", "GET"])
def product_types():
    if request.method == "POST":
        if request.form.get("Add_Product_Type"):
            product_type_name = request.form["product_type_name"]
            product_type_name = request.form["product_type_name"]
            num_ore_req = request.form["num_ore_req"]
            description = request.form["description"]

            query = "INSERT INTO Product_Types (product_type_name, num_ore_req, description) VALUES (%s,%s,%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (product_type_name, num_ore_req, description))
            mysql.connection.commit()

            return redirect("/product_types")

    if request.method == "GET":
        query = "SELECT product_type_id, product_type_name, num_ore_req, description FROM Product_Types"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()
        return render_template("product_types.j2", data=data)


@app.route('/products', methods=["POST", "GET"])
def products():
    if request.method == "POST":
        if request.form.get("Add_Product"):
            product_type_id = request.form["product_type_id"]
            ore_id = request.form["ore_id"]
            gem_id = request.form["gem_id"]
            num_gems = request.form["num_gems"]
            product_name = request.form["product_name"]
            description = request.form["description"]

            query = "INSERT INTO Products (product_type_id, ore_id, gem_id, num_gems, product_name, description) VALUES (%s,%s,%s,%s,%s,%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (product_type_id, ore_id, gem_id, num_gems, product_name, description))
            mysql.connection.commit()

            return redirect("/products")

        if request.form.get("Edit_Product"):
            product_id = request.form["product_id"]
            product_type_id = request.form["product_type_id_update"]
            ore_id = request.form["ore_id_update"]
            gem_id = request.form["gem_id_update"]
            num_gems = request.form["num_gems_update"]
            product_name = request.form["product_name_update"]
            description = request.form["description_update"]

            query = "UPDATE Products SET product_type_id = %s, ore_id = %s, gem_id = %s, num_gems = %s, product_name = %s, description = %s WHERE product_id = %s"
            cur = mysql.connection.cursor()
            cur.execute(query, (product_type_id, ore_id, gem_id,\
             num_gems, product_name, description, product_id,))
            mysql.connection.commit()

            return redirect("/products")
    
    if request.method == 'GET':
        query = "SELECT product_id, product_type_id, ore_id, gem_id,\
         num_gems, product_name, product_price, description FROM Products"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        return render_template("products.j2", data=data)


@app.route('/orders', methods=["POST", "GET"])
def orders():
    if request.method == "POST":
        if request.form.get("Add_Order"):
            customer_id = request.form["customer_id"]
            order_date_time = request.form["order_date_time"]

            query = "INSERT INTO Orders (customer_id, order_date_time) VALUES (%s,%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (customer_id, order_date_time))
            mysql.connection.commit()

            return redirect("/orders")

        if request.form.get("Edit_Order"):
            order_id = request.form["order_id"]
            customer_id = request.form["customer_id_update"]
            order_date_time = request.form["order_date_time_update"]

            query = "UPDATE Orders SET customer_id = %s, order_date_time = %s WHERE order_id = %s"
            cur = mysql.connection.cursor()
            cur.execute(query, (customer_id, order_date_time, order_id))
            mysql.connection.commit()

            return redirect("/orders")

    if request.method == 'GET':
        query = "SELECT order_id, customer_id, order_date_time FROM Orders"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        return render_template("orders.j2", data=data)


@app.route('/orders_has_products', methods=["POST", "GET"])
def orders_has_products():
    if request.method == "POST":
        if request.form.get("Add_Order_has_Product"):
            order_id = request.form["order_id"]
            product_id = request.form["product_id"]

            query = "INSERT INTO Orders_has_Products (order_id, product_id) VALUES (%s,%s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (order_id, product_id))
            mysql.connection.commit()

            return redirect("/orders_has_products")

        if request.form.get("Edit_Order_has_Product"):
            order_has_product_id = request.form["order_has_product_id"]
            order_id = request.form["order_id_update"]
            product_id = request.form["product_id_update"]

            query = "UPDATE Orders_has_Products SET order_id = %s, product_id = %s WHERE order_has_product_id = %s"
            cur = mysql.connection.cursor()
            cur.execute(query, (order_id, product_id, order_has_product_id))
            mysql.connection.commit()

            return redirect("/orders_has_products")

    if request.method == 'GET':
        query = "SELECT order_has_product_id, order_id, product_id, total_price FROM Orders_has_Products"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        return render_template("orders_has_products.j2", data=data)


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=4152, debug=True)
