<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>
<%@ page import="java.text.DecimalFormat" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Uzum Market">
    <meta name="keywords" content="html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>ADMIN</title>

    <!-- Favicons -->
    <link href="/admin-assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="/admin-assets/img/favicon.png" >
    <link rel="stylesheet" href="/admin-assets/img/apple-touch-icon.png" >

    <!-- Google Fonts -->
    <link rel="stylesheet" href="https://fonts.gstatic.com" >
    <link rel="stylesheet"href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" >

    <!-- Vendor CSS Files -->
    <link href="/admin-assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/admin-assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/admin-assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/admin-assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/admin-assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/admin-assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/admin-assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        h2 {
            color: #007bff;
            text-align: center;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9ecef;
        }
    </style>

</head>

<body>

<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
        <a href="index.html" class="logo d-flex align-items-center">
            <img src="/admin-assets/img/logo.png" alt="">
            <span class="d-none d-lg-block">ADMIN</span>
        </a>
        <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <div class="search-bar">
        <form class="search-form d-flex align-items-center" method="POST" action="#">
            <input type="text" name="query" placeholder="Search" title="Enter search keyword">
            <button type="submit" title="Search"><i class="bi bi-search"></i></button>
        </form>
    </div><!-- End Search Bar -->

    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

            <li class="nav-item d-block d-lg-none">
                <a class="nav-link nav-icon search-bar-toggle " href="#">
                    <i class="bi bi-search"></i>
                </a>
            </li><!-- End Search Icon-->

            <li class="nav-item dropdown">

                <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-bell"></i>
                    <span class="badge bg-primary badge-number">4</span>
                </a><!-- End Notification Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
                    <li class="dropdown-header">
                        You have 4 new notifications
                        <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="notification-item">
                        <i class="bi bi-exclamation-circle text-warning"></i>
                        <div>
                            <h4>Lorem Ipsum</h4>
                            <p>Quae dolorem earum veritatis oditseno</p>
                            <p>30 min. ago</p>
                        </div>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="notification-item">
                        <i class="bi bi-x-circle text-danger"></i>
                        <div>
                            <h4>Atque rerum nesciunt</h4>
                            <p>Quae dolorem earum veritatis oditseno</p>
                            <p>1 hr. ago</p>
                        </div>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="notification-item">
                        <i class="bi bi-check-circle text-success"></i>
                        <div>
                            <h4>Sit rerum fuga</h4>
                            <p>Quae dolorem earum veritatis oditseno</p>
                            <p>2 hrs. ago</p>
                        </div>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="notification-item">
                        <i class="bi bi-info-circle text-primary"></i>
                        <div>
                            <h4>Dicta reprehenderit</h4>
                            <p>Quae dolorem earum veritatis oditseno</p>
                            <p>4 hrs. ago</p>
                        </div>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li class="dropdown-footer">
                        <a href="#">Show all notifications</a>
                    </li>

                </ul><!-- End Notification Dropdown Items -->

            </li><!-- End Notification Nav -->

            <li class="nav-item dropdown">

                <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-chat-left-text"></i>
                    <span class="badge bg-success badge-number">3</span>
                </a><!-- End Messages Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages">
                    <li class="dropdown-header">
                        You have 3 new messages
                        <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="message-item">
                        <a href="#">
                            <img src="admin-assets/img/messages-1.jpg" alt="" class="rounded-circle">
                            <div>
                                <h4>Maria Hudson</h4>
                                <p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
                                <p>4 hrs. ago</p>
                            </div>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="message-item">
                        <a href="#">
                            <img src="admin-assets/img/messages-2.jpg" alt="" class="rounded-circle">
                            <div>
                                <h4>Anna Nelson</h4>
                                <p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
                                <p>6 hrs. ago</p>
                            </div>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="message-item">
                        <a href="#">
                            <img src="admin-assets/img/messages-3.jpg" alt="" class="rounded-circle">
                            <div>
                                <h4>David Muldon</h4>
                                <p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
                                <p>8 hrs. ago</p>
                            </div>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="dropdown-footer">
                        <a href="#">Show all messages</a>
                    </li>

                </ul><!-- End Messages Dropdown Items -->

            </li><!-- End Messages Nav -->

            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Get database connection
                    conn = DBConnection.getConnection();
                    stmt = conn.createStatement();

                    // Query to get admin information
                    String sql = "SELECT * FROM users WHERE role = 'ADMIN' LIMIT 1";
                    rs = stmt.executeQuery(sql);

                    // Assuming there is only one admin in your system, LIMIT 1 is used
                    if (rs.next()) {
                        String adminUsername = rs.getString("username");
                        String adminLastName = rs.getString("lastname");
                        String adminFirstName = rs.getString("firstname");
                        String adminRole = rs.getString("role");
            %>

            <li class="nav-item dropdown pe-3">
                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle fs-4 me-2"></i> <!-- Admin Icon -->
                    <span class="d-none d-md-block dropdown-toggle ps-2"><%= adminUsername %></span>
                </a><!-- End Profile Image Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                    <li class="dropdown-header">
                        <h6><%= adminFirstName %> <%= adminLastName %></h6>
                        <span><%= adminRole %></span>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="/app/admin/adminprofile">
                            <i class="bi bi-person"></i>
                            <span>My Profile</span>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="/app/admin/comingsoon">
                            <i class="bi bi-gear"></i>
                            <span>Account Settings</span>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="/logout">
                            <i class="bi bi-box-arrow-right"></i>
                            <span>Sign Out</span>
                        </a>
                    </li>
                </ul><!-- End Profile Dropdown Items -->
            </li><!-- End Profile Nav -->

            <%
                    } // end if(rs.next())
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>

        </ul>
    </nav><!-- End Icons Navigation -->

