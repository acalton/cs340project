from flask import Flask, render_template
app = Flask(__name__)


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


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=4112)
