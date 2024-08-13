<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="uz.pdp.uzummarket.service.NotificationService" %>
<%@ page import="uz.pdp.uzummarket.repositories.NotificationRepository" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard</title>
    <link rel="stylesheet" href="styles.css">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Favicons -->
    <link href="/admin-assets/img/favicon.png" rel="icon">
    <link href="/admin-assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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
    <style>/* Profile Container */
    /* Profile Container */
    .profile-container {
        background-color: #f0f4f8; /* Light background for profile details */
        border-radius: 12px; /* Rounded corners */
        padding: 40px; /* Padding inside the container */
        box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1); /* Shadow for depth */
        max-width: 1000px; /* Maximum width */
        width: 100%; /* Full width */
        box-sizing: border-box; /* Include padding and border in width and height */
        margin: 20px auto; /* Center container with margin */
    }

    /* Profile Image */
    .profile-header img {
        width: 120px; /* Width of profile picture */
        height: 120px; /* Height of profile picture */
        border-radius: 50%; /* Circular profile picture */
        margin-right: 20px; /* Space between image and text */
    }

    /* Profile Header Title */
    .profile-header h2 {
        font-size: 36px; /* Font size for heading */
        color: #333; /* Text color */
    }

    /* Info Item */
    .profile-info .info-item {
        margin-bottom: 15px; /* Space between info items */
        font-size: 18px; /* Font size for profile info */
    }

    .profile-info .info-item span {
        font-weight: bold; /* Bold labels */
        color: #333; /* Label color */
    }

    /* Primary Button */
    .btn-primary {
        display: inline-block;
        padding: 15px 30px; /* Padding inside button */
        font-size: 18px; /* Font size */
        color: #fff; /* Text color */
        background-color: #007bff; /* Background color */
        border: none; /* No border */
        border-radius: 8px; /* Rounded corners */
        text-align: center;
        text-decoration: none; /* No underline */
        transition: background-color 0.3s ease; /* Transition effect */
    }

    .btn-primary:hover {
        background-color: #0056b3; /* Darker blue on hover */
    }

    /* Container for forms and other elements */
    .container {
        width: 100%;
        max-width: 800px;
        padding: 20px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin: 20px auto;
    }

    /* Form Group Styles */
    .form-group {
        margin-bottom: 15px; /* Space between form groups */
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #555;
    }

    /* Form Controls */
    .form-group input[type="text"],
    .form-group input[type="number"],
    .form-group select,
    .form-group textarea {
        width: 100%;
        font-size: 1rem;
        border-radius: 5px;
        border: 1px solid #ced4da;
        box-sizing: border-box; /* Include padding and border in width and height */
        padding: 8px 10px; /* Padding inside the fields */
        background-color: #fff; /* Background color */
        color: #555; /* Text color */
    }

    .form-group input[type="text"],
    .form-group input[type="number"],
    .form-group select {
        height: 40px; /* Height for text and number inputs */
    }

    .form-group textarea {
        height: 100px;
        resize: vertical; /* Allow vertical resize */
    }

    /* General Select Styles */
    select {
        width: 100%;
        height: 40px; /* Height for dropdown */
        font-size: 1rem; /* Font size */
        border-radius: 5px; /* Rounded corners */
        border: 1px solid #ced4da; /* Border color */
        padding: 8px 10px; /* Padding inside the dropdown */
        background-color: #fff; /* Background color */
        color: #555; /* Text color */
    }

    select:focus {
        border-color: #007bff; /* Border color on focus */
        outline: none; /* Remove default focus outline */
        box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.25); /* Shadow on focus */
    }

    /* Custom File Input Styles */
    .custom-file-input {
        position: relative;
        display: inline-block;
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
        background-color: #45a049; /* Hover color */
    }
    </style>

    <script>
        function updateCities() {
            const country = document.getElementById("country").value;
            const cityDropdown = document.getElementById("city");

            cityDropdown.innerHTML = "";

            let cities = [];

            if (country === "USA") {
                cities = ["San Francisco", "New York", "Los Angeles"];
            } else if (country === "Canada") {
                cities = ["Toronto", "Vancouver", "Montreal"];
            } else if (country === "UK") {
                cities = ["London", "Manchester", "Birmingham"];
            } else if (country === "Australia") {
                cities = ["Sydney", "Melbourne", "Brisbane"];
            }

            cities.forEach(function(city) {
                const option = document.createElement("option");
                option.value = city;
                option.textContent = city;
                cityDropdown.appendChild(option);
            });
        }
    </script>

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

