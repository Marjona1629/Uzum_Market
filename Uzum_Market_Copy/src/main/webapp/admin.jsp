<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>
<%@ page import="uz.pdp.uzummarket.service.AdminService" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>ADMIN</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/admin-assets/img/favicon.png" rel="icon">
    <link href="/admin-assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="/admin-assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/admin-assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/admin-assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/admin-assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/admin-assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/admin-assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/admin-assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="/admin-assets/css/style.css" rel="stylesheet">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
            <img src="admin-assets/img/logo.png" alt="">
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
                        <a class="dropdown-item d-flex align-items-center" href="adminprofile.jsp">
                            <i class="bi bi-person"></i>
                            <span>My Profile</span>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="coming-soon.jsp">
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
            <a class="nav-link collapsed" href="admin.jsp">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li><!-- End Dashboard Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="show-sellers.jsp">
                <i class="bi bi-menu-button-wide"></i>
                <span>Show Sellers</span>
            </a>
        </li><!-- End Show Sellers Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="register-seller.jsp">
                <i class="bi bi-receipt"></i>
                <span>Register Seller</span>
            </a>
        </li><!-- End Register Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="manage-user.jsp">
                <i class="bi bi-controller"></i>
                <span>Manage Users</span>
            </a>
        </li><!-- End Manage Users Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="create-category.jsp">
                <i class="bi bi-database-fill-add"></i>
                <span>Add Category</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" href="adminprofile.jsp">
                <i class="ri-user-settings-fill"></i>
                <span>Settings</span>
            </a>
        </li><!-- End Profile Nav -->

    </ul>

</aside><!-- End Sidebar -->

