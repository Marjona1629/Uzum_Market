
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="uz.pdp.uzummarket.entities.User" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Uzum Market">
    <meta name="keywords" content="html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Uzum Market</title>

    <!-- Google Font -->

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">



    <!-- Css Styles -->
    <link rel="stylesheet" href="/assets/css_files/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/style.css" type="text/css">

    <style>
        .form-control {
            width: 100%;
            box-sizing: border-box;
        }

        .alert {
            border-radius: 8px;
            padding: 20px;
            background-color: #ceb0e0;
            color: #904bb7;
        }

        .alert-link {
            color: #975fb7;
            text-decoration: underline;
        }

        .alert-link:hover {
            color: #904bb7;
        }
        #search-suggestions {
            position: absolute;
            border: 1px solid #ccc;
            max-height: 150px;
            overflow-y: auto;
            background-color: #6f3cce;
            z-index: 1000;
            width: calc(100% - 22px); /* Adjust according to input width */
        }

        .suggestion-item {
            padding: 10px;
            cursor: pointer;
        }

        .suggestion-item:hover {
            background-color: #6f3cce;
        }
        .header__cart {
            display: inline-block;
            margin: 5px;
        }

        .header__cart a {
            display: block;
            padding: 10px 20px;
            text-decoration: none;
            color: black;
            transition: background-color 0.3s ease;
        }

        .header__cart a:hover {
            background-color: #b6b4b7;
        }

        .profile-header img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
        }

        .profile-header h2 {
            margin-top: 10px;
        }

        .profile-info {
            margin-bottom: 20px;
        }

        .profile-info .info-item {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
            border-bottom: 1px solid #ddd;
        }

        .profile-info .info-item:last-child {
            border-bottom: none;
        }

        .profile-info .info-item span {
            font-weight: bold;
        }
        .profile-container profile-container rounded bg-white mt-5 mb-5 {
            border: 2px solid #ddd; /* Adjust border thickness and color as needed */
            border-radius: 8px; /* Optional: adds rounded corners */
            padding: 20px; /* Optional: adds space inside the border */
        }


        .btn-primary {
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            padding: 12px 20px;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
        }

        .btn-primary:hover {
            background-color: #45a049;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #BA68C8;
        }

        .profile-button {
            background: rgb(99, 39, 120);
            box-shadow: none;
            border: none;
        }

        .profile-button:hover {
            background: #682773;
        }

        .profile-button:focus {
            background: #682773;
            box-shadow: none;
        }

        .profile-button:active {
            background: #682773;
            box-shadow: none;
        }

        .back:hover {
            color: #682773;
            cursor: pointer;
        }

        .labels {
            font-size: 11px;
        }

        .add-experience:hover {
            background: #BA68C8;
            color: #fff;
            cursor: pointer;
            border: solid 1px #BA68C8;
        }
        .back-button {
            background-color: #6f3cce; /* Adjust background color */
            color: white; /* Text color */
            border: none; /* Remove border */
            padding: 10px 20px; /* Padding */
            border-radius: 5px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor on hover */
            font-size: 16px; /* Font size */
            margin-top: 10px; /* Margin on top */
        }

        .back-button:hover {
            background-color: #6f3cce; /* Darker color on hover */
        }
    </style>

</head>

<body>
<!-- Page Preloder -->
<div id="preloder">
    <div class="loader"></div>
</div>

<!-- Header Section Begin -->
<header class="header">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="header__logo">
                    <img src="/assets/img/uzum_market_logo.png" alt="">
                </div>
            </div>

            <div class="col-lg-6 d-flex align-items-center justify-content-end">
                <div class="header__cart">
                    <%
                        String username = (String) session.getAttribute("username");
                        if (username != null) {
                    %>
                    <a href="/app/profile"><i class="fa fa-user-o"></i> <%= username %></a>
                    <%
                    } else {
                    %>
                    <a href="/login"><i class="fa fa-user-o"></i> Cabinet</a>
                    <%
                        }
                    %>
                </div>
                <div class="header__cart">
                    <a href="favorite.jsp"><i class="fa fa-heart-o"></i> Favorite</a>
                </div>
                <div class="header__cart">
                    <a href="basket.jsp"><i class="fa fa-shopping-basket"></i> Basket</a>
                </div>
                <div class="header__top__right__language">
                    <img src="/assets/img/language.png" alt=""><a>English</a>
                    <%--<span class="arrow_carrot-down"></span>--%>
                    <ul>
                        <li><a href="#">Uzbek</a></li>
                        <li><a href="#">English</a></li>
                        <li><a href="#">Russian</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Header Section End -->

