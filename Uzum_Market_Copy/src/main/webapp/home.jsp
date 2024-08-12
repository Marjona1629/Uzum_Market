<%@ page import="uz.pdp.uzummarket.service.ProductService" %>
<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="java.util.Collections" %>
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
        }/* Container and Section Styles */
        .container.my-products-margin {
            margin-top: 0; /* Reset if you had a default margin */
            margin-top: -20px;
        }

        .section-title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2em;
            font-weight: bold;
        }

        /* Product Row Styles */
        .product-row {
            display: flex;
            align-items: flex-start;
        }

        /* Space for filters on the left */
        .filter-space {
            width: 20%; /* Adjust as needed for your filters */
            padding: 10px;
            box-sizing: border-box;
        }

        .filter-space .filter {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        /* Product List Styles */
        .product-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px; /* Space between product cards */
            width: 80%; /* Adjust width to fill the remaining space */
            padding: 10px;
        }

        .product-card {
            cursor: pointer;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            flex: 1 1 calc(25% - 20px); /* Adjust to fit 4 products per line */
            box-sizing: border-box;
        }

        .product-card:hover {
            transform: scale(1.05);
        }

        .product-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .card-body {
            padding: 15px;
        }

        .card-title {
            font-size: 1.2em;
            margin-bottom: 10px;
        }

        .card-text {
            font-size: 0.9em;
            color: #555;
        }

        .card-price {
            font-size: 1.1em;
            color: #333;
            font-weight: bold;
        }

        /* Basic modal styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 80%; /* Could be more or less, depending on screen size */
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
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

        /* Sliding Panel Styles */
        .sliding-panel {
            display: none; /* Hidden by default */
            position: fixed;
            top: 0;
            right: 0;
            width: 300px; /* Width of the sliding panel */
            height: 100%;
            background-color: #fefefe;
            border-left: 1px solid #888;
            box-shadow: -2px 0 5px rgba(0,0,0,0.5);
            overflow-y: auto;
            transition: transform 0.3s ease;
            transform: translateX(100%); /* Hide panel initially */
            z-index: 1000; /* Ensure it's above other content */
        }

        .sliding-panel.show {
            transform: translateX(0); /* Slide in */
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            float: right;
            margin: 10px;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
        }

    </style>

</head>

<body>
<!-- Page Preloder -->
<div id="preloder">
    <div class="loader"></div>
</div>

<<!-- Header Section Begin -->
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
                    <a href="favorite.jsp"><i class="fa fa-heart-o"></i> Favorite</a>
                </div>
                <div class="header__nav__item">
                    <a href="basket.jsp"><i class="fa fa-shopping-basket"></i> Basket</a>
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

                        <%
                            CategoryService categoryService = new CategoryService();
                            List<Category> categories = categoryService.getAllCategories();
                            request.setAttribute("categories", categories);
                        %>

                    </div>
                    <ul>
                        <% for (Category category : categories) { %>
                        <li><a href="?categoryId=<%= category.getCategoryId() %>"><%= category.getCategoryName() %></a></li>
                        <% } %>
                    </ul>
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
                <div class="hero__item set-bg" data-setbg="/assets/img/Black-Friday.jpg">
                    <div class="hero__text">
                        <a href="#" class="primary-btn">BUY NOW</a>
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

        <div class="row featured__filter">
            <%
                String categoryId = request.getParameter("categoryId");
                if (categoryId != null) {
                    ProductService productService = new ProductService();
                    List<Product> products = productService.getAllProductsByCategory(Integer.parseInt(categoryId));
                    for (Product product : products) {
                        String base64Image = product.getImages();
                        String imageType = "image/png";
            %>
            <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
                <div class="featured__item">
                    <div class="featured__item__pic">
                        <img src="<%= (base64Image != null && !base64Image.isEmpty()) ? "data:" + imageType + ";base64," + base64Image : "path/to/fallback-image.jpg" %>" alt="<%=product.getName()%>">
                        <ul class="featured__item__pic__hover">
                            <li><a href="#"><i class="fa fa-heart"></i></a></li>
                            <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                            <li><a href="AddToCartServlet?productId=<%=product.getId()%>"><i class="fa fa-shopping-cart"></i></a></li>
                        </ul>
                    </div>
                    <div class="featured__item__text">
                        <h6><%=product.getName()%></h6>
                        <h5><%=product.getPrice()%>$</h5>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div><br><br><br>
</section>
<!-- Featured Section End -->

<!-- Products Container -->
<div class="container my-products-margin">
    <h3 class="section-title">Products</h3>
    <div class="product-row">
        <!-- Filters Section -->
        <div class="filter-space">
            <!-- Filters will be placed here -->
            <div class="filter">Color</div>
            <div class="filter">Price</div>
            <div class="filter">Count</div>
            <div class="filter">Place</div>
        </div>
        <!-- Product List -->
        <div class="product-list">
            <%
                ProductService productService = new ProductService();
                List<Product> products = productService.getAllProducts();
                Collections.shuffle(products);

                for (Product product : products) {
                    String imageUrl = product.getImages() != null && !product.getImages().trim().isEmpty()
                            ? request.getContextPath() + "/image/" + product.getImages()
                            : "https://via.placeholder.com/150"; // Placeholder image
            %>
            <!-- Product Card -->
            <div class="product-card" onclick="window.location.href='product-details.jsp?id=<%= product.getId() %>'">
                <img src="<%= imageUrl %>" alt="<%= product.getName() %>" class="product-image" onError="this.src='https://via.placeholder.com/150';">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-price">$<%= product.getPrice() %></p>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>


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
<!-- Js Plugins -->
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