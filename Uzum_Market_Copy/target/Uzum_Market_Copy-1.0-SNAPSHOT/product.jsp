<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Page</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .products-container {
      display: flex;
      gap: 20px;
    }

    .product-container {
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      width: 300px;
      text-align: center;
    }

    .product-image {
      width: 100%;
      height: auto;
    }

    .product-details {
      padding: 20px;
    }

    .product-name {
      font-size: 1.5em;
      margin: 0;
    }

    .product-price {
      color: #888;
      font-size: 1.2em;
      margin: 10px 0;
    }

    .button-container {
      display: flex;
      justify-content: space-around;
      margin-top: 20px;
    }

    .cart-button, .buy-button {
      background-color: #4CAF50;
      color: white;
      border: none;
      padding: 10px 20px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 1em;
      margin: 4px 2px;
      transition-duration: 0.4s;
      cursor: pointer;
      border-radius: 5px;
    }

    .cart-button:hover, .buy-button:hover {
      background-color: white;
      color: black;
      border: 2px solid #4CAF50;
    }

  </style>
</head>
<body>
<div class="products-container">
  <div class="product-container">
    <img src="css_files/css/pics/gamburger-416x277.jpg" alt="Product Image" class="product-image">
    <div class="product-details">
      <h2 class="product-name">Product Name</h2>
      <p class="product-price">$100.00</p>
      <div class="button-container">
        <button class="cart-button" onclick="addToBasket()">Basket</button>
        <button class="buy-button" onclick="buyNow()">Buy</button>
      </div>
    </div>
  </div>

  <div class="product-container">
    <img src="css_files/css/pics/lavash.png" alt="Product Image" class="product-image">
    <div class="product-details">
      <h2 class="product-name">Product Name</h2>
      <p class="product-price">$100.00</p>
      <div class="button-container">
        <button class="cart-button" onclick="addToBasket()">Basket</button>
        <button class="buy-button" onclick="buyNow()">Buy</button>
      </div>
    </div>
  </div>
</div>

<script>
  function addToBasket() {
    window.location.href = 'basket.jsp';
  }

  function buyNow() {
    window.location.href = 'Pay.jsp';
  }
</script>
</body>
</html>
