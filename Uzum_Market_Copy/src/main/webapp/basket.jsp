<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basket</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .basket-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 20px 0;
        }

        .basket-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .basket-header h1 {
            font-size: 1.5em;
            margin: 0;
        }

        .basket-header .remove-all {
            color: #6a1b9a;
            cursor: pointer;
        }

        .basket-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #ccc;
            padding: 20px 0;
        }

        .basket-item:first-child {
            border-top: none;
        }

        .basket-item img {
            width: 100px;
            height: auto;
            border-radius: 5px;
        }

        .item-details {
            flex-grow: 1;
            padding: 0 20px;
        }

        .item-details h2 {
            font-size: 1.2em;
            margin: 0;
        }

        .item-details p {
            margin: 5px 0;
            color: #888;
        }

        .item-quantity {
            display: flex;
            align-items: center;
        }

        .item-quantity button {
            background-color: #6a1b9a;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }

        .item-quantity input {
            width: 40px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin: 0 10px;
        }

        .item-price {
            text-align: right;
        }

        .item-price .current-price {
            font-size: 1.5em;
            color: #000;
        }

        .item-price .old-price {
            text-decoration: line-through;
            color: #888;
            margin-left: 10px;
        }

        .item-remove {
            color: #888;
            cursor: pointer;
            font-size: 1.5em;
        }
    </style>
</head>
<body>
<div class="basket-container">
    <div class="basket-header">
        <h1>Your basket</h1>
        <span class="remove-all">Снять все</span>
    </div>
        <div class="basket-item">
            <input type="checkbox">
            <img src="css_files/css/pics/lavash.png" alt="Product Image">
            <div class="item-details">
                <h2>Lavash</h2>
                <p>Size: mini</p>
            </div>
            <div class="item-quantity">
                <button>-</button>
                <input type="text" value="">
                <button>+</button>
            </div>
            <div class="item-price">
                <span class="current-price">12.000 so'm</span>
            </div>
            <span class="item-remove"><i class="fas fa-trash"></i></span>
        </div>
</div>
</body>
</html>
