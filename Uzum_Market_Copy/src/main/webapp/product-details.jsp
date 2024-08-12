<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page import="uz.pdp.uzummarket.service.ProductService" %>
<%
    ProductService productService = new ProductService();
    int productId = Integer.parseInt(request.getParameter("id"));
    Product product = productService.getProductById(productId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            display: flex;
            width: 80%;
            margin: auto;
            overflow: hidden;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            gap: 20px;
            margin-top: 20px;
        }
        .product-image-wrapper {
            flex: 1;
            max-width: 50%;
        }
        .product-image {
            width: 100%;
            height: auto;
            border-radius: 8px;
            border: 2px solid #ddd;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
        }
        .product-details {
            flex: 2;
            max-width: 50%;
        }
        .product-details h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .product-details p {
            font-size: 1.2em;
            margin: 10px 0;
        }
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 20px 0;
        }
        .quantity-control button {
            padding: 10px;
            font-size: 1.2em;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .quantity-control input {
            text-align: center;
            font-size: 1.2em;
            width: 60px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .actions {
            margin-top: 20px;
            display: flex;
            gap: 20px;
        }
        .actions button {
            padding: 15px 25px;
            font-size: 1.2em;
            color: white;
            background: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .actions button:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="product-image-wrapper">
        <img src="<%= request.getContextPath() + "/image/" + product.getImages() %>" alt="<%= product.getName() %>" class="product-image">
    </div>
    <div class="product-details">
        <h1><%= product.getName() %></h1>
        <p><strong>Description:</strong> <%= product.getDescription() %></p>
        <p><strong>Price:</strong> $<%= product.getPrice() %></p>
        <p><strong>Discount:</strong> <%= product.getDiscount() %> %</p>
        <p><strong>Quantity:</strong> <%= product.getQuantity() %></p>
        <p><strong>Category:</strong> <%= product.getCategory().getCategoryName() %></p>
        <p><strong>Shop:</strong> <%= product.getShop().getName() %></p>

        <!-- Quantity Control and Add to Basket -->
        <div class="quantity-control">
            <button id="decrease-btn">-</button>
            <input type="number" id="quantity" value="1" min="1" max="<%= product.getQuantity() %>">
            <button id="increase-btn">+</button>
        </div>
        <div class="actions">
            <button id="add-to-basket">Add to Basket</button>
            <button onclick="window.location.href='home.jsp'">Back Home</button>
        </div>
    </div>
</div>

<script>
    document.getElementById('decrease-btn').addEventListener('click', function() {
        let quantityInput = document.getElementById('quantity');
        let currentValue = parseInt(quantityInput.value);
        if (currentValue > 1) {
            quantityInput.value = currentValue - 1;
        }
    });

    document.getElementById('increase-btn').addEventListener('click', function() {
        let quantityInput = document.getElementById('quantity');
        let currentValue = parseInt(quantityInput.value);
        let maxQuantity = parseInt(quantityInput.getAttribute('max'));
        if (currentValue < maxQuantity) {
            quantityInput.value = currentValue + 1;
        }
    });

    document.getElementById('add-to-basket').addEventListener('click', function() {
        let quantity = document.getElementById('quantity').value;
        let productId = '<%= product.getId() %>';
        window.location.href = `addToBasketServlet?id=${productId}&quantity=${quantity}`;
    });
</script>
</body>
</html>
