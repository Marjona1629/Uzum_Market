<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.service.ShopService" %>
<%@ page import="uz.pdp.uzummarket.entities.Shop" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page import="java.util.Properties" %>
<%@ page import="uz.pdp.uzummarket.service.ProductService" %>
<%@ page import="uz.pdp.uzummarket.service.NotificationService" %>
<%@ page import="uz.pdp.uzummarket.repositories.NotificationRepository" %>
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
            max-width: 700px; /* Slightly smaller width */
            padding: 20px;
            background-color: #fff;
            border-radius: 8px; /* Slightly smaller border radius */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 0 auto;
        }

        /* Title */
        .container h3 {
            margin-bottom: 20px;
            font-size: 1.6rem; /* Slightly smaller font size */
            color: #333;
        }

        /* Form Layout */
        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px; /* Reduced gap */
            margin-bottom: 15px;
        }

        .form-col {
            flex: 1;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 15px;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            font-size: 0.9rem; /* Slightly smaller font size */
            border-radius: 4px; /* Slightly smaller border radius */
            border: 1px solid #ced4da;
            box-sizing: border-box;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select {
            height: 35px; /* Adjust height */
        }

        .form-group textarea {
            height: 90px; /* Adjust height */
            resize: vertical;
        }

        .form-control:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 0.2rem rgba(76, 175, 80, 0.25);
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
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
            display: inline-block;
            background-color: #007bff; /* Blue color */
            color: white;
            border-radius: 4px; /* Adjusted border radius */
            padding: 8px 16px; /* Smaller padding */
            cursor: pointer;
            text-align: center;
            font-size: 0.9rem; /* Smaller font size */
        }

        .custom-file-input label:hover {
            background-color: #0056b3;
        }

        .file-notification {
            margin-top: 10px;
            color: #4CAF50;
        }

        .btn-success {
            background-color: #4CAF50;
            border-color: #4CAF50;
            font-size: 1rem;
            padding: 12px 20px; /* Larger padding */
            border-radius: 4px; /* Adjusted border radius */
        }

        .btn-success:hover {
            background-color: #45a049;
            border-color: #45a049;
        }

        /* Shop Card Styles (Optional) */
        .shop-card {
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 15px;
            position: relative;
        }

        .shop-actions {
            margin-top: 15px;
            text-align: right;
        }

        .shop-actions .btn {
            margin-left: 10px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
    </style>

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
                // Assuming you have a method to get unread notifications count
                NotificationService notificationService = new NotificationService(NotificationRepository.getInstance());
                User user = (User) session.getAttribute("user");
                if (user == null || user.getId() == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
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
                    <li><a class="dropdown-item d-flex align-items-center" href="logout.jsp"><i class="bi bi-box-arrow-right"></i><span>Sign Out</span></a></li>
                </ul>
            </li>
        </ul>
    </nav><!-- End Icons Navigation -->
</header><!-- End Header -->

<aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-item"><a class="nav-link collapsed" href="/seller.jsp"><i class="bi bi-grid"></i><span>Dashboard</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/addProduct.jsp"><i class="bi bi-menu-button-wide"></i><span>Add Product</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/add-shop.jsp"><i class="bi bi-receipt"></i><span>Manage Shops</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/seller-profile.jsp"><i class="bi bi-person"></i><span>Profile</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="logout.jsp"><i class="bi bi-box-arrow-right"></i><span>Logout</span></a></li>
    </ul>
</aside>

<%
    CategoryService categoryService = new CategoryService();
    List<Category> categories = categoryService.getAllCategories();
    request.setAttribute("categories", categories);

    ShopService shopService = new ShopService();
    List<Shop> sellerShops = shopService.getShopsBySeller(user);
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
<script src="/admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
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