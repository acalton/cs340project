from flask import Flask, render_template

app = Flask(__name__)

# database connection info
app.config["MYSQL_HOST"] = "classmysql.engr.oregonstate.edu"
app.config["MYSQL_USER"] = "cs340_caltona"
app.config["MYSQL_PASSWORD"] = "6694"
app.config["MYSQL_DB"] = "cs340_caltona"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"


@app.route('/')
def home():
    return render_template("index.html")


@app.route('/customers')
def customers():
    return render_template("customers.html")


@app.route('/gemstones')
def gemstones():
    return render_template("gemstones.html")


@app.route('/ore')
def ore():
    return render_template("ore.html")


@app.route('/product_types')
def product_types():
    return render_template("product_types.html")


@app.route('/products')
def products():
    return render_template("products.html")


@app.route('/orders')
def orders():
    return render_template("orders.html")


@app.route('/orders_has_products')
def orders():
    return render_template("orders_has_products.html")


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=4112)
