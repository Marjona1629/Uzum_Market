<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="uz.pdp.uzummarket.service.NotificationService" %>
<%@ page import="uz.pdp.uzummarket.repositories.NotificationRepository" %>
<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.entities.Shop" %>
<%@ page import="uz.pdp.uzummarket.service.ProductService" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>
<%@ page import="uz.pdp.uzummarket.service.ShopService" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Edit Product</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

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

    <!-- Favicons -->
    <link href="admin-assets/img/favicon.png" rel="icon">
    <link href="admin-assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <style>
        .add-product-margin {
            margin-top: 20px;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .form-col {
            flex: 1;
            min-width: 300px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-control {
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
            width: 100%;
        }

        .form-control-file {
            display: block;
            width: 100%;
            border-radius: 5px;
            padding: 10px;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-align: center;
            display: inline-block;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn-primary:focus, .btn-primary:active {
            background-color: #004085;
            outline: none;
            box-shadow: 0 0 0 3px rgba(38, 143, 255, 0.5);
        }

        .custom-file-input {
            position: relative;
            display: inline-block;
        }

        .custom-file-input input[type="file"] {
            position: absolute;
            top: 0;
            right: 0;
            height: 100%;
            width: 100%;
            opacity: 0;
        }

        .custom-file-input label {
            display: block;
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-radius: 5px;
            padding: 10px;
            text-align: center;
            cursor: pointer;
        }

        .file-notification {
            margin-top: 10px;
            color: #6c757d;
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
    </div><!-- End Search Bar -->

    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

            <%
                NotificationService notificationService = new NotificationService(NotificationRepository.getInstance());
                User user = (User) session.getAttribute("user");
                if (user == null || user.getId() == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                ProductService productService = new ProductService();
                CategoryService categoryService = new CategoryService();
                ShopService shopService = new ShopService();

                int productId = Integer.parseInt(request.getParameter("id"));
                Product product = productService.getProductById(productId);
                List<Category> categories = categoryService.getAllCategories();
                List<Shop> sellerShops = shopService.getAllShops();

                request.setAttribute("product", product);
                request.setAttribute("categories", categories);
                request.setAttribute("sellerShops", sellerShops);


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

<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-item"><a class="nav-link collapsed" href="seller.jsp"><i class="bi bi-grid"></i><span>Dashboard</span></a></li><!-- End Dashboard Nav -->
        <li class="nav-item"><a class="nav-link collapsed" href="addProduct.jsp"><i class="bi bi-menu-button-wide"></i><span>Add Product</span></a></li><!-- End Show Sellers Nav -->
        <li class="nav-item"><a class="nav-link collapsed" href="add-shop.jsp"><i class="bi bi-receipt"></i><span>Manage Shops</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="seller-profile.jsp"><i class="bi bi-person"></i><span>Profile</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="logout.jsp"><i class="bi bi-box-arrow-right"></i><span>Logout</span></a></li>
    </ul>
</aside><!-- End Sidebar -->

<div class="container add-product-margin">
    <form action="/app/seller/editProductServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productId" value="${product.id}">

        <div class="form-row">
            <div class="form-col">
                <div class="form-group">
                    <label for="productName">Product Name</label>
                    <input type="text" class="form-control" id="productName" name="productName" placeholder="Product Name" value="${product.name}" required>
                </div>
                <div class="form-group">
                    <label for="productDescription">Product Description</label>
                    <textarea class="form-control" id="productDescription" name="productDescription" placeholder="Product Description" required>${product.description}</textarea>
                </div>
                <div class="form-group">
                    <label for="productPrice">Product Price</label>
                    <input type="text" class="form-control" id="productPrice" name="productPrice" placeholder="Product Price" value="${product.price}" required>
                </div>
            </div>
            <div class="form-col">
                <div class="form-group">
                    <label for="productDiscount">Product Discount</label>
                    <input type="text" class="form-control" id="productDiscount" name="productDiscount" placeholder="Product Discount" value="${product.discount}">
                </div>
                <div class="form-group">
                    <label for="productQuantity">Product Quantity</label>
                    <input type="number" class="form-control" id="productQuantity" name="productQuantity" placeholder="Product Quantity" value="${product.quantity}" required>
                </div>
                <div class="form-group">
                    <label for="categoryId">Select Category</label>
                    <select class="form-control" id="categoryId" name="productCategory" required>
                        <option value="" disabled>Select Category</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}" ${product.category.id == category.id ? 'selected' : ''}>${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="shopId">Select Shop</label>
                    <select class="form-control" id="shopId" name="productShop" required>
                        <option value="" disabled>Select Shop</option>
                        <c:forEach var="shop" items="${sellerShops}">
                            <option value="${shop.id}" ${product.shop.id == shop.id ? 'selected' : ''}>${shop.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="productImage">Choose Product Image</label>
            <div class="custom-file-input">
                <input type="file" id="productImage" name="productImage">
                <label for="productImage">Choose Image</label>
            </div>
            <c:if test="${not empty product.image}">
                <div class="current-image mt-2">
                    <img src="${product.image}" alt="Current Product Image" class="img-thumbnail" style="max-width: 200px;">
                </div>
            </c:if>
            <div class="file-notification" id="fileNotification"></div>
        </div>
        <button type="submit" class="btn btn-success mt-3">Update Product</button>
    </form>
</div>

<!-- Template Main JS File -->
<script src="admin-assets/js/main.js"></script>

<!-- Vendor JS Files -->
<script src="admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="admin-assets/vendor/php-email-form/validate.js"></script>
<script src="admin-assets/vendor/quill/quill.min.js"></script>
<script src="admin-assets/vendor/tinymce/tinymce.min.js"></script>
<script src="admin-assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="admin-assets/vendor/chart.js/chart.min.js"></script>
<script src="admin-assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="admin-assets/vendor/echarts/echarts.min.js"></script>

</body>

</html>