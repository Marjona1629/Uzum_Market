<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background: #f7f7ff;
            margin-top: 20px;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 1145px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div class="card-body">
            <h2 style="text-align: center;">Product List</h2>
            <%
                int shopId = 0;
                String shopName = "";
                String shopIdParam = request.getParameter("shop_id");
                if (shopIdParam != null && !shopIdParam.isEmpty()) {
                    shopId = Integer.parseInt(shopIdParam);
                }

                try {
                    Connection connection = DBConnection.getConnection();
                    Statement statement = connection.createStatement();
                    ResultSet shopResultSet = statement.executeQuery("SELECT name FROM shops WHERE id = " + shopId);
                    if (shopResultSet.next()) {
                        shopName = shopResultSet.getString("name");
                    }
            %>
            <h4 style="text-align: center;"> <%= shopName %></h4>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Quantity</th>
                        <th>Price After Discount</th>
                        <th>Category ID</th>
                        <th>Images</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        ResultSet productResultSet = statement.executeQuery("SELECT * FROM products WHERE shopId = " + shopId);
                        while (productResultSet.next()) {
                            int productId = productResultSet.getInt("product_id");
                            String productName = productResultSet.getString("product_name");
                            String productDescription = productResultSet.getString("product_description");
                            float productPrice = productResultSet.getFloat("product_price");
                            int productDiscount = productResultSet.getInt("product_discount");
                            int productQuantity = productResultSet.getInt("product_quantity");
                            String productImages = productResultSet.getString("product_images");
                            int categoryId = productResultSet.getInt("category_id");
                            float productPriceAfterDiscount = productResultSet.getFloat("product_price_after_discount");
                    %>
                    <tr>
                        <td><%= productId %></td>
                        <td><%= productName %></td>
                        <td><%= productDescription %></td>
                        <td><%= productPrice %></td>
                        <td><%= productDiscount %></td>
                        <td><%= productQuantity %></td>
                        <td><%= productPriceAfterDiscount %></td>
                        <td><%= categoryId %></td>
                        <td><%= productImages %></td>
                    </tr>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <a href="#" onclick="goBack()" class="btn btn-primary" style="margin-left: 1000px">Back</a>
            <script>
                function goBack() {
                    window.history.back();
                }
            </script>
        </div>
    </div>
</div>

</body>
</html>