<main id="main" class="main">

    <div class="pagetitle">
        <h1>Dashboard</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item active">Dashboard</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
        <div class="row">

            <!-- Left side columns -->
            <div class="col-lg-8">
                <div class="row">


                    <%
                     AdminService   adminService =  AdminService.getInstance();

                        int totalCustomers = adminService.getTotalCustomers();
                        int previousYearCustomers = adminService.getPreviousYearCustomers();
                        double percentageChangeCustomers = adminService.calculatePercentageChange(totalCustomers, previousYearCustomers);

                        int totalSellers = adminService.getTotalSellers();
                        int previousYearSellers = adminService.getPreviousYearSellers();
                        double percentageChangeSellers = adminService.calculatePercentageChange(totalSellers, previousYearSellers);

                        int totalShops = adminService.getTotalShops();
                        int previousYearShops = adminService.getPreviousYearShops();
                        double percentageChangeShops = adminService.calculatePercentageChange(totalShops, previousYearShops);

                        DecimalFormat df = new DecimalFormat("#.##");
                    %>

                    <!-- Customers Card -->
                    <div class="col-xxl-4 col-xl-12">
                        <div class="card info-card customers-card">
                            <div class="card-body">
                                <h5 class="card-title">Customers <span>| This Year</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6><%= totalCustomers %></h6>
                                        <span class="<%= percentageChangeCustomers < 0 ? "text-danger" : "text-success" %> small pt-1 fw-bold">
                        <%= df.format(Math.abs(percentageChangeCustomers)) %>%</span>
                                        <span class="text-muted small pt-2 ps-1"><%= percentageChangeCustomers < 0 ? "decrease" : "increase" %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Customers Card -->

                    <!-- Sellers Card -->
                    <div class="col-xxl-4 col-xl-12">
                        <div class="card info-card sellers-card">
                            <div class="card-body">
                                <h5 class="card-title">Sellers <span>| This Year</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6><%= totalSellers %></h6>
                                        <span class="<%= percentageChangeSellers < 0 ? "text-danger" : "text-success" %> small pt-1 fw-bold">
                        <%= df.format(Math.abs(percentageChangeSellers)) %>%</span>
                                        <span class="text-muted small pt-2 ps-1"><%= percentageChangeSellers < 0 ? "decrease" : "increase" %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Sellers Card -->

                    <!-- Shops Card -->
                    <div class="col-xxl-4 col-xl-12">
                        <div class="card info-card shops-card">
                            <div class="card-body">
                                <h5 class="card-title">Shops <span>| This Year</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-shop"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6><%= totalShops %></h6>
                                        <span class="<%= percentageChangeShops < 0 ? "text-danger" : "text-success" %> small pt-1 fw-bold">
                        <%= df.format(Math.abs(percentageChangeShops)) %>%</span>
                                        <span class="text-muted small pt-2 ps-1"><%= percentageChangeShops < 0 ? "decrease" : "increase" %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Shops Card -->


                    <%
                        adminService =  AdminService.getInstance();
                        List<Map<String, Object>> shopList = adminService.getShopListWithOwners();
                    %>

                    <!-- Shop List -->
                    <div class="col-12">
                        <div class="card recent-sales overflow-auto">
                            <div class="card-body">
                                <h5 class="card-title">Shops List</h5>

                                <table class="table table-borderless datatable">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Shop Name</th>
                                        <th>Owner Name</th>
                                        <th>Address</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for (Map<String, Object> shop : shopList) {
                                            int shopId = (int) shop.get("id");
                                            String shopName = (String) shop.get("name");
                                            String ownerName = (String) shop.get("firstName") + " " + (String) shop.get("lastName");
                                            String address = (String) shop.get("address");
                                    %>
                                    <tr>
                                        <th scope="row"><a href="#"><%= shopId %></a></th>
                                        <td><%= shopName %></td>
                                        <td><%= ownerName %></td>
                                        <td><%= address %></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- End Shop List -->


                </div>
            </div><!-- End Left side columns -->

            <!-- Right side columns -->
            <div class="col-lg-4">


                <!-- Website Traffic -->
                <div class="card">
                    <div class="filter">
                        <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                            <li class="dropdown-header text-start">
                                <h6>Filter</h6>
                            </li>

                            <li><a class="dropdown-item" href="#">Today</a></li>
                            <li><a class="dropdown-item" href="#">This Month</a></li>
                            <li><a class="dropdown-item" href="#">This Year</a></li>
                        </ul>
                    </div>

                    <div class="card-body pb-0">
                        <h5 class="card-title">Website Traffic <span>| Today</span></h5>

                        <div id="trafficChart" style="min-height: 400px;" class="echart"></div>

                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                echarts.init(document.querySelector("#trafficChart")).setOption({
                                    tooltip: {
                                        trigger: 'item'
                                    },
                                    legend: {
                                        top: '5%',
                                        left: 'center'
                                    },
                                    series: [{
                                        name: 'Access From',
                                        type: 'pie',
                                        radius: ['40%', '70%'],
                                        avoidLabelOverlap: false,
                                        label: {
                                            show: false,
                                            position: 'center'
                                        },
                                        emphasis: {
                                            label: {
                                                show: true,
                                                fontSize: '18',
                                                fontWeight: 'bold'
                                            }
                                        },
                                        labelLine: {
                                            show: false
                                        },
                                        data: [{
                                            value: 1048,
                                            name: 'Search Engine'
                                        },
                                            {
                                                value: 735,
                                                name: 'Direct'
                                            },
                                            {
                                                value: 580,
                                                name: 'Email'
                                            },
                                            {
                                                value: 484,
                                                name: 'Union Ads'
                                            },
                                            {
                                                value: 300,
                                                name: 'Video Ads'
                                            }
                                        ]
                                    }]
                                });
                            });
                        </script>

                    </div>
                </div><!-- End Website Traffic -->

            </div><!-- End Right side columns -->

        </div>
    </section>

</main><!-- End #main -->


<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="/admin-assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="/admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/admin-assets/vendor/chart.js/chart.umd.js"></script>
<script src="/admin-assets/vendor/echarts/echarts.min.js"></script>
<script src="/admin-assets/vendor/quill/quill.js"></script>
<script src="/admin-assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="/admin-assets/vendor/tinymce/tinymce.min.js"></script>
<script src="/admin-assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="/admin-assets/js/main.js" rel="stylesheet"></script>

</body>

</html>