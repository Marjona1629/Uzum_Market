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
</head>
<body>

<div class="container">
    <h2>Product List</h2>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Discount</th>
                <th>Quantity</th>
                <th>Price After Discount</th>
                <th>Category</th>
                <th>Shop</th>
            </tr>
            </thead>
            <tbody>
            <%
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    connection = DBConnection.getConnection();
                    statement = connection.createStatement();
                    String query = "SELECT p.id, p.name, p.description, p.price, p.discount, p.quantity, " +
                            "p.priceAfterDiscount, c.name AS category_name, s.name AS shop_name " +
                            "FROM products p " +
                            "JOIN categories c ON p.category_id = c.id " +
                            "JOIN shops s ON p.shop_id = s.id";
                    resultSet = statement.executeQuery(query);

                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String name = resultSet.getString("name");
                        String description = resultSet.getString("description");
                        float price = resultSet.getFloat("price");
                        int discount = resultSet.getInt("discount");
                        int quantity = resultSet.getInt("quantity");
                        float priceAfterDiscount = resultSet.getFloat("priceAfterDiscount");
                        String categoryName = resultSet.getString("category_name");
                        String shopName = resultSet.getString("shop_name");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= description %></td>
                <td><%= price %></td>
                <td><%= discount %></td>
                <td><%= quantity %></td>
                <td><%= priceAfterDiscount %></td>
                <td><%= categoryName %></td>
                <td><%= shopName %></td>
            </tr>
            <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            %>
            <tr>
                <td colspan="9">Error fetching product data.</td>
            </tr>
            <%
                } finally {
                    if (resultSet != null) try { resultSet.close(); } catch (SQLException ignored) {}
                    if (statement != null) try { statement.close(); } catch (SQLException ignored) {}
                    if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
                }
            %>
            </tbody>
        </table>
        <a href="#" onclick="goBack()" class="btn btn-primary" style="background-color: #417c80; background-position: right">Back</a>
        <script>
            function goBack() {
                window.history.back();
            }
        </script>
    </div>
</div>

</body>
</html>