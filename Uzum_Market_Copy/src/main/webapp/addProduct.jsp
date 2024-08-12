<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.service.ShopService" %>
<%@ page import="uz.pdp.uzummarket.entities.Shop" %>
<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page import="uz.pdp.uzummarket.service.ProductService" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard</title>
    <link href="/admin-assets/css/style.css" rel="stylesheet">

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

        /* Product Cards */
        .product-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            overflow: hidden;
        }

        .product-card img {
            width: 100%;
            height: auto;
        }

        .product-card .card-body {
            padding: 15px;
        }

        .product-card .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .product-card .card-text {
            font-size: 1rem;
            margin-bottom: 10px;
        }

        .product-card .card-price {
            font-size: 1.125rem;
            font-weight: 600;
            color: #4CAF50;
        }

        .product-card .btn {
            font-size: 0.875rem;
            padding: 8px 16px;
            border-radius: 5px;
        }

         .add-product-margin {
             margin-top: 13mm;
         }

        .my-products-margin {
            margin-top: 15mm;
        }

        .product-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            overflow: hidden;
        }

        .product-card img {
            width: 100%;
            height: auto;
        }

        .product-card .card-body {
            padding: 15px;
        }

        .product-card .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .product-card .card-text {
            font-size: 1rem;
            margin-bottom: 10px;
        }

        .product-card .card-price {
            font-size: 1.125rem;
            font-weight: 600;
            color: #4CAF50;
        }

        .product-card .btn {
            font-size: 0.875rem;
            padding: 8px 16px;
            border-radius: 5px;
        }

        .custom-file-input {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .custom-file-input input[type="file"] {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }

        .custom-file-input label {
            background-color: #007bff; /* Blue color */
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            display: inline-block;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-success {
            display: block;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 4px;
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
                            User user = (User) session.getAttribute("user");
                            if (user == null || user.getId() == null) {
                                response.sendRedirect("login.jsp");
                                return;
                            }
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

<%
    // Retrieve categories and seller shops
    CategoryService categoryService = new CategoryService();
    List<Category> categories = categoryService.getAllCategories();
    request.setAttribute("categories", categories);

    ShopService shopService = new ShopService();
    List<Shop> sellerShops = shopService.getShopsBySeller(user);
    request.setAttribute("sellerShops", sellerShops);

    // Retrieve seller's products
    ProductService productService = new ProductService();
    List<Product> sellerProducts = productService.getProductsBySeller(user);
    request.setAttribute("sellerProducts", sellerProducts);
%>

<div class="container add-product-margin">
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

<div class="container my-products-margin">
    <h3>My Products</h3>
    <div class="row">
        <%
            List<Product> products = productService.getProductsBySeller(user);
            for (Product product : products) {
        %>
        <div class="col-md-4">
            <div class="product-card">
                <img src="<%= product.getImages() %>" alt="<%= product.getName() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <p class="card-price">$<%= product.getPrice() %></p>
                    <a href="/editProduct.jsp?id=<%= product.getId() %>" class="btn btn-primary">Edit</a>
                    <a href="/deleteProductServlet?id=<%= product.getId() %>" class="btn btn-danger">Delete</a>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
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