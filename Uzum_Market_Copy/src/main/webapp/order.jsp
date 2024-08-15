
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="java.util.Map" %>
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
    </style>
    <style>
        .checkout__order {
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .checkout__order h4 {
            margin-bottom: 20px;
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }

        .checkout__order__products {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .checkout__order__products span {
            float: right;
            font-weight: normal;
        }

        .checkout__order ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .checkout__order ul li {
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

        .checkout__order ul li span {
            float: right;
        }

        .checkout__order__total {
            font-weight: bold;
            margin-top: 10px;
            font-size: 16px;
        }

        .checkout__order__total span {
            float: right;
        }

        .site-btn {
            background-color: #ff6f61;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .site-btn:hover {
            background-color: #e65a50;
        }

        .payment-select {
            margin-top: 15px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 100%;
            font-size: 14px;
        }
    </style>

</head>

<body>
<!-- Header Section Begin -->
<header class="header">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="header__logo">
                    <a href="${pageContext.request.contextPath}/home.jsp">
                        <img src="/assets/img/uzum_market_logo.png" alt="">
                    </a>
                </div>
            </div>

            <div class="col-lg-6 d-flex align-items-center justify-content-end">
                <div class="header__cart">
                    <%
                        String username = (String) session.getAttribute("username");
                        if (username != null) {
                    %>
                    <a href="profile.jsp"><i class="fa fa-user-o"></i> <%= username %></a>
                    <%
                    } else {
                    %>
                    <a href="login.jsp"><i class="fa fa-user-o"></i> Cabinet</a>
                    <%
                        }
                    %>
                </div>
                <div class="header__cart">
                    <a href="/app/favorites"><i class="fa fa-heart-o"></i> Favorite</a>
                </div>
                <div class="header__cart">
                    <a href="/app/addtobasket"><i class="fa fa-shopping-basket"></i> Basket</a>
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

<!-- Main Content -->
<div class="container">
    <div class="row">
        <div class="col-lg-4 col-md-6">
            <div class="checkout__order">
                <h4>Your Order</h4>
                <div class="checkout__order__products">Products <span>Total</span></div>
                <ul>
                    <%-- Check if productTotals is not null and not empty --%>
                    <%
                        Map<String, Double> productTotals = (Map<String, Double>) request.getAttribute("productTotals");
                        double total = (double) request.getAttribute("total");

                        if (productTotals != null && !productTotals.isEmpty()) {
                            for (Map.Entry<String, Double> entry : productTotals.entrySet()) {
                                String productName = entry.getKey();
                                double productTotal = entry.getValue();
                    %>
                    <li><%= productName %> <span>$<%= String.format("%.2f", productTotal) %></span></li>
                    <%
                        }
                    } else {
                    %>
                    <li>No products found.</li>
                    <%
                        }
                    %>
                </ul>
                <div class="checkout__order__total">Total <span>$<%= String.format("%.2f", total) %></span></div>
                <div>
                    <select class="payment-select">
                        <option value="cash">Cash</option>
                        <option value="card">Card</option>
                    </select>
                </div>
                <button type="submit" class="site-btn">ORDER</button>
            </div>
        </div>
    </div>
</div>


<!-- Footer Section Begin -->
<footer class="footer spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="footer__about">
                    <div class="footer__about__logo">
                        <a href="/app/home"><img src="/assets/img/uzum_market_logo.png" alt=""></a>
                    </div>
                    <ul>
                        <li>Address: Shaykhontohur district, Beshkent str</li>
                        <li>Phone: +99894 022 36 33</li>
                        <li>Email: uzummarket@gmail.com</li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6 offset-lg-1">
                <div class="footer__widget">
                    <h6>Useful Links</h6>
                    <ul>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">About Our Shop</a></li>
                        <li><a href="#">Secure Shopping</a></li>
                        <li><a href="#">Delivery infomation</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Our Sitemap</a></li>
                    </ul>
                    <ul>
                        <li><a href="#">Who We Are</a></li>
                        <li><a href="#">Our Services</a></li>
                        <li><a href="#">Projects</a></li>
                        <li><a href="#">Contact</a></li>
                        <li><a href="#">Innovation</a></li>
                        <li><a href="#">Testimonials</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-4 col-md-12">
                <div class="footer__widget">
                    <h6>Join Our Newsletter Now</h6>
                    <p>Get E-mail updates about our latest shop and special offers.</p>
                    <form action="#">
                        <input type="text" placeholder="Enter your mail">
                        <button type="submit" class="site-btn">Subscribe</button>
                    </form>
                    <div class="footer__widget__social">
                        <a href="#"><i class="fa fa-facebook"></i></a>
                        <a href="#"><i class="fa fa-instagram"></i></a>
                        <a href="#"><i class="fa fa-twitter"></i></a>
                        <a href="#"><i class="fa fa-pinterest"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- Footer Section End -->

<!-- Js Plugins -->
<script src="/assets/js_files/js/jquery-3.3.1.min.js"></script>
<script src="/assets/js_files/js/bootstrap.min.js"></script>
<script src="/assets/js_files/js/jquery.nice-select.min.js"></script>
<script src="/assets/js_files/js/jquery-ui.min.js"></script>
<script src="/assets/js_files/js/jquery.slicknav.js"></script>
<script src="/assets/js_files/js/mixitup.min.js"></script>
<script src="/assets/js_files/js/owl.carousel.min.js"></script>
<script src="/assets/js_files/js/main.js"></script>
</body>
</html>