<!-- Hero Section Begin -->
<section class="hero">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="hero__categories">
                    <button onclick="window.location.href='/app/home'" class="back-button">
                        Back to Home
                    </button>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="hero__search">
                    <div class="hero__search__form">
                        <form id="search-form" action="searchResults.jsp" method="get">
                            <div style="position: relative;">
                                <input type="text" placeholder="What do you need?" id="search-input" onkeyup="searchProducts()">
                                <button type="submit" class="site-btn">SEARCH</button>
                                <div id="search-suggestions"></div>
                            </div>
                        </form>
                    </div>
                    <div class="hero__search__phone">
                        <div class="hero__search__phone__icon">
                            <i class="fa fa-phone"></i>
                        </div>
                        <div class="hero__search__phone__text">
                            <h5>+99894 022 11 44</h5>
                            <span>Support 24/7</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<form action="/app/updateProfile" method="post">
    <%
        User user = (User) session.getAttribute("user");
        if (user != null) {
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
                    <form action="updateProfile" method="post">
                        <div class="row mt-2">
                            <div class="col-md-6">
                                <label class="labels">First Name</label>
                                <input
                                        type="text"
                                        class="form-control"
                                        placeholder="Enter First Name"
                                        name="firstName"
                                        value="<%= user.getFirstName() != null ? user.getFirstName() : "" %>"                            >
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Last Name</label>
                                <input
                                        type="text"
                                        class="form-control"
                                        placeholder="Enter Last Name"
                                        name="lastName"
                                        value="<%= user.getLastName() != null ? user.getLastName() : "" %>"                            >
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
                                        value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
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
                                        value="<%= user.getAddress() != null ? user.getAddress() : "" %>">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label class="labels">Country</label>
                                <select name="country" id="country" class="form-control">
                                    <option value="" <%= user.getState() == null ? "selected" : "" %>>Select Country...</option>
                                    <option value="USA" <%= "USA".equals(user.getState()) ? "selected" : "" %>>USA</option>
                                    <option value="Canada" <%= "Canada".equals(user.getState()) ? "selected" : "" %>>Canada</option>
                                    <option value="UK" <%= "UK".equals(user.getState()) ? "selected" : "" %>>UK</option>
                                    <option value="Australia" <%= "Australia".equals(user.getState()) ? "selected" : "" %>>Australia</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label class="labels">City</label>
                                <select name="city" id="city" class="form-control">
                                    <option value="" <%= user.getCity() == null ? "selected" : "" %>>Select City...</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label class="labels">Gender</label>
                                <select name="gender" class="form-control">
                                    <option value="male" <%= "male".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Male</option>
                                    <option value="female" <%= "female".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Female</option>
                                    <option value="other" <%= "other".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Other</option>
                                </select>
                            </div>
                        </div>
                        <div class="mt-5 text-center">
                            <button class="btn btn-primary profile-button" type="submit">Save Profile</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <% } else { %>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="alert alert-warning text-center" role="alert">
                    User not found. Please <a href="/login" class="alert-link">Login</a> again.
                </div>
            </div>
        </div>
    </div>
    <% } %>
</form>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const countrySelect = document.getElementById('country');
        const citySelect = document.getElementById('city');

        const citiesByCountry = {
            "USA": ["New York", "Los Angeles", "Chicago", "Houston"],
            "Canada": ["Toronto", "Vancouver", "Montreal", "Calgary"],
            "UK": ["London", "Manchester", "Birmingham", "Leeds"],
            "Australia": ["Sydney", "Melbourne", "Brisbane", "Perth"]
        };

        function updateCities() {
            const selectedCountry = countrySelect.value;
            const cities = citiesByCountry[selectedCountry] || [];

            citySelect.innerHTML = '<option value="">Select City...</option>';

            cities.forEach(city => {
                const option = document.createElement('option');
                option.value = city;
                option.textContent = city;
                citySelect.appendChild(option);
            });
        }

        countrySelect.addEventListener('change', updateCities);
        updateCities();
    });
</script>

<script src="/admin-assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/assets/css_files/js/jquery-3.3.1.min.js"></script>
<script src="/assets/css_files/js/bootstrap.min.js"></script>
<script src="/assets/css_files/js/jquery.nice-select.min.js"></script>
<script src="/assets/css_files/js/jquery-ui.min.js"></script>
<script src="/assets/css_files/js/jquery.slicknav.js"></script>
<script src="/assets/css_files/js/mixitup.min.js"></script>
<script src="/assets/css_files/js/owl.carousel.min.js"></script>
<script src="/assets/css_files/js/main.js"></script>
</body>

</html>