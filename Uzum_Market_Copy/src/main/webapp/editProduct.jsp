<%@ page import="uz.pdp.uzummarket.service.NotificationService" %>
<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="uz.pdp.uzummarket.repositories.NotificationRepository" %>
<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<img src="${pageContext.request.contextPath}/images/${product.images}" alt="${product.name}" style="max-width: 200px;"/>
<img src="https://via.placeholder.com/200" alt="${product.name}" style="max-width: 200px;"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Edit Product</title>
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
        .container h2 {
            margin-bottom: 20px;
            font-size: 1.8rem;
            color: #333;
        }

        /* Form Container */
        .form-container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        /* Left Side */
        .form-left {
            flex: 1;
        }

        /* Right Side */
        .form-right {
            flex: 1;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            font-size: 1rem;
            border-radius: 5px;
            border: 1px solid #ced4da;
            box-sizing: border-box;
            padding: 8px;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select {
            height: 40px;
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
        }

        /* Image Preview */
        .image-preview {
            text-align: center;
        }

        .image-preview img {
            max-width: 100%;
            border-radius: 5px;
        }

        /* File Input and Buttons */
        .form-actions {
            margin-top: 20px;
        }

        .custom-file-input {
            display: inline-block;
        }

        .custom-file-input input[type="file"] {
            display: none;
        }

        .custom-file-input label {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            display: inline-block;
            cursor: pointer;
            font-size: 14px;
        }

        /* Update Product Button */
        .btn-update {
            display: block;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 4px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        .btn-update:hover {
            background-color: #45a049;
        }

        /* Image Preview */
        .image-preview {
            text-align: center;
        }

        .image-preview img {
            max-width: 100%;
            height: auto; /* Maintain aspect ratio */
            border-radius: 5px;
            display: block; /* Ensure it does not have extra space below */
            margin: 0 auto; /* Center image */
        }

        .shift-up {
            margin-top: -8mm; /* Adjust the value as needed */
        }

        /* Textarea Styling */
        .form-group textarea {
            width: 100%;
            font-size: 1rem;
            border-radius: 5px;
            border: 1px solid #ced4da;
            box-sizing: border-box; /* Ensure padding and border are included in the element's total width and height */
            padding: 8px;
            resize: vertical; /* Allows users to resize vertically */
            min-height: 100px; /* Set a minimum height */
        }


        .image-preview {
            text-align: center;
            margin: 10px 0;
        }

        .image-preview img {
            max-width: 100%;
            height: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            object-fit: cover;
        }
    </style>
</head>

<body>

<!-- ======= Header ======= -->
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
                <span>Manage Shops</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="seller-profile.jsp">
                <i class="bi bi-person"></i>
                <span>Profile</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" href="logout.jsp">
                <i class="bi bi-box-arrow-right"></i>
                <span>Logout</span>
            </a>
        </li>

    </ul>

</aside><!-- End Sidebar -->

<%
    Product product = (Product) request.getAttribute("product");
    request.setAttribute("product", product);
%>


<div class="container" style="margin-top: -15mm;">
    <h2>Edit Product</h2>
    <form action="/editProduct" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productId" value="${productId}" />

        <div class="form-container">
            <!-- Left Side -->
            <div class="form-left">
                <div class="form-group">
                    <label for="productName">Product Name:</label>
                    <input type="text" id="productName" name="productName" value="${product.name}" />
                </div>

                <div class="form-group">
                    <label for="productDescription">Product Description:</label>
                    <textarea id="productDescription" name="productDescription">${product.description}</textarea>
                </div>
            </div>

            <!-- Right Side -->
            <div class="form-right">
                <div class="form-group">
                    <label for="productPrice">Product Price:</label>
                    <input type="number" id="productPrice" name="productPrice" value="${product.price}" step="0.01" />
                </div>

                <div class="form-group">
                    <label for="productDiscount">Product Discount:</label>
                    <input type="number" id="productDiscount" name="productDiscount" value="${product.discount}" step="0.01" />
                </div>

                <div class="form-group">
                    <label for="productQuantity">Product Quantity:</label>
                    <input type="number" id="productQuantity" name="productQuantity" value="${product.quantity}" />
                </div>

                <div class="form-group">
                    <label for="category">Product Category:</label>
                    <select id="category" name="category">
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}"
                                    <c:if test="${product.category != null && product.category.categoryId == category.categoryId}">selected</c:if>>
                                    ${category.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="shop">Product Shop:</label>
                    <select id="shop" name="shop" >
                        <c:forEach var="shop" items="${sellerShops}">
                            <option value="${shop.id}"
                                    <c:if test="${product.shop != null && product.shop.id == shop.id}">selected</c:if>>
                                    ${shop.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

        <!-- File Input and Buttons -->
        <div class="form-actions">
            <div class="form-group">
                <label for="productImage">Choose Product Image</label>
                <div class="custom-file-input">
                    <input type="file" id="productImage" name="productImage">
                    <label for="productImage">Choose Image</label>
                </div>
                <div class="file-notification" id="fileNotification"></div>
            </div>

            <div class="form-group">
                <button type="submit" class="btn-update">Update Product</button>
            </div>
        </div>
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

<!-- Vendor JS Files -->
<script src="admin-assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="admin-assets/vendor/chart.js/chart.min.js"></script>
<script src="admin-assets/vendor/echarts/echarts.min.js"></script>
<script src="admin-assets/vendor/quill/quill.min.js"></script>
<script src="admin-assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="admin-assets/vendor/tinymce/tinymce.min.js"></script>
<script src="admin-assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="admin-assets/js/main.js"></script>

</body>
</html>