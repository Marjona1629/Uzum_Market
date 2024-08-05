
<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
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
    <link rel="stylesheet" href="assets/css_files/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="assets/css_files/css/style.css" type="text/css">

    <style>
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
            background-color: #f0f0f0;
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
                    <a href="${pageContext.request.contextPath}/home.jsp">
                        <img src="assets/img/uzum_market_logo.png" alt="">
                    </a>
                </div>
            </div>
            <div class="col-lg-6 d-flex align-items-center justify-content-end">
                <div class="header__cart">
                    <ul>
                        <li><a href="#"><i class="fa fa-heart"></i></a></li>
                        <li><a href="basket.jsp"><i class="fa fa-shopping-bag"></i></a></li>
                    </ul>
                </div>
                <div class="header__top__right__language">
                    <img src="img/language.png" alt="">
                    <div>English</div>
                    <span class="arrow_carrot-down"></span>
                    <ul>
                        <li><a href="#">Russian</a></li>
                        <li><a href="#">English</a></li>
                    </ul>
                </div>
                <div class="header__top__right__auth">
                    <a href="auth.jsp"><i class="fa fa-user"></i>Cabinet</a>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="humberger__open">
                    <i class="fa fa-bars"></i>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Header Section End -->

<!-- Hero Section Begin --><%--
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
                <div class="hero__item set-bg" data-setbg="assets/img/Black-Friday.jpg">
                    <div class="hero__text">
                        <a href="#" class="primary-btn">BUY NOW</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>--%>
<!-- Hero Section End -->

<!-- Featured Section Begin -->

<%--<section class="featured spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2>Products</h2>
                </div>
            </div>
        </div>

        <div class="row featured__filter">
            <%
                String categoryId = request.getParameter("categoryId");
                if (categoryId != null) {
                    ProductService productService = new ProductService();
                    List<Product> products = productService.getAllProductByCategory(Integer.parseInt(categoryId));
                    for (Product product : products) {
                        String base64Image = product.getProductImages();
                        String imageType = "image/png";
            %>
            <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
                <div class="featured__item">
                    <div class="featured__item__pic">
                        <img src="<%= (base64Image != null && !base64Image.isEmpty()) ? "data:" + imageType + ";base64," + base64Image : "path/to/fallback-image.jpg" %>" alt="<%=product.getProductName()%>">
                        <ul class="featured__item__pic__hover">
                            <li><a href="#"><i class="fa fa-heart"></i></a></li>
                            <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                            <li><a href="AddToCartServlet?productId=<%=product.getProductId()%>"><i class="fa fa-shopping-cart"></i></a></li>
                        </ul>
                    </div>
                    <div class="featured__item__text">
                        <h6><%=product.getProductName()%></h6>
                        <h5><%=product.getProductPrice()%>$</h5>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div><br><br><br>
</section>--%>


<!-- Featured Section End -->

<!-- Categories Section Begin -->
<section class="categories">
    <div class="container">
        <div class="row">
            <div class="categories__slider owl-carousel">
                <div class="col-lg-3">
                    <div class="categories__item set-bg" data-setbg="img/categories/cat-1.jpg">
                        <h5><a href="#">Diamond Ring</a></h5>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="categories__item set-bg" data-setbg="assets/img/categories/cat-2.jpg">
                        <h5><a href="#">Blouse</a></h5>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="categories__item set-bg" data-setbg="assets/img/categories/cat-3.jpg">
                        <h5><a href="#">Watch</a></h5>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="categories__item set-bg" data-setbg="assets/img/categories/cat-4.jpg">
                        <h5><a href="#">Coca Cola</a></h5>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="categories__item set-bg" data-setbg="assets/img/categories/cat-5.jpg">
                        <h5><a href="#">Parfum</a></h5>
                    </div>
                </div>
            </div>
        </div>
    </div><br><br><br>
</section>
<!-- Categories Section End -->

<!-- Include footer -->
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
<script src="assets/css_files/js/jquery-3.3.1.min.js"></script>
<script src="assets/css_files/js/bootstrap.min.js"></script>
<script src="assets/css_files/js/jquery.nice-select.min.js"></script>
<script src="assets/css_files/js/jquery-ui.min.js"></script>
<script src="assets/css_files/js/jquery.slicknav.js"></script>
<script src="assets/css_files/js/mixitup.min.js"></script>
<script src="assets/css_files/js/owl.carousel.min.js"></script>
<script src="assets/css_files/js/main.js"></script>
</body>

</html>