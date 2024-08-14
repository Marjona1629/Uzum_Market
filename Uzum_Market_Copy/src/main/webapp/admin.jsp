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


<main id="main" class="main">


    <section class="section dashboard">
        <div class="row">

            <!-- Left side columns -->
            <div class="col-lg-8">
                <div class="row">

                    <!-- Customers Card -->

                    <%
                        ResultSet rsTotalCustomers = null;
                        ResultSet rsPreviousYearCustomers = null;
                        ResultSet rsTotalSellers = null;
                        ResultSet rsPreviousYearSellers = null;
                        int totalCustomers = 0;
                        int previousYearCustomers = 0;
                        int totalSellers = 0;
                        int previousYearSellers = 0;
                        double percentageChangeCustomers = 0.0;
                        double percentageChangeSellers = 0.0;

                        try {
                            // Get database connection
                            conn = DBConnection.getConnection();
                            stmt = conn.createStatement();

                            // Query to get the total number of customers
                            String sqlTotalCustomers = "SELECT COUNT(*) AS total FROM users WHERE role = 'CUSTOMER'";
                            rsTotalCustomers = stmt.executeQuery(sqlTotalCustomers);
                            if (rsTotalCustomers.next()) {
                                totalCustomers = rsTotalCustomers.getInt("total");
                            }

                            // Query to get the number of customers from the previous year for percentage calculation
                            String sqlPreviousYearCustomers = "SELECT COUNT(*) AS total FROM users WHERE role = 'CUSTOMER' AND date_time >= (CURRENT_DATE - INTERVAL '1 YEAR')";
                            rsPreviousYearCustomers = stmt.executeQuery(sqlPreviousYearCustomers);
                            if (rsPreviousYearCustomers.next()) {
                                previousYearCustomers = rsPreviousYearCustomers.getInt("total");
                            }

                            // Calculate percentage change for customers
                            if (previousYearCustomers != 0) {
                                percentageChangeCustomers = ((double)(totalCustomers - previousYearCustomers) / previousYearCustomers) * 100;
                            }

                            // Query to get the total number of sellers
                            String sqlTotalSellers = "SELECT COUNT(*) AS total FROM users WHERE role = 'SELLER'";
                            rsTotalSellers = stmt.executeQuery(sqlTotalSellers);
                            if (rsTotalSellers.next()) {
                                totalSellers = rsTotalSellers.getInt("total");
                            }

                            // Query to get the number of sellers from the previous year for percentage calculation
                            String sqlPreviousYearSellers = "SELECT COUNT(*) AS total FROM users WHERE role = 'SELLER' AND date_time >= (CURRENT_DATE - INTERVAL '1 YEAR')";
                            rsPreviousYearSellers = stmt.executeQuery(sqlPreviousYearSellers);
                            if (rsPreviousYearSellers.next()) {
                                previousYearSellers = rsPreviousYearSellers.getInt("total");
                            }

                            // Calculate percentage change for sellers
                            if (previousYearSellers != 0) {
                                percentageChangeSellers = ((double)(totalSellers - previousYearSellers) / previousYearSellers) * 100;
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rsTotalCustomers != null) try { rsTotalCustomers.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (rsPreviousYearCustomers != null) try { rsPreviousYearCustomers.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (rsTotalSellers != null) try { rsTotalSellers.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (rsPreviousYearSellers != null) try { rsPreviousYearSellers.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }

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



                    <%
                        conn = null;
                        PreparedStatement pstmt = null;
                        rs = null;
                        totalSellers = 0;
                        percentageChangeSellers = 0.0;
                        df = new DecimalFormat("#.##");

                        try {
                            // Get database connection
                            conn = DBConnection.getConnection();

                            // Query to get the total number of sellers this year
                            String sqlTotalSellers = "SELECT COUNT(*) AS total FROM users WHERE role = 'SELLER'";
                            pstmt = conn.prepareStatement(sqlTotalSellers);
                            rs = pstmt.executeQuery();

                            if (rs.next()) {
                                totalSellers = rs.getInt("total");
                            }

                            // Query to get the total number of sellers last year
                            String sqlTotalSellersLastYear = "SELECT COUNT(*) AS total FROM users WHERE role = 'SELLER' AND EXTRACT(YEAR FROM created_at) = EXTRACT(YEAR FROM CURRENT_DATE) - 1";
                            pstmt = conn.prepareStatement(sqlTotalSellersLastYear);
                            rs = pstmt.executeQuery();

                            int totalSellersLastYear = 0;
                            if (rs.next()) {
                                totalSellersLastYear = rs.getInt("total");
                            }

                            // Calculate percentage change
                            if (totalSellersLastYear > 0) {
                                percentageChangeSellers = ((double) (totalSellers - totalSellersLastYear) / totalSellersLastYear) * 100;
                            } else {
                                percentageChangeSellers = 100.0;  // If there were no sellers last year, consider it a 100% increase.
                            }

                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            // Close the resources
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        }
                    %>

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


                    <%
                        ResultSet rsTotalShops = null;
                        ResultSet rsPreviousYearShops = null;
                        int totalShops = 0;
                        int previousYearShops = 0;
                        double percentageChangeShops = 0.0;

                        try {
                            // Get database connection
                            conn = DBConnection.getConnection();
                            stmt = conn.createStatement();

                            // Query to get the total number of shops
                            String sqlTotalShops = "SELECT COUNT(*) AS total FROM shops";
                            rsTotalShops = stmt.executeQuery(sqlTotalShops);
                            if (rsTotalShops.next()) {
                                totalShops = rsTotalShops.getInt("total");
                            }

                            // Query to get the number of shops from the previous year for percentage calculation
                            String sqlPreviousYearShops = "SELECT COUNT(*) AS total FROM shops WHERE date_time >= (CURRENT_DATE - INTERVAL '1 YEAR')";
                            rsPreviousYearShops = stmt.executeQuery(sqlPreviousYearShops);
                            if (rsPreviousYearShops.next()) {
                                previousYearShops = rsPreviousYearShops.getInt("total");
                            }

                            // Calculate percentage change for shops
                            if (previousYearShops != 0) {
                                percentageChangeShops = ((double)(totalShops - previousYearShops) / previousYearShops) * 100;
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rsTotalShops != null) try { rsTotalShops.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (rsPreviousYearShops != null) try { rsPreviousYearShops.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }

                        df = new DecimalFormat("#.##");
                    %>

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


                    <!-- List Shops -->
                    <div class="col-12">
                        <div class="card top-selling overflow-auto">

                            <div class="card-body pb-0">
                                <h5 class="card-title">Shops</h5>

                                <table class="table table-borderless">
                                    <thead>
                                    <tr>
                                        <th >Shop ID</th>
                                        <th scope="col">Shop Name</th>
                                        <th scope="col">Owner</th>
                                        <th scope="col">Address</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        rs = null;
                                        conn = null;
                                        stmt = null;

                                        try {
                                            // Get database connection
                                            conn = DBConnection.getConnection();
                                            stmt = conn.createStatement();

                                            // Adjusted query to join shops with users
                                            String sql = "SELECT shops.id, shops.name, shops.address, users.firstName, users.lastName " +
                                                    "FROM shops " +
                                                    "JOIN users ON shops.owner_id = users.id"; // Adjust 'owner_id' to actual foreign key if it exists

                                            rs = stmt.executeQuery(sql);

                                            while (rs.next()) {
                                                int id = rs.getInt("id");
                                                String shopName = rs.getString("name");
                                                String address = rs.getString("address");
                                                String ownerFirstName = rs.getString("firstName");
                                                String ownerLastName = rs.getString("lastName");
                                                String ownerName = ownerFirstName + " " + ownerLastName;
                                    %>
                                    <tr>
                                        <th scope="row"><a href="#"><%= id %></a></th>
                                        <td><%= shopName %></td>
                                        <td><%= ownerName %></td>
                                        <td><%= address %></td>
                                    </tr>
                                    <%
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        } finally {
                                            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                                            if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                                            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                                        }
                                    %>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>


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
                                        data: [
                                            { value: 1048, name: 'Search Engine' },
                                            { value: 735, name: 'Direct' },
                                            { value: 580, name: 'Email' },
                                            { value: 484, name: 'Union Ads' },
                                            { value: 300, name: 'Video Ads' }
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