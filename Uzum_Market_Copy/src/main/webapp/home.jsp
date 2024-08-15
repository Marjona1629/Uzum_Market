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
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
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

        .product__details__pic__item--large {
            max-width: 100%;
            height: auto;
        }

        .primary-btn {
            background-color: #ff6f61;
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            display: inline-block;
            margin-top: 15px;
            border-radius: 5px;
        }

        .primary-btn:hover {
            background-color: #e65a50;
        }

        .heart-icon {
            color: #ff6f61;
            margin-left: 10px;
        }

        .heart-icon:hover {
            color: #e65a50;
        }

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

                        <%
                            CategoryService categoryService = new CategoryService();
                            List<Category> categories = categoryService.getAllCategories();
                            request.setAttribute("categories", categories);
                        %>

                    </div>
                    <ul>
                        <% for (Category category : categories) { %>
                        <li><a href="?categoryId=<%= category.getCategoryId() %>"><%= category.getCategoryName() %></a>
                        </li>
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
    <div class="container" >
        <%
            String categoryId = request.getParameter("categoryId");
            if (categoryId != null) {
                ProductService productService = new ProductService();
                categoryService = new CategoryService(); // Assuming you have this service
                List<Product> products = productService.getAllProductsByCategory(Integer.parseInt(categoryId));
                String categoryName = categoryService.getCategoryNameById(Integer.parseInt(categoryId));
        %>
        <h2 style="font-weight: bold; margin-left: 450px"><%= categoryName %></h2><br><br>
        <div class="row featured__filter">
            <% if (products != null && !products.isEmpty()) { %>
            <% for (Product product : products) { %>
            <%
                String imageUrl = product.getImages() != null && !product.getImages().trim().isEmpty()
                        ? request.getContextPath() + "/image/" + product.getImages()
                        : "https://via.placeholder.com/150"; // Placeholder image
            %>
            <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
                <div class="featured__item">
                    <div class="featured__item__pic">
                        <img src="<%= imageUrl %>" alt="<%= product.getName() %>" class="product-image" onError="this.src='https://via.placeholder.com/150';">
                        <ul class="featured__item__pic__hover">
                            <li><a href="#"><i class="fa fa-heart"></i></a></li>
                            <!-- Modal Structure -->
                            <div id="productDetailModal" class="modal">
                                <div class="modal-content">
                                    <span class="close">&times;</span>
                                    <div class="product-details spad">
                                        <div class="container">
                                            <div class="row">
                                                <div class="col-lg-6 col-md-6">
                                                    <div class="product__details__pic">
                                                        <div class="product__details__pic__item">
                                                            <img id="modalProductImage" class="product__details__pic__item--large" src="" alt="">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <div class="product__details__text">
                                                        <h3 id="modalProductName"></h3>
                                                        <div class="product__details__rating">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-half-o"></i>
                                                            <span>(<span id="modalProductReviews"></span> reviews)</span>
                                                        </div>
                                                        <div id="modalProductPrice" class="product__details__price"></div>
                                                        <p id="modalProductDescription"></p>
                                                        <div class="product__details__quantity">
                                                            <div class="quantity">
                                                                <div class="pro-qty">
                                                                    <input type="text" value="1">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <ul class="featured__item__pic__hover">
                                                            <li><a href="javascript:void(0);" onclick="addToFavorites(<%= product.getId() %>)"><i class="fa fa-heart"></i></a></li>
                                                            <a href="/app/addtobasket?productId=<%= product.getId() %>" class="primary-btn">ADD TO BASKET</a>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                imageUrl = product.getImages() != null && !product.getImages().trim().isEmpty()
                                        ? request.getContextPath() + "/image/" + product.getImages()
                                        : "https://via.placeholder.com/150"; // Placeholder image
                            %>

                            <!-- The link -->
                            <li>
                                <a href="#"
                                   data-name="<%= product.getName() %>"
                                   data-price="<%= product.getPrice() %>"
                                   data-description="<%= product.getDescription() %>"
                                   data-image="<%= imageUrl%>"
                                   data-reviews="<%= 6 %>">
                                    <i class="fa fa-shopping-cart"></i>
                                </a>
                            </li>

                        </ul>
                    </div>
                    <div class="featured__item__text">
                        <h6><%= product.getName() %></h6>
                        <h5><%= product.getPrice() %>$</h5>
                    </div>
                </div>
            </div>
            <% } %>
            <% } else { %>
            <p>No products found for this category.</p>
            <% } %>
        </div>
        <br><br><br>
        <% } %>
    </div>
</section>

<!-- Featured Section End -->
<!-- Products Container -->
<section class="products">
    <div class="container">
        <div class="row">
            <div class="categories__slider owl-carousel">
                <%
                    ProductService productService = new ProductService();
                    List<Product> products = productService.getAllProducts();
                    Collections.shuffle(products);

                    for (Product product : products) {
                        String imageUrl = product.getImages() != null && !product.getImages().trim().isEmpty()
                                ? request.getContextPath() + "/image/" + product.getImages()
                                : "https://via.placeholder.com/150"; // Placeholder image
                %>
                <!-- Product Item -->
                <div class="item">
                    <div class="products__item" style="background-image: url('<%= imageUrl %>');"
                         data-name="<%= product.getName() %>"
                         data-price="<%= product.getPrice() %>"
                         data-description="<%= product.getDescription() %>"
                         data-image="<%= imageUrl %>"
                         data-reviews="<%= 6 %>">
                        <div class="products__item__text">
                            <h5><a href="#" class="product-detail-link"><%= product.getName() %></a></h5>
                            <p>$<%= product.getPrice() %></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</section>



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


<script>
    function addToFavorites(productId) {
        fetch('/AddToFavorites?productId=' + productId)
            .then(response => response.text())
            .then(data => {
                alert(data);

                if (data.includes('successfully')) {
                    const iconElement = document.querySelector(`a[href="/AddToFavorites?productId=${productId}"] i`);

                    if (iconElement) {
                        iconElement.style.color = 'red';
                    } else {
                        console.error("Icon element not found.");
                    }
                }
            })
            .catch(error => {
                alert('Error: ' + error.message);
            });
    }
</script>



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

    document.addEventListener("DOMContentLoaded", function () {
        var modal = document.getElementById("productDetailModal");
        var modalProductName = document.getElementById("modalProductName");
        var modalProductPrice = document.getElementById("modalProductPrice");
        var modalProductDescription = document.getElementById("modalProductDescription");
        var modalProductImage = document.getElementById("modalProductImage");
        var modalProductReviews = document.getElementById("modalProductReviews");
        var span = document.getElementsByClassName("close")[0];
        var links = document.querySelectorAll('a[data-name]');

        links.forEach(function(link) {
            link.addEventListener('click', function(event) {
                event.preventDefault();
                var name = this.getAttribute('data-name');
                var price = this.getAttribute('data-price');
                var description = this.getAttribute('data-description');
                var image = this.getAttribute('data-image');
                var reviews = this.getAttribute('data-reviews');

                modalProductName.textContent = name;
                modalProductPrice.textContent = "$" + price;
                modalProductDescription.textContent = description;
                modalProductImage.src = image;
                modalProductReviews.textContent = reviews;

                modal.style.display = "block";
            });
        });

        span.onclick = function() {
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    });

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