</header>
<!-- End Header -->

<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link collapsed" href="/app/admin/dashboard">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li><!-- End Dashboard Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="/app/admin/showseller">
                <i class="bi bi-menu-button-wide"></i>
                <span>Show Sellers</span>
            </a>
        </li><!-- End Show Sellers Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="/app/admin/registerseller">
                <i class="bi bi-receipt"></i>
                <span>Register Seller</span>
            </a>
        </li><!-- End Register Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="/app/admin/manageusers">
                <i class="bi bi-controller"></i>
                <span>Manage Users</span>
            </a>
        </li><!-- End Manage Users Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="/app/admin/createcategory">
                <i class="bi bi-database-fill-add"></i>
                <span>Add Category</span>
            </a>
        </li><!-- End Profile Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="/app/admin/settings">
                <i class="ri-settings-3-line"></i>
                <span>Settings</span>
            </a>
        </li><!-- End Profile Nav -->

    </ul>

</aside><!-- End Sidebar -->
<br><br>


<div class="container" style="max-width: 800px">
    <h2 class="mt-0">Register New Seller</h2>
    <form class="row g-3 mt-4" id="registerForm" method="POST">
        <div class="col-md-6">
            <label for="inputEmail" class="form-label">Email</label>
            <input type="email" class="form-control" id="inputEmail" name="email" placeholder="Enter email" required>
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary mt-3">Register</button>
        </div>
    </form>

    <hr>

    <h2>List of Sellers</h2>
    <div class="alert alert-success" id="success-alert" style="display: none;"></div>
    <div class="alert alert-danger" id="error-alert" style="display: none;"></div>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>Address</th>
                <th>City</th>
                <th>Profile</th>
            </tr>
            </thead>
            <tbody>
            <%-- Fetch and display sellers from database --%>
            <%
                Connection con = null;
                PreparedStatement pstmt = null;
                rs = null;
                try {
                    con = DBConnection.getConnection();
                    pstmt = con.prepareStatement("SELECT id, username, email, phone, address, city, status FROM users WHERE role = 'SELLER' AND isDeleted = FALSE");
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String status = rs.getString("status");
            %>
            <tr id="seller-<%= id %>">
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("phone") %></td>
                <td><%= rs.getString("address") %></td>
                <td><%= rs.getString("city") %></td>
                <td>
                    <a href="/app/admin/showsellerprofile?user_id=<%= rs.getInt("id") %>"
                       class="btn btn-primary" style="background-color: limegreen">Profile</a>
                </td>
            </tr>
            <% }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null)
                        rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                try {
                    if (stmt != null)
                        stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                try {
                    if (con != null)
                        con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Optional: Include jQuery and Bootstrap JS for functionality -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
        $('#registerForm').submit(function(e) {
            e.preventDefault(); // Prevent form submission

            var formData = $(this).serialize(); // Serialize form data
            $.ajax({
                url: "registerseller",
                type: "POST",
                data: formData,
                success: function(response) {
                    // Log response for debugging
                    console.log(response);

                    // Handle success
                    if (response.trim() === "success") {
                        $("#success-alert").text("Seller registered successfully.").show();
                        // Optionally clear form fields or update UI
                        $('#inputEmail').val(''); // Example of clearing the email field

                        // Append new seller to the sellers list dynamically
                        var newSeller = {
                            user_name: "New Seller Name", // Replace with actual data
                            user_email: $('#inputEmail').val(), // Example: Fetch from input field
                            user_phone: "1234567890", // Replace with actual data
                            user_address: "123 Street, City", // Replace with actual data
                            user_city: "City", // Replace with actual data
                            user_id: 1 // Replace with actual user ID if needed
                        };

                        appendSellerToList(newSeller); // Function to append seller to the list
                    } else {
                        $("#error-alert").text("This user does not exist! Please enter correct email!").show();
                    }
                },
                error: function(xhr, status, error) {
                    // Handle error
                    console.error(xhr.responseText);
                    $("#error-alert").text("Error: " + xhr.responseText).show();
                }
            });
        });

        // Function to append new seller to the sellers list
        function appendSellerToList(seller) {
            $('tbody').append(
                `<tr id="seller-${seller.id}">
                    <td>${seller.name}</td>
                    <td>${seller.email}</td>
                    <td>${seller.phone}</td>
                    <td>${seller.address}</td>
                    <td>${seller.city}</td>
                    <td>
                        <a href="show-seller-profile.jsp?user_id=${seller.id}"
                           class="btn btn-primary" style="background-color: limegreen">Profile</a>
                    </td>
                </tr>`
            );
        }
    });
</script>





<!-- Script Section -->
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="admin-assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="admin-assets/vendor/chart.js/chart.umd.js"></script>
<script src="admin-assets/vendor/echarts/echarts.min.js"></script>
<script src="admin-assets/vendor/quill/quill.js"></script>
<script src="admin-assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="admin-assets/vendor/tinymce/tinymce.min.js"></script>
<script src="admin-assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="admin-assets/js/main.js"></script>

</body>

</html>