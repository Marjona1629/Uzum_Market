<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="uz.pdp.uzummarket.entities.User" %>
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

    <style>
        /* Profile Section Container */
        .profile-section {
            margin-top: -20px;
            margin-left: 300px; /* Offset for sidebar */
            display: flex;
            justify-content: center; /* Center content horizontally */
            padding: 40px; /* Padding around the profile section */
            width: calc(100% - 300px); /* Adjust width to account for sidebar */
            box-sizing: border-box; /* Include padding and border in element's total width and height */
        }

        /* Profile Container */
        .profile-container {
            background-color: #cedcea; /* Light background for profile details */
            border-radius: 12px; /* Rounded corners */
            padding: 40px; /* Padding inside the container */
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1); /* Shadow for depth */
            max-width: 1000px; /* Maximum width */
            width: 100%; /* Full width */
            box-sizing: border-box; /* Include padding and border in width and height */
            margin-top: -25mm; /* Move container up an additional 5 mm */
        }

        /* Profile Header */
        .profile-header {
            display: flex;
            align-items: center;
            text-align: center;
            margin-bottom: 30px; /* Space below header */
            margin-top: -25px; /* Move header up */
        }

        /* Profile Image */
        .profile-header img {
            margin-top: -25px; /* Move image up */
            width: 120px; /* Width of profile picture */
            height: 120px; /* Height of profile picture */
            border-radius: 50%; /* Circular profile picture */
            margin-right: 25px; /* Space between image and text */
        }

        /* Profile Header Title */
        .profile-header h2 {
            margin-top: -10px; /* Move title up */
            font-size: 36px; /* Font size for heading */
            color: #333; /* Text color */
        }

        /* Profile Info */
        .profile-info {
            margin-bottom: 30px; /* Space below info section */
        }

        /* Info Item */
        .profile-info .info-item {
            margin-bottom: 20px; /* Space between info items */
            font-size: 20px; /* Font size for profile info */
        }

        .profile-info .info-item span {
            font-weight: bold; /* Bold labels */
            color: #333; /* Label color */
        }

        /* Primary Button */
        .btn-primary {
            display: inline-block;
            padding: 15px 30px; /* Padding inside button */
            font-size: 20px; /* Font size */
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
            margin: 0 auto;
        }

        /* Form Group Styles */
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            font-size: 1rem;
            border-radius: 5px;
            border: 1px solid #ced4da;
            box-sizing: border-box; /* Include padding and border in width and height */
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

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
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
        <li class="nav-item"><a class="nav-link collapsed" href="/add-shop.jsp"><i class="bi bi-receipt"></i><span>Add Shop</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="/seller-profile.jsp"><i class="bi bi-person"></i><span>Profile</span></a></li>
        <li class="nav-item"><a class="nav-link collapsed" href="logout.jsp"><i class="bi bi-box-arrow-right"></i><span>Logout</span></a></li>
    </ul>
</aside>

<%
    if (user != null) {
        String femaleAvatarUrl = "https://bootdey.com/img/Content/avatar/avatar3.png";
        String maleAvatarUrl = "https://bootdey.com/img/Content/avatar/avatar6.png";
%>

<!-- Profile Section Begin -->
<section class="profile-section">
    <div class="container">
        <div class="profile-header">
            <div class="col-md-3 border-right">
                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                    <img
                            class="rounded-circle mt-5"
                            width="150px"
                            src="<%= user.getGender() != null && user.getGender().equalsIgnoreCase("female") ? femaleAvatarUrl : maleAvatarUrl %>"
                            alt="Profile Picture"
                    >
                </div>
            </div>
            <h2>Welcome, <%= user.getUsername() %></h2>
        </div>

        <div class="profile-container">
            <div class="profile-info">
                <div class="info-item">
                    <span>First Name:</span> <%= user.getFirstName() %></div>
                <div class="info-item">
                    <span>Last Name:</span> <%= user.getLastName() %></div>
                <div class="info-item">
                    <span>Email:</span> <%= user.getEmail() %></div>
                <div class="info-item">
                    <span>Phone:</span> <%= user.getPhone() %></div>
                <div class="info-item">
                    <span>Address:</span> <%= user.getAddress() %></div>
            </div>

            <a href="editProfile.jsp" class="btn btn-primary">Edit Profile</a>
        </div>
    </div>
</section>

<%}%>

<!-- Profile Section End -->
<script src="/admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/assets/js/jquery-3.3.1.min.js"></script>
<script src="/assets/js/bootstrap.min.js"></script>
<script src="/assets/js/jquery.nice-select.min.js"></script>
<script src="/assets/js/jquery-ui.min.js"></script>
<script src="/assets/js/jquery.slicknav.js"></script>
<script src="/assets/js/owl.carousel.min.js"></script>
<script src="/assets/js/main.js"></script>
<script>
    function searchProducts() {
        // Your JavaScript code for search suggestions
    }
</script>

</body>
</html>