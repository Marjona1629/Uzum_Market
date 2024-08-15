<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>
<%@ page import="java.sql.*" %>

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
                        String username = "";
                        String userAddress = "";
                        String userEmail = "";
                        String userPhone = "";
                        String userGender = "";
                        String userCity = "";
                        String userState = "";
                        String userStatus = "";
                        String profileImage = "https://bootdey.com/img/Content/avatar/avatar6.png";

                        String userIdParam = request.getParameter("user_id");
                        if (userIdParam != null && !userIdParam.isEmpty()) {
                            userId = Integer.parseInt(userIdParam);

                            try (Connection connection = DBConnection.getConnection();
                                 Statement statement = connection.createStatement();
                                 ResultSet resultSet = statement.executeQuery("SELECT * FROM users WHERE id = " + userId)) {

                                if (resultSet.next()) {
                                    username = resultSet.getString("username");
                                    fullName = resultSet.getString("firstname") + " " + resultSet.getString("lastname");
                                    userEmail = resultSet.getString("email");
                                    userPhone = resultSet.getString("phone");
                                    userAddress = resultSet.getString("address");
                                    userGender = resultSet.getString("gender");
                                    userCity = resultSet.getString("city");
                                    userState = resultSet.getString("state");
                                    userStatus = resultSet.getString("status");

                                    // Set profile image based on gender
                                    if ("female".equalsIgnoreCase(userGender)) {
                                        profileImage = "https://bootdey.com/img/Content/avatar/avatar3.png";
                                    }
                                } else {
                                    fullName = "User not found";
                                }
                            } catch (SQLException e) {
                                fullName = "Error retrieving user data";
                                userAddress = "Error retrieving address";
                                e.printStackTrace(); // Logs the stack trace for debugging
                            }
                        }

                    %>
                    <img src="<%= profileImage %>" alt="Profile Picture" class="profile-image">
                    <h4 class="mt-3"><%= fullName %></h4>
                    <p class="text-muted font-size-sm"><%= username %></p>
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
                    <h2 style="text-align: center;">Seller Shop List</h2>
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
                                int shopId;
                                String shopName;
                                String description;
                                String address;
                                String status;

                                Connection connection = null;
                                PreparedStatement statement = null;
                                ResultSet shopResultSet = null;

                                try {
                                    connection = DBConnection.getConnection();
                                    String query = "SELECT * FROM shops WHERE owner_id = ?";
                                    statement = connection.prepareStatement(query);
                                    statement.setInt(1, userId); // Set the userId from the earlier code
                                    shopResultSet = statement.executeQuery();

                                    boolean hasResults = false; // Flag to check if any results were found

                                    while (shopResultSet.next()) {
                                        hasResults = true; // Data found
                                        shopId = shopResultSet.getInt("id");
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
                                    <a href="/app/admin/shopproducts?id=<%= shopId %>" class="btn btn-secondary" style="background-color: green">Products</a>
                                </td>
                            </tr>
                            <%
                                }

                                if (!hasResults) {
                            %>
                            <tr>
                                <td colspan="6">No shops found for this seller.</td>
                            </tr>
                            <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            %>
                            <tr>
                                <td colspan="6">Error fetching shop data.</td>
                            </tr>
                            <%
                                } finally {
                                    if (shopResultSet != null) try { shopResultSet.close(); } catch (SQLException ignored) {}
                                    if (statement != null) try { statement.close(); } catch (SQLException ignored) {}
                                    if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
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