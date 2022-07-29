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


@app.route('/customers', methods=["GET"])
def customers():
    if request.method == "GET":
        query = "SELECT customer_id, full_name, phone_number, email FROM Customers"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        return render_template("customers.html", data=data)


@app.route('/gemstones', methods=["GET"])
def gemstones():
    if request.method == "GET":
        query = "SELECT gem_id, gem_name, gem_price, description FROM Gemstones"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()
        return render_template("gemstones.html", data=data)


@app.route('/ore')
def ore():
    return render_template("ore.html")


@app.route('/product_types')
def product_types():
    return render_template("product_types.html")


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
    
    if request.method == 'GET':
        query = "SELECT product_id, product_type_id, ore_id, gem_id,\
         num_gems, product_name, product_price, description FROM Products"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        return render_template("products.j2", data=data)


@app.route('/orders')
def orders():
    return render_template("orders.html")


@app.route('/orders_has_products')
def orders_has_products():
    return render_template("orders_has_products.html")


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=4152, debug=True)
