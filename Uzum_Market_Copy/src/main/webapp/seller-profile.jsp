<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Seller</title>
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
                            <img src="/admin-assets/img/messages-1.jpg" alt="" class="rounded-circle">
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
                            <img src="/admin-assets/img/messages-3.jpg" alt="" class="rounded-circle">
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
                        String sellerFirstName = rs.getString("first_name");
                        String sellerLastName = rs.getString("last_name");
                        String sellerRole = rs.getString("role");
            %>

            <li class="nav-item dropdown pe-3">
                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle fs-4 me-2"></i> <!-- Admin Icon -->
                    <span class="d-none d-md-block dropdown-toggle ps-2"><%= sellerFirstName %> <%= sellerLastName %></span>
                </a><!-- End Profile Image Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                    <li class="dropdown-header">
                        <h6><%= sellerFirstName %> <%= sellerLastName %></h6>
                        <span><%= sellerRole %></span>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="#">
                            <i class="bi bi-person"></i>
                            <span>My Profile</span>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="/users-profile.html">
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
            <a class="nav-link collapsed" href="/seller.jsp">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li><!-- End Dashboard Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="/addProduct.jsp">
                <i class="bi bi-menu-button-wide"></i>
                <span>Add Product</span>
            </a>
        </li><!-- End Show Sellers Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="/add-shop.jsp">
                <i class="bi bi-receipt"></i>
                <span>Add shop</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="/seller-profile.jsp">
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


<main id="main" class="main">

    <%
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DBConnection.getConnection();
            String query = "SELECT first_name, last_name, user_email, user_phone, user_address, user_city, user_state, user_gender, date_time FROM users WHERE role = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, "ADMIN");
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String adminFullName = resultSet.getString("first_name") + " " + resultSet.getString("last_name");
                String adminEmail = resultSet.getString("user_email");
                String adminPhone = resultSet.getString("user_phone");
                String adminAddress = resultSet.getString("user_address");
                String adminCity = resultSet.getString("user_city");
                String adminState = resultSet.getString("user_state");
                String adminGender = resultSet.getString("user_gender");
                Timestamp dateTime = resultSet.getTimestamp("date_time");

                // Set seller information in session attributes for later use
                session.setAttribute("adminFullName", adminFullName);
                session.setAttribute("adminEmail", adminEmail);
                session.setAttribute("adminPhone", adminPhone);
                session.setAttribute("adminAddress", adminAddress);
                session.setAttribute("adminCity", adminCity);
                session.setAttribute("adminState", adminState);
                session.setAttribute("adminGender", adminGender);
                session.setAttribute("dateTime", dateTime);
            } else {
                // Handle case where no admin information found
                // Optionally set default values or handle differently
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

    <!-- Profile -->
    <section class="section profile">
        <div class="row">
            <div class="col-xl-4">
                <div class="card">
                    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                        <img style="width: 1000px" src="<%= session.getAttribute("adminGender")
                        .equals("Female") ? "admin-assets/img/female.png" : "admin-assets/img/male.png" %>" alt="Profile" class="rounded-circle">
                        <h2><%= session.getAttribute("adminFullName") %></h2>
                        <!-- Display admin's job title or role here if available -->
                        <div class="social-links mt-2">
                            <a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
                            <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
                            <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
                            <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-8">
                <div class="card">
                    <div class="card-body pt-3">
                        <div class="tab-content pt-2">
                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                <h5 class="card-title">Profile Details</h5>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">Full Name</div>
                                    <div class="col-lg-9 col-md-8"><%= session.getAttribute("adminFullName") %></div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Email</div>
                                    <div class="col-lg-9 col-md-8"><%= session.getAttribute("adminEmail") %></div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Phone</div>
                                    <div class="col-lg-9 col-md-8"><%= session.getAttribute("adminPhone") %></div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Gender</div>
                                    <div class="col-lg-9 col-md-8"><%= session.getAttribute("adminGender") %></div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Date Joined</div>
                                    <div class="col-lg-9 col-md-8"><%= session.getAttribute("dateTime") %></div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Address</div>
                                    <div class="col-lg-9 col-md-8"><%= session.getAttribute("adminAddress") %></div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">City</div>
                                    <div class="col-lg-9 col-md-8"><%= session.getAttribute("adminCity") %></div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">State</div>
                                    <div class="col-lg-9 col-md-8"><%= session.getAttribute("adminState") %></div>
                                </div>

                            </div><!-- End Profile Overview -->

                        </div><!-- End Tab Content -->
                    </div><!-- End Card Body -->
                </div><!-- End Card -->
            </div><!-- End Col -->
        </div><!-- End Row -->
    </section><!-- End Profile Section -->


</main><!-- End #main -->

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<!-- Your Custom JS -->
<script src="/css_files/js/enter.js"></script>


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
<script src="/admin-assets/js/main.js"></script>

</body>

</html>