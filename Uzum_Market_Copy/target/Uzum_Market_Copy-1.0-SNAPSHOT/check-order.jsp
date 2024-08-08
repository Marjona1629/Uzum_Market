<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Shop Detail</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="assets/css_files/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/style.css" type="text/css">
</head>

<body>
<!-- Page Preloder -->
<div id="preloder">
    <div class="loader"></div>
</div>

<!-- Humberger Begin -->

<!-- Header Section Begin -->
<header class="header" >
    <div class="container">
        <div class="row align-items-center">
            <!-- Logo Section -->
            <div class="col-lg-3 d-flex align-items-center">
                <div class="header__logo">
                    <a href="${pageContext.request.contextPath}/home.jsp">
                        <img src="assets/img/uzum_market_logo.png" alt="Uzum Market Logo">
                    </a>
                </div>
            </div>

            <!-- Menu Section -->
            <div class="col-lg-6 d-flex align-items-center">
                <nav class="header__menu w-100">
                    <ul class="d-flex justify-content-around m-0 p-0">
                        <li><a href="./index.html">Home</a></li>
                        <li><a href="./shop-grid.html">Shop</a></li>
                        <li><a href="#">Pages</a>
                            <ul class="header__menu__dropdown">
                                <li><a href="./shop-details.jsp">Shop Details</a></li>
                                <li><a href="./shoping-cart.jsp">Shopping Cart</a></li>
                                <li><a href="./checkout.html">Check Out</a></li>
                                <li><a href="./blog-details.html">Blog Details</a></li>
                            </ul>
                        </li>
                        <li class="active"><a href="./blog.html">Blog</a></li>
                        <li><a href="./contact.jsp">Contact</a></li>
                    </ul>
                </nav>
            </div>

            <!-- Auth and Cart Section -->
            <div class="col-lg-3 d-flex align-items-center justify-content-end">
                <!-- Cart Section -->
                <div class="header__cart d-flex align-items-center me-3">
                    <ul class="d-flex m-0 p-0">
                        <li class="me-3"><a href="#"><i class="fa fa-heart"></i></a></li>
                        <li><a href="basket.jsp"><i class="fa fa-shopping-bag"></i></a></li>
                    </ul>
                </div>

                <!-- Language Selector -->
                <div class="header__top__right__language d-flex align-items-center me-3">
                    <img src="assets/img/language.png" alt="Language" class="me-2">
                    <div class="me-2">English</div>
                    <span class="arrow_carrot-down"></span>
                    <ul class="dropdown-menu m-0 p-0">
                        <li><a href="#">Russian</a></li>
                        <li><a href="#">English</a></li>
                    </ul>
                </div>

                <!-- Authentication Links -->
                <div class="d-flex flex-column" style="max-width: 250px">
                    <div class="header__top__right__auth mb-2">
                        <a href="/login"><i class="fa fa-user"></i> Login</a>
                    </div>
                    <div class="header__top__right__auth">
                        <a href="/signup"><i class="fa fa-user-plus"></i> Sign Up</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</header>
<!-- Header Section End -->

<!-- Hero Section Begin -->
<section class="hero hero-normal">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="hero__categories">
                    <div class="hero__categories__all">
                        <i class="fa fa-bars"></i>
                        <span>All departments</span>
                    </div>
                    <ul>
                        <li><a href="#">Fresh Meat</a></li>
                        <li><a href="#">Vegetables</a></li>
                        <li><a href="#">Fruit & Nut Gifts</a></li>
                        <li><a href="#">Fresh Berries</a></li>
                        <li><a href="#">Ocean Foods</a></li>
                        <li><a href="#">Butter & Eggs</a></li>
                        <li><a href="#">Fastfood</a></li>
                        <li><a href="#">Fresh Onion</a></li>
                        <li><a href="#">Papayaya & Crisps</a></li>
                        <li><a href="#">Oatmeal</a></li>
                        <li><a href="#">Fresh Bananas</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="hero__search">
                    <div class="hero__search__form">
                        <form action="#">
                            <div class="hero__search__categories">
                                All Categories
                                <span class="arrow_carrot-down"></span>
                            </div>
                            <input type="text" placeholder="What do yo u need?">
                            <button type="submit" class="site-btn">SEARCH</button>
                        </form>
                    </div>
                    <div class="hero__search__phone">
                        <div class="hero__search__phone__icon">
                            <i class="fa fa-phone"></i>
                        </div>
                        <div class="hero__search__phone__text">
                            <h5>+65 11.188.888</h5>
                            <span>support 24/7 time</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Hero Section End -->
<div class="col-lg-4 col-md-6" style="margin-left: 500px;">
    <div class="checkout__order">
        <h4>Your Order</h4>
        <div class="checkout__order__products">Products <span>Total</span></div>
        <ul>
            <li>Vegetable’s Package <span>$75.99</span></li>
            <li>Fresh Vegetable <span>$151.99</span></li>
            <li>Organic Bananas <span>$53.99</span></li>
        </ul>
        <div class="checkout__order__subtotal">Subtotal <span>$750.99</span></div>
        <div class="checkout__order__total">Total <span>$750.99</span></div>
        <div class="checkout__input__checkbox">
            <label for="acc-or">
                Create an account?
                <input type="checkbox" id="acc-or">
                <span class="checkmark"></span>
            </label>
        </div>
        <p>Lorem ipsum dolor sit amet, consectetur adip elit, sed do eiusmod tempor incididunt
            ut labore et dolore magna aliqua.</p>
        <div class="checkout__input__checkbox">
            <label for="payment">
                Check Payment
                <input type="checkbox" id="payment">
                <span class="checkmark"></span>
            </label>
        </div>
        <div class="checkout__input__checkbox">
            <label for="paypal">
                Paypal
                <input type="checkbox" id="paypal">
                <span class="checkmark"></span>
            </label>
        </div>
        <button type="submit" class="site-btn">PLACE ORDER</button>
    </div>
</div>


<!-- Footer Section Begin -->
<footer class="footer spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="footer__about">
                    <div class="footer__about__logo">
                        <a href="./index.html"><img src="img/logo.png" alt=""></a>
                    </div>
                    <ul>
                        <li>Address: 60-49 Road 11378 New York</li>
                        <li>Phone: +65 11.188.888</li>
                        <li>Email: hello@colorlib.com</li>
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
        <div class="row">
            <div class="col-lg-12">
                <div class="footer__copyright">
                    <div class="footer__copyright__text"><p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p></div>
                    <div class="footer__copyright__payment"><img src="img/payment-item.png" alt=""></div>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- Footer Section End -->

<!-- Js Plugins -->
<script src="assets/js/jquery-3.3.1.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/jquery.nice-select.min.js"></script>
<script src="assets/js/jquery-ui.min.js"></script>
<script src="assets/js/jquery.slicknav.js"></script>
<script src="assets/js/mixitup.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>
<script src="assets/js/main.js"></script>



</body>

</html>