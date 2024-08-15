<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="uz.pdp.uzummarket.service.FavoriteService" %>
<%@ page import="uz.pdp.uzummarket.entities.FavoriteList" %>
<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Uzum Market">
    <meta name="keywords" content="html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>My Favorites</title>

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
        .header__nav {
            display: flex;
            align-items: center;
            justify-content: space-around; /* or space-between if you prefer */
        }

        .header__nav__item {
            margin: 0 10px; /* Adjust spacing between items */
        }

        .header__nav__item a {
            text-decoration: none;
            color: black;
            transition: background-color 0.3s ease;
        }

        .header__nav__item a:hover {
            background-color: #b6b4b7; /* Adjust hover color as needed */
        }

        .header__top__right__language ul {
            display: none; /* Hide dropdown by default */
            position: absolute;
            background-color: white;
            list-style: none;
            padding: 0;
            margin: 0;
            border: 1px solid #ccc;
            z-index: 1000;
        }

        .header__top__right__language:hover ul {
            display: block; /* Show dropdown on hover */
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

        .filter-space .filter {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }


        .product-image {
            max-width: 100%;
            height: auto;
        }

        .modal-content h2 {
            margin-top: 0;
        }

        .modal-content p {
            margin: 5px 0;
        }

        .owl-carousel .owl-nav, .owl-carousel .owl-dots {
            display: none;
        }
        .products {
            padding: 60px 0;
        }

        .products__item {
            position: relative;
            overflow: hidden;
            background-size: cover;
            background-position: center;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgb(111, 60, 206);
            cursor: pointer;
            height: 300px; /* Set a fixed height */
            display: flex;
            align-items: flex-end;
        }

        .products__item__text {
            margin-top: 15px;
            background-color: whitesmoke;
            position: absolute;
            bottom: 20px;
            left: 20px;
            color: black;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
        }

        .products__item__text h5 {
            margin: 0;
            color: black;
            font-size: 15px;
        }

        .products__item__text p {
            margin: 5px 0 0;
            font-size: 14px;
            font-weight: bold;
        }

        .owl-carousel .owl-item {
            margin: 15px;
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
                    <img src="/assets/img/uzum_market_logo.png" alt="">
                </div>
            </div>

            <div class="col-lg-9 d-flex align-items-center justify-content-end header__nav">
                <div class="header__nav__item">
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
                <div class="header__nav__item">
                    <a href="/app/favorites"><i class="fa fa-heart-o"></i> Favorite</a>
                </div>
                <div class="header__nav__item">
                    <a href="/app/basket"><i class="fa fa-shopping-basket"></i> Basket</a>
                </div>
                <div class="header__nav__item">
                    <a href="/contact"><i class="fa fa-connectdevelop"></i> Contact</a>
                </div>
                <div class="header__nav__item header__top__right__language">
                    <img src="/assets/img/language.png" alt=""><a>English</a>
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
                    <div class="hero__categories__all">
                        <i class="fa fa-bars"></i>
                        <span>All Categories</span>
                    </div>
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
                            <h5>+99894 022 36 33</h5>
                            <span>support 24/7</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Hero Section End -->


<!-- Featured Section Begin -->
<section class="featured spad">
    <div class="container">
        <%
            User user = (User) session.getAttribute("user");
            FavoriteService favoriteService = new FavoriteService();
            List<FavoriteList> favoriteLists = favoriteService.getUserFavorites(user);
        %>

        <div class="row featured__filter">
            <% if (favoriteLists != null && !favoriteLists.isEmpty()) { %>
            <% for (FavoriteList favoriteList : favoriteLists) {
                Product product = favoriteList.getProduct(); // Retrieve product from FavoriteList
                String imageUrl = product.getImages() != null && !product.getImages().trim().isEmpty()
                        ? request.getContextPath() + "/image/" + product.getImages()
                        : "https://via.placeholder.com/150"; // Placeholder image
            %>
            <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
                <div class="featured__item">
                    <div class="featured__item__pic">
                        <img src="<%= imageUrl %>" alt="<%= product.getName() %>" class="product-image" onError="this.src='https://via.placeholder.com/150';">
                        <ul class="featured__item__pic__hover">
                            <li><a href="/DeleteFavorite?productId=<%= product.getId() %>"><i class="fa fa-heart"></i></a></li>
                            <li><a href="/AddToCartServlet?productId=<%= product.getId() %>"><i class="fa fa-shopping-cart"></i></a></li>
                            <li><a href="/productDetails?productId=<%= product.getId() %>"><i class="fa fa-info-circle"></i></a></li>
                        </ul>
                    </div>
                    <div class="featured__item__text">
                        <h6><a href="/productDetails?productId=<%= product.getId() %>"><%= product.getName() %></a></h6>
                        <h5>$<%= product.getPrice() %></h5>
                    </div>
                </div>
            </div>
            <% } %>
            <% } else { %>
            <p class="empty-message">You have no favorite products yet.</p>
            <% } %>
        </div>
    </div>
</section>
<!-- Featured Section End -->

<!-- JS Scripts -->
<script src="/assets/js_files/js/jquery-3.3.1.min.js"></script>
<script src="/assets/js_files/js/bootstrap.min.js"></script>
<script src="/assets/js_files/js/owl.carousel.min.js"></script>
<script src="/assets/js_files/js/jquery-ui.min.js"></script>
<script src="/assets/js_files/js/jquery.nice-select.min.js"></script>
<script src="/assets/js_files/js/main.js"></script>

<script>
    function searchProducts() {
        const query = document.getElementById('search-input').value;
        if (query.length === 0) {
            document.getElementById('search-suggestions').innerHTML = '';
            return;
        }
        fetch(`/searchProducts?query=${query}`)
            .then(response => response.json())
            .then(data => {
                let suggestions = '';
                data.forEach(product => {
                    suggestions += `<div class="suggestion-item" onclick="selectProduct('${product.name}')">${product.name}</div>`;
                });
                document.getElementById('search-suggestions').innerHTML = suggestions;
            })
            .catch(error => console.error('Error fetching products:', error));
    }

    function selectProduct(productName) {
        document.getElementById('search-input').value = productName;
        document.getElementById('search-suggestions').innerHTML = '';
    }
</script>


<!-- JS Scripts -->
<script src="/assets/js_files/js/jquery-3.3.1.min.js"></script>
<script src="/assets/js_files/js/bootstrap.min.js"></script>
<script src="/assets/js_files/js/owl.carousel.min.js"></script>
<script src="/assets/js_files/js/jquery-ui.min.js"></script>
<script src="/assets/js_files/js/jquery.nice-select.min.js"></script>
<script src="/assets/js_files/js/main.js"></script>

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