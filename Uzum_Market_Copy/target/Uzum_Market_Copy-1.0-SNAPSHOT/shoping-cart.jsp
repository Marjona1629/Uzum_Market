<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <!-- Add necessary CSS and JS files -->
</head>
<body>
<h2>Shopping Cart</h2>
<%
    List<Product> cart = (List<Product>) session.getAttribute("cart");
    if (cart != null && !cart.isEmpty()) {
%>
<table border="1">
    <tr>
        <th>Product Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total</th>
    </tr>
    <%
        for (Product product : cart) {
    %>
    <tr>
        <td><%= product.getProductName() %></td>
        <td><%= product.getProductPrice() %>$</td>
        <td>1</td> <!-- Default quantity to 1, you can add functionality to update quantity -->
        <td><%= product.getProductPrice() %>$</td>
    </tr>
    <%
        }
    %>
    <tr>
        <td colspan="3">Total</td>
        <td>
            <%
                double total = 0;
                for (Product product : cart) {
                    total += product.getProductPrice();
                }
            %>
        </td>
    </tr>
</table>
<%
} else {
%>
<p>Your shopping cart is empty.</p>
<%
    }
%>
</body>
</html>
