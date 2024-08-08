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
    <title>User Profile</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background: #f7f7ff;
            margin-top: 20px;
            font-family: Arial, sans-serif;
        }

        .profile-image {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 5px solid #fff;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .card-body {
            padding: 2rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col-md-4 text-center">
                    <%
                        int userId = 0; // Default value
                        String fullName = "";
                        String userAddress = "";
                        String userEmail = "";
                        String userPhone = "";
                        String userGender = "";
                        String userCity = "";
                        String userState = "";
                        String userStatus = "";

                        String userIdParam = request.getParameter("user_id");
                        if (userIdParam != null && !userIdParam.isEmpty()) {
                            userId = Integer.parseInt(userIdParam);
                        } else {
                            fullName = "User ID not provided";
                            userAddress = "Address not found";
                        }

                        try {
                            Connection connection = DBConnection.getConnection();
                            Statement statement = connection.createStatement();
                            ResultSet resultSet = statement.executeQuery("SELECT * FROM users WHERE user_id = " + userId);
                            if (resultSet.next()) {
                                fullName = resultSet.getString("first_name") + " " + resultSet.getString("last_name");
                                userEmail = resultSet.getString("user_email");
                                userPhone = resultSet.getString("user_phone");
                                userAddress = resultSet.getString("user_address");
                                userGender = resultSet.getString("user_gender");
                                userCity = resultSet.getString("user_city");
                                userState = resultSet.getString("user_state");
                                userStatus = resultSet.getString("status");
                            } else {
                                fullName = "User not found";
                            }
                        } catch (SQLException e) {
                            fullName = "Error retrieving user data";
                            userAddress = "Error retrieving address";
                            e.printStackTrace(); // This will print the stack trace to the server logs for debugging
                        }
                    %>
                    <img src="<%= userGender.equalsIgnoreCase("female") ? "https://bootdey.com/img/Content/avatar/avatar3.png" : "https://bootdey.com/img/Content/avatar/avatar6.png" %>" alt="Profile Picture" class="profile-image">
                    <h4 class="mt-3"><%= fullName %></h4>
                    <p class="text-muted font-size-sm"><%= userAddress %></p>
                    <a href="edit-profile.jsp" class="btn btn-info">Edit Profile</a>
                </div>

                <div class="col-md-8">
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <th>Email</th>
                            <td><%= userEmail %></td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td><%= userPhone %></td>
                        </tr>
                        <tr>
                            <th>Address</th>
                            <td><%= userAddress %></td>
                        </tr>
                        <tr>
                            <th>Gender</th>
                            <td><%= userGender %></td>
                        </tr>
                        <tr>
                            <th>City</th>
                            <td><%= userCity %></td>
                        </tr>
                        <tr>
                            <th>State</th>
                            <td><%= userState %></td>
                        </tr>
                        <tr>
                            <th>Status</th>
                            <td><%= userStatus %></td>
                        </tr>
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
        </div>
    </div>
</div>
<br>
<br>

<div class="container" style="max-width: 1145px">
    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col-md-12">
                    <h2 style="margin-left: 385px">Seller Shop List</h2>
                    <div class="alert alert-success" id="success-alert" style="display: none;"></div>
                    <div class="alert alert-danger" id="error-alert" style="display: none;"></div>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Address</th>
                                <th>Status</th>
                                <th>Products</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                int shopId = 0;
                                String shopName = null;
                                String description = null;
                                String address = null;
                                String status = null;

                                try {
                                    Connection connection = DBConnection.getConnection();
                                    Statement statement = connection.createStatement();
                                    ResultSet shopResultSet = statement.executeQuery("SELECT * FROM sellers_shop ss JOIN shops s ON ss.shop_id = s.id WHERE ss.seller_id = " + userId);
                                    while (shopResultSet.next()) {
                                        shopId = shopResultSet.getInt("shop_id");
                                        shopName = shopResultSet.getString("name");
                                        description = shopResultSet.getString("description");
                                        address = shopResultSet.getString("address");
                                        status = shopResultSet.getString("status");

                            %>
                            <tr>
                                <td><%= shopId %></td>
                                <td><%= shopName %></td>
                                <td><%= description %></td>
                                <td><%= address %></td>
                                <td><%= status %></td>
                                <td>
                                    <a href="show-shop-productslist.jsp?shop_id=<%= shopId %>" class="btn btn-secondary" style="background-color: green">Products</a>
                                </td>
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
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
