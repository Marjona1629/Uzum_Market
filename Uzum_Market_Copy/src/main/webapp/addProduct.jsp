<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.service.ShopService" %>
<%@ page import="uz.pdp.uzummarket.entities.Shop" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard</title>

    <link href="/admin-assets/img/favicon.png" rel="icon">
    <link href="/admin-assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <link href="/admin-assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/admin-assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/admin-assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/admin-assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/admin-assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/admin-assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/admin-assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <link href="/admin-assets/css/style.css" rel="stylesheet">


    <style>
        /* Overall Container */
        .container {
            width: 100%;
            max-width: 800px;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 0 auto;
        }

        /* Title */
        .container h3 {
            margin-bottom: 20px;
            font-size: 1.8rem;
            color: #333;
        }

        /* Form Layout */
        /* Form Layout */
        .form-row {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 15px;
        }

        .form-col {
            flex: 1;
        }

        /* Ensure consistency in height */
        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            font-size: 1rem;
            border-radius: 5px;
            border: 1px solid #ced4da;
            box-sizing: border-box; /* Ensure padding and border are included in the element's total width and height */
        }

        .form-group input[type="text"] {
            height: 40px; /* Adjust height to ensure alignment */
        }

        .form-group input[type="number"] {
            height: 40px; /* Adjust height to ensure alignment */
        }

        .form-group select {
            height: 40px; /* Adjust height to ensure alignment */
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
        }

        .form-control:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 0.2rem rgba(76, 175, 80, 0.25);
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
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
            text-align: center;
            font-size: 1rem;
        }

        .custom-file-input label:hover {
            background-color: #45a049;
        }

        .file-notification {
            margin-top: 10px;
            color: #4CAF50;
        }

        .btn-success {
            background-color: #4CAF50;
            border-color: #4CAF50;
            font-size: 1rem;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .btn-success:hover {
            background-color: #45a049;
            border-color: #45a049;
        }
    </style>
</head>
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

            <!-- Notifications Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-bell"></i>
                    <span class="badge bg-primary badge-number">4</span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
                    <li class="dropdown-header">
                        You have 4 new notifications
                        <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <c:forEach var="notification" items="${notifications}">
                        <li class="notification-item">
                            <i class="bi ${notification.icon} text-${notification.color}"></i>
                            <div>
                                <h4>${notification.title}</h4>
                                <p>${notification.message}</p>
                                <p>${notification.time}</p>
                            </div>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                    </c:forEach>
                    <li class="dropdown-footer">
                        <a href="#">Show all notifications</a>
                    </li>
                </ul>
            </li>

            <!-- Messages Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-chat-left-text"></i>
                    <span class="badge bg-success badge-number">3</span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages">
                    <li class="dropdown-header">
                        You have 3 new messages
                        <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <c:forEach var="message" items="${messages}">
                        <li class="message-item">
                            <a href="#">
                                <img src="${message.image}" alt="" class="rounded-circle">
                                <div>
                                    <h4>${message.sender}</h4>
                                    <p>${message.content}</p>
                                    <p>${message.time}</p>
                                </div>
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                    </c:forEach>
                    <li class="dropdown-footer">
                        <a href="#">Show all messages</a>
                    </li>
                </ul>
            </li>

            <!-- User Profile Dropdown -->
            <li class="nav-item dropdown pe-3">
                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle fs-4 me-2"></i>
                    <span class="d-none d-md-block dropdown-toggle ps-2">
                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            String sellerName = "Seller";
                            try {
                                conn = DBConnection.getConnection();
                                stmt = conn.createStatement();
                                String sql = "SELECT firstName, lastName FROM users WHERE role = 'SELLER' LIMIT 1";
                                rs = stmt.executeQuery(sql);
                                if (rs.next()) {
                                    sellerName = rs.getString("firstName") + " " + rs.getString("lastName");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                            }
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
                    <li><a class="dropdown-item d-flex align-items-center" href="logout.jsp"><i class="bi bi-box-arrow-right"></i><span>Sign Out</span></a></li>
                </ul>
            </li>
        </ul>
    </nav>
</header>

<aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-item"><a class="nav-link collapsed" href="/seller.jsp"><i class="bi bi-grid"></i><span>Dashboard</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/addProduct.jsp"><i class="bi bi-menu-button-wide"></i><span>Add Product</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/add-shop.jsp"><i class="bi bi-receipt"></i><span>Add Shop</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/seller-profile.jsp"><i class="bi bi-person"></i><span>Profile</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="logout.jsp"><i class="bi bi-box-arrow-right"></i><span>Logout</span></a></li>
    </ul>
</aside>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getId() == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    CategoryService categoryService = new CategoryService();
    List<Category> categories = categoryService.getAllCategories();
    request.setAttribute("categories", categories);

    ShopService shopService = new ShopService();
    List<Shop> sellerShops = shopService.getShopsBySellerId(user);
    request.setAttribute("sellerShops", sellerShops);
%>

<div class="container">
    <h3>Add Product</h3>

    <form action="/app/seller/addProductServlet" method="post" enctype="multipart/form-data">
        <div class="form-row">
            <div class="form-col">
                <div class="form-group">
                    <label for="productName">Product Name</label>
                    <input type="text" class="form-control" id="productName" name="productName" placeholder="Product Name" required>
                </div>
                <div class="form-group">
                    <label for="productDescription">Product Description</label>
                    <textarea class="form-control" id="productDescription" name="productDescription" placeholder="Product Description" required></textarea>
                </div>
                <div class="form-group">
                    <label for="productPrice">Product Price</label>
                    <input type="text" class="form-control" id="productPrice" name="productPrice" placeholder="Product Price" required>
                </div>
            </div>
            <div class="form-col">
                <div class="form-group">
                    <label for="productDiscount">Product Discount</label>
                    <input type="text" class="form-control" id="productDiscount" name="productDiscount" placeholder="Product Discount">
                </div>
                <div class="form-group">
                    <label for="productQuantity">Product Quantity</label>
                    <input type="number" class="form-control" id="productQuantity" name="productQuantity" placeholder="Product Quantity" required>
                </div>
                <div class="form-group">
                    <label for="categoryId">Select Category</label>
                    <select class="form-control" id="categoryId" name="productCategory" required>
                        <option value="" disabled selected>Select Category</option>
                        <%
                            for (Category category : categories) {
                        %>
                        <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="shopId">Select Shop</label>
                    <select class="form-control" id="shopId" name="productShop" required>
                        <option value="" disabled selected>Select Shop</option>
                        <%
                            for (Shop shop : sellerShops) {
                        %>
                        <option value="<%= shop.getId() %>"><%= shop.getName() %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="productImage">Choose Product Image</label>
            <div class="custom-file-input">
                <input type="file" id="productImage" name="productImage" required>
                <label for="productImage">Choose Image</label>
            </div>
            <div class="file-notification" id="fileNotification"></div>
        </div>
        <button type="submit" class="btn btn-success mt-3">Add Product</button>
    </form>
</div>

<script>
    document.getElementById('productImage').addEventListener('change', function() {
        var notification = document.getElementById('fileNotification');
        if (this.files.length > 0) {
            notification.textContent = 'Image selected: ' + this.files[0].name;
        } else {
            notification.textContent = '';
        }
    });
</script>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
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