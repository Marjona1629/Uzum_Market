<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>
<%@ page import="org.hibernate.stat.internal.CategorizedStatistics" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Seller</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="admin-assets/img/favicon.png" rel="icon">
    <link href="admin-assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="admin-assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="admin-assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="admin-assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="admin-assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="admin-assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="admin-assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="admin-assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="admin-assets/css/style.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-size: 400% 400%;
            animation: gradientAnimation 15s ease infinite;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        @keyframes gradientAnimation {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        .container {
            width: 400px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .container h3 {
            margin-bottom: 20px;
        }

        .form-control {
            margin-bottom: 10px;
        }

        .custom-file-input {
            position: relative;
            overflow: hidden;
            margin-top: 10px;
        }

        .custom-file-input input[type='file'] {
            position: absolute;
            font-size: 100px;
            opacity: 0;
            right: 0;
            top: 0;
        }

        .custom-file-input label {
            display: block;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            padding: 12px 20px;
            cursor: pointer;
            width: 100%;
            text-align: center;
        }

        .custom-file-input label:hover {
            background-color: #45a049;
        }
    </style>

</head>

<body>

<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
        <a href="index.html" class="logo d-flex align-items-center">
            <img src="admin-assets/img/logo.png" alt="">
            <span class="d-none d-lg-block">SELLER</span>
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
                    String sql = "SELECT * FROM users WHERE role = 'SELLER' LIMIT 1";
                    rs = stmt.executeQuery(sql);

                    // Assuming there is only one admin in your system, LIMIT 1 is used
                    if (rs.next()) {
                        String adminFirstName = rs.getString("first_name");
                        String adminLastName = rs.getString("last_name");
                        String adminRole = rs.getString("role");
            %>

            <li class="nav-item dropdown pe-3">
                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle fs-4 me-2"></i> <!-- Admin Icon -->
                    <span class="d-none d-md-block dropdown-toggle ps-2"><%= adminFirstName %> <%= adminLastName %></span>
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
                        <a class="dropdown-item d-flex align-items-center" href="users-profile.html">
                            <i class="bi bi-person"></i>
                            <span>My Profile</span>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="users-profile.html">
                            <i class="bi bi-gear"></i>
                            <span>Account Settings</span>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="logout.jsp">
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

</header><!-- End Header -->

<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link collapsed" href="seller.jsp">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li><!-- End Dashboard Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="addProduct.jsp">
                <i class="bi bi-menu-button-wide"></i>
                <span>Add Product</span>
            </a>
        </li><!-- End Show Sellers Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="add-shop.jsp">
                <i class="bi bi-receipt"></i>
                <span>Add shop</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="seller-profile.jsp">
                <i class="bi bi-person"></i>
                <span>Profile</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" href="${pageContext.request.contextPath}/logout">
                <i class="bi bi-arrow-bar-left"></i>
                <span>Logout</span>
            </a>
        </li>
        <!-- End Register Nav -->
    </ul>

</aside><!-- End Sidebar -->

<%
    CategoryService categoryService = new CategoryService();
    List<Category> categories = categoryService.getAllCategories();
    request.setAttribute("categories", categories);
%>
<div class="container">
    <h3>Add Product</h3>

    <form action="addProductServlet" method="post" enctype="multipart/form-data">
        <input type="text" class="form-control" name="productName" placeholder="Product Name" required>
        <textarea class="form-control" name="productDescription" placeholder="Product Description" required></textarea>
        <input type="text" class="form-control" name="productPrice" placeholder="Product Price" required>
        <input type="text" class="form-control" name="productDiscount" placeholder="Product Discount">

        <input type="number" class="form-control" name="productQuantity" placeholder="Product Quantity" required>

        <!-- Select Category dropdown -->
        <select class="form-control" name="categoryId" required>
            <option value="" disabled selected>Select Category</option>
            <%
                for (Category category : categories) {
            %>
            <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
            <%
                }
            %>
        </select>

        <div class="custom-file-input">
            <label for="file">Choose Product Image</label>
            <input type="file" id="file" name="productImage" required>
        </div>

        <button type="submit" class="btn btn-success" style="margin-top: 20px; font-size: 18px; padding: 12px 24px;">Add Product</button>
    </form>
</div>


<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<!-- Your Custom JS -->
<script src="css_files/js/enter.js"></script>


<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

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