<form action="/app/updateProfile" method="post">
    <% if (user != null) {
        String userGender = user.getGender();
        String femaleAvatarUrl = "https://bootdey.com/img/Content/avatar/avatar3.png";
        String maleAvatarUrl = "https://bootdey.com/img/Content/avatar/avatar6.png";
    %>

    <div class="container profile-container rounded bg-white mt-5 mb-5">
        <div class="row">
            <div class="col-md-3 border-right">
                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                    <img
                            class="rounded-circle mt-5"
                            width="150px"
                            src="<%= userGender != null && userGender.equalsIgnoreCase("female") ? femaleAvatarUrl : maleAvatarUrl %>"
                            alt="Profile Picture"
                    >
                    <br>
                    <span class="font-weight-bold"><%= user.getUsername() %></span>
                </div>
            </div>
            <div class="col-md-9 border-right">
                <div class="p-3 py-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right">Profile Settings</h4>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6">
                            <label class="labels">First Name</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    placeholder="Enter First Name"
                                    name="firstName"
                                    value="<%= user.getFirstName() != null ? user.getFirstName() : "" %>"
                            >
                        </div>
                        <div class="col-md-6">
                            <label class="labels">Last Name</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    placeholder="Enter Last Name"
                                    name="lastName"
                                    value="<%= user.getLastName() != null ? user.getLastName() : "" %>"
                            >
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label class="labels">Email</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    placeholder="Email ID"
                                    name="email"
                                    value="<%= user.getEmail() %>"
                            >
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label class="labels">Phone Number</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    placeholder="Enter Phone Number"
                                    name="phone"
                                    value="<%= user.getPhone() != null ? user.getPhone() : "" %>"
                            >
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label class="labels">Address</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    placeholder="Enter Address Line 1"
                                    name="address"
                                    value="<%= user.getAddress() != null ? user.getAddress() : "" %>"
                            >
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label class="labels">Country</label>
                            <select name="country" id="country" class="form-control" onchange="updateCities()">
                                <option value="" <%= user.getState() == null ? "selected" : "" %>>Select Country...</option>
                                <option value="USA" <%= "USA".equals(user.getState()) ? "selected" : "" %>>USA</option>
                                <option value="Canada" <%= "Canada".equals(user.getState()) ? "selected" : "" %>>Canada</option>
                                <option value="UK" <%= "UK".equals(user.getState()) ? "selected" : "" %>>UK</option>
                                <option value="Australia" <%= "Australia".equals(user.getState()) ? "selected" : "" %>>Australia</option>
                            </select>
                        </div>
                    </div>

                    <!-- City Select -->
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label class="labels">City</label>
                            <select name="city" id="city" class="form-control">
                                <!-- Options will be populated dynamically by JavaScript -->
                            </select>
                        </div>
                    </div>

                    <!-- Gender Select -->
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label class="labels">Gender</label>
                            <select name="gender" class="form-control">
                                <option value="male" <%= "male".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="female" <%= "female".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Female</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } %>
</form>

<script src="/admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/admin-assets/vendor/quill/quill.min.js"></script>

<script src="/admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/assets/css_files/js/jquery-3.3.1.min.js"></script>
<script src="/assets/css_files/js/bootstrap.min.js"></script>
<script src="/assets/css_files/js/jquery.nice-select.min.js"></script>
<script src="/assets/css_files/js/jquery-ui.min.js"></script>
<script src="/assets/css_files/js/jquery.slicknav.js"></script>
<script src="/assets/css_files/js/mixitup.min.js"></script>
<script src="/assets/css_files/js/owl.carousel.min.js"></script>
<script src="/assets/css_files/js/main.js"></script>

<script src="/assets/js/jquery-3.3.1.min.js"></script>
<script src="/assets/js/bootstrap.min.js"></script>
<script src="/assets/js/jquery.nice-select.min.js"></script>
<script src="/assets/js/jquery-ui.min.js"></script>
<script src="/assets/js/jquery.slicknav.js"></script>
<script src="/assets/js/owl.carousel.min.js"></script>
<script src="/assets/js/main.js"></script>

</body>
</html>