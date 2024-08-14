<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="uz.pdp.uzummarket.service.NotificationService" %>
<%@ page import="uz.pdp.uzummarket.repositories.NotificationRepository" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard</title>

    <!-- Favicons -->
    <link href="/admin-assets/img/favicon.png" rel="icon">
    <link href="/admin-assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>

<body>

<header id="header" class="header fixed-top d-flex align-items-center">
    <div class="d-flex align-items-center justify-content-between">
        <div class="logo d-flex align-items-center">
            <img src="/admin-assets/img/logo.png" alt="Logo" style="max-height: 40px;">
            <span class="d-none d-lg-block">SELLER</span>
        </div>
        <i class="bi bi-list toggle-sidebar-btn"></i>
    </div>

    <div class="search-bar">
        <form class="search-form d-flex align-items-center" method="POST" action="#">
            <input type="text" name="query" placeholder="Search" title="Enter search keyword">
            <button type="submit" title="Search"><i class="bi bi-search"></i></button>
        </form>
    </div>

    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

            <%
                User user = (User) session.getAttribute("user");
                if (user == null || user.getId() == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
                NotificationService notificationService = new NotificationService(new NotificationRepository());
                long unreadCount = notificationService.countUnreadNotificationsByUserId(user.getId());
                request.setAttribute("unreadCount", unreadCount);
            %>

            <!-- Notifications Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link nav-icon" href="/show-notifications">
                    <i class="bi bi-bell"></i>
                    <c:if test="${unreadCount > 0}">
                        <span class="badge bg-primary badge-number">
                            <c:out value="${unreadCount}" />
                        </span>
                    </c:if>
                </a>
            </li>

            <!-- Messages Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link nav-icon" href="/show-messages">
                    <i class="bi bi-chat-left-text"></i>
                    <c:if test="${messageCount > 0}">
                        <span class="badge bg-success badge-number">
                            <c:out value="${messageCount}" />
                        </span>
                    </c:if>
                </a>
            </li>

            <!-- User Profile Dropdown -->
            <li class="nav-item dropdown pe-3">
                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle fs-4 me-2"></i>
                    <span class="d-none d-md-block dropdown-toggle ps-2">
                        <%
                            String sellerName = user.getFirstName() + " " + user.getLastName();
                        %>
                        <%= sellerName %>
                    </span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                    <li class="dropdown-header">
                        <h6><%= sellerName %></h6>
                        <span>SELLER</span>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item d-flex align-items-center" href="/seller-profile.jsp"><i class="bi bi-person"></i><span>My Profile</span></a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item d-flex align-items-center" href="/users-profile.jsp"><i class="bi bi-gear"></i><span>Account Settings</span></a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item d-flex align-items-center" href="/logout.jsp"><i class="bi bi-box-arrow-right"></i><span>Sign Out</span></a></li>
                </ul>
            </li>

        </ul>
    </nav>
</header>

<aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-item"><a class="nav-link collapsed" href="/seller.jsp"><i class="bi bi-grid"></i><span>Dashboard</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/addProduct.jsp"><i class="bi bi-menu-button-wide"></i><span>Add Product</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/add-shop.jsp"><i class="bi bi-receipt"></i><span>Manage Shops</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/seller-profile.jsp"><i class="bi bi-person"></i><span>Profile</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="logout.jsp"><i class="bi bi-box-arrow-right"></i><span>Logout</span></a></li>
    </ul>
</aside>


<main id="main" class="main">
    <section class="section dashboard">
        <div class="row">
            <!-- Left side columns -->
            <div class="col-lg-8">
                <div class="row">
                    <!-- Customers Card -->
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        PreparedStatement pstmt = null;

                        PreparedStatement pstmtTotalShops = null;
                        ResultSet rsTotalCustomers = null;
                        ResultSet rsPreviousYearCustomers = null;
                        int totalCustomers = 0;
                        int previousYearCustomers = 0;
                        double percentageChangeCustomers = 0.0;
                        PreparedStatement pstmtTotalCustomers = null;
                        PreparedStatement pstmtPreviousYearCustomers = null;

                        PreparedStatement pstmtTotalProducts = null;
                        PreparedStatement pstmtPreviousYearProducts = null;
                        ResultSet rsTotalProducts = null;
                        ResultSet rsPreviousYearProducts = null;
                        int totalProducts = 0;
                        int previousYearProducts = 0;
                        double percentageChangeProducts = 0.0;

                        ResultSet rsTotalShops = null;
                        int totalShops = 0;
                        double percentageChangeShops = 0.0;

                        try {
                            // Get database connection
                            conn = DBConnection.getConnection();
                            stmt = conn.createStatement();


                            String sqlTotalShops = "SELECT COUNT(*) AS total FROM shops WHERE owner_id = ?";
                            pstmtTotalShops = conn.prepareStatement(sqlTotalShops);

                            pstmtTotalShops.setInt(1, user.getId());

                            rsTotalShops = pstmtTotalShops.executeQuery();

                            if (rsTotalShops.next()) {
                                totalShops = rsTotalShops.getInt("total");
                            }

                            // Query to get the total number of customers
                            String sqlTotalCustomers =
                                    "SELECT COUNT(DISTINCT u.id) AS total " +
                                    "FROM users u " +
                                    "JOIN orders o ON u.id = o.user_id " +
                                    "JOIN baskets b ON o.basket_id = b.basket_id " +  // Use basket_id for baskets table
                                    "JOIN products p ON p.id = b.product_id " +  // Use id for products table
                                    "JOIN shops s ON p.shop_id = s.id " +
                                    "WHERE s.owner_id = ?";

                            pstmtTotalCustomers = conn.prepareStatement(sqlTotalCustomers);
                            pstmtTotalCustomers.setInt(1, user.getId());
                            rsTotalCustomers = pstmtTotalCustomers.executeQuery();

                            if (rsTotalCustomers.next()) {
                                totalCustomers = rsTotalCustomers.getInt("total");
                            }

                            // Query for the number of such customers from the previous year
                            String sqlPreviousYearCustomers = "SELECT COUNT(DISTINCT u.id) AS total " +
                                    "FROM users u " +
                                    "JOIN orders o ON u.id = o.user_id " +
                                    "JOIN baskets b ON o.basket_id = b.basket_id " +
                                    "JOIN products p ON b.product_id = p.id " +
                                    "JOIN shops s ON p.shop_id = s.id " +
                                    "WHERE s.owner_id = ? AND o.date >= (CURRENT_DATE - INTERVAL '1 YEAR')";

                            pstmtPreviousYearCustomers = conn.prepareStatement(sqlPreviousYearCustomers);
                            pstmtPreviousYearCustomers.setInt(1, user.getId());
                            rsPreviousYearCustomers = pstmtPreviousYearCustomers.executeQuery();

                            if (rsPreviousYearCustomers.next()) {
                                previousYearCustomers = rsPreviousYearCustomers.getInt("total");
                            }

                            // Calculate percentage change for customers
                            if (previousYearCustomers != 0) {
                                percentageChangeCustomers = ((double)(totalCustomers - previousYearCustomers) / previousYearCustomers) * 100;
                            }

                            String sqlTotalProducts = "SELECT COUNT(*) AS total " +
                                    "FROM products p " +
                                    "JOIN shops s ON p.shop_id = s.id " +
                                    "WHERE s.owner_id = ?";

                            pstmtTotalProducts = conn.prepareStatement(sqlTotalProducts);
                            pstmtTotalProducts.setInt(1, user.getId()); // Set the seller's ID parameter
                            rsTotalProducts = pstmtTotalProducts.executeQuery();

                            if (rsTotalProducts.next()) {
                                totalProducts = rsTotalProducts.getInt("total");
                            }

                            // Query for the number of such products from the previous year
                            String sqlPreviousYearProducts = "SELECT COUNT(DISTINCT p.id) AS total " +
                                    "FROM products p " +
                                    "JOIN shops s ON p.shop_id = s.id " +
                                    "JOIN baskets b ON p.id = b.product_id " +
                                    "JOIN orders o ON b.basket_id = o.basket_id " +
                                    "WHERE s.owner_id = ? AND o.date >= (CURRENT_DATE - INTERVAL '1 YEAR')";

                            pstmtPreviousYearProducts = conn.prepareStatement(sqlPreviousYearProducts);
                            pstmtPreviousYearProducts.setInt(1, user.getId()); // Set the seller's ID parameter
                            rsPreviousYearProducts = pstmtPreviousYearProducts.executeQuery();

                            if (rsPreviousYearProducts.next()) {
                                previousYearProducts = rsPreviousYearProducts.getInt("total");
                            }

                            // Calculate percentage change for products
                            if (previousYearProducts != 0) {
                                percentageChangeProducts = ((double)(totalProducts - previousYearProducts) / previousYearProducts) * 100;
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        DecimalFormat df = new DecimalFormat("#.##");
                    %>

                    <!-- Customers Card -->
                    <div class="col-xxl-4 col-xl-12">
                        <div class="card info-card customers-card">
                            <div class="card-body">
                                <h5 class="card-title">Customer Orders <span>| This Year</span></h5>
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
                                <h5 class="card-title">Shops <span>| This Year</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-people"></i>
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
                    <!-- End Sellers Card -->


                    <!-- Shops Card -->
                    <div class="col-xxl-4 col-xl-12">
                        <div class="card info-card shops-card">
                            <div class="card-body">
                                <h5 class="card-title">Products <span>| This Year</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-shop"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6><%= totalProducts %></h6>
                                        <span class="<%= percentageChangeProducts < 0 ? "text-danger" : "text-success" %> small pt-1 fw-bold">
                                            <%= df.format(Math.abs(percentageChangeProducts)) %>%</span>
                                        <span class="text-muted small pt-2 ps-1"><%= percentageChangeProducts < 0 ? "decrease" : "increase" %></span>
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
                                        <th>Shop ID</th>
                                        <th scope="col">Shop Name</th>
                                        <th scope="col">Owner</th>
                                        <th scope="col">Address</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        conn = null;
                                        stmt = null;
                                        rs = null;

                                        try {
                                            conn = DBConnection.getConnection();

                                            if (conn == null) {
                                                throw new SQLException("Failed to obtain database connection.");
                                            }
                                            Integer userId = user.getId();

                                            String sql = "SELECT s.id, s.name, s.address, CONCAT(u.firstname, ' ', u.lastname) AS ownerName " +
                                                    "FROM shops s " +
                                                    "JOIN users u ON s.owner_id = u.id " +
                                                    "WHERE s.owner_id = ?";

                                            pstmt = conn.prepareStatement(sql);
                                            pstmt.setInt(1, userId);

                                            rs = pstmt.executeQuery();

                                            while (rs.next()) {
                                                int shopId = rs.getInt("id");
                                                String shopName = rs.getString("name");
                                                String ownerName = rs.getString("ownerName");
                                                String address = rs.getString("address");
                                    %>
                                    <tr>
                                        <td><%= shopId %></td>
                                        <td><%= shopName %></td>
                                        <td><%= ownerName %></td>
                                        <td><%= address %></td>
                                    </tr>
                                    <%
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        } finally {
                                            try {
                                                if (rs != null) rs.close();
                                                if (stmt != null) stmt.close();
                                                if (conn != null) conn.close();
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            }
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

<!-- Vendor JS Files -->
<script src="/admin-assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="/admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/admin-assets/vendor/chart.js/chart.min.js"></script>
<script src="/admin-assets/vendor/echarts/echarts.min.js"></script>
<script src="/admin-assets/vendor/quill/quill.min.js"></script>
<script src="/admin-assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="/admin-assets/vendor/tinymce/tinymce.min.js"></script>

<!-- Template Main JS File -->
<script src="/admin-assets/js/main.js"></script>

</body>
</html>