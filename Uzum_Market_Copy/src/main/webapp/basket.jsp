<%@ page import="uz.pdp.uzummarket.service.ProductService" %>
<%@ page import="uz.pdp.uzummarket.entities.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.uzummarket.service.CategoryService" %>
<%@ page import="uz.pdp.uzummarket.entities.Category" %>
<%@ page import="java.util.Collections" %>
<%@ page import="uz.pdp.uzummarket.service.BasketService" %>
<%@ page import="uz.pdp.uzummarket.entities.User" %>
<%@ page import="uz.pdp.uzummarket.entities.Basket" %>
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
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">


    <!-- Css Styles -->
    <link rel="stylesheet" href="/assets/css_files/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/css_files/css/style.css" type="text/css">
    <!-- Google Font -->

    <style>
        .header__nav {
            display: flex;
            align-items: center;
            justify-content: space-around; /* or space-between if you prefer */
        }
        .icon_close {
            cursor: pointer; /* Make it clickable */
            font-size: 20px; /* Adjust size if needed */
            color: #333; /* Adjust color if needed */
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

        .image-small {
            width: 76px;  /* Approximate 20 mm */
            height: 76px; /* Approximate 20 mm */
        }

        .owl-carousel .owl-nav, .owl-carousel .owl-dots {
            display: none;
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

<!-- Shoping Cart Section Begin -->
<section class="shoping-cart spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="shoping__cart__table" >
                    <h2 >Shopping Basket</h2>
                    <%
                        User user = (User) session.getAttribute("user");
                        if (user != null) {
                            BasketService basketService = new BasketService();
                            List<Basket> baskets = basketService.getBasketListByUserId(user.getId());
                            request.setAttribute("baskets", baskets);
                        } else {
                            request.setAttribute("baskets", Collections.emptyList());
                        }
                    %>
                    <table>
                        <thead>
                        <tr >
                            <th class="shoping__product">Products</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Basket> baskets = (List<Basket>) request.getAttribute("baskets");
                            if (baskets != null && !baskets.isEmpty()) {
                                for (Basket basket : baskets) {
                                    Product product = basket.getProduct();
                                    String imageUrl = product.getImages() != null && !product.getImages().trim().isEmpty()
                                            ? request.getContextPath() + "/image/" + product.getImages()
                                            : "https://via.placeholder.com/150"; // Placeholder image
                        %>
                        <tr>
                            <td class="shoping__cart__item">
                                <img src="<%= imageUrl%>" alt="" class="image-small">
                                <h5><%= basket.getProduct().getName() %></h5>
                            </td>
                            <td class="shoping__cart__price">
                                $<%= basket.getProduct().getPrice() %>
                            </td>
                            <td class="shoping__cart__quantity" data-product-id="<%= basket.getProduct().getId() %>">
                                <form class="quantity-form">
                                    <input type="hidden" name="basketId" value="<%= basket.getProduct().getId() %>">
                                    <input type="hidden" name="quantity" class="quantity-input" value="<%= basket.getQuantity() %>">
                                    <div class="quantity">
                                        <button type="button" class="qty-btn" data-change="-1">-</button>
                                        <span class="qty-value"><%= basket.getQuantity() %></span>
                                        <button type="button" class="qty-btn" data-change="1">+</button>
                                    </div>
                                </form>
                            </td>

                            <td class="shoping__cart__total">
                                $<%= basket.getProduct().getPrice() * basket.getQuantity() %>
                            </td>
                            <td class="shoping__cart__item__close">
                                 <span class="icon_close" onclick="deleteBasketItem(<%= basket.getBasketId() %>)">
                                  <i class="fa fa-times"></i>
                                   </span>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center;">Your basket is empty.</td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="shoping__cart__btns">
                                <!-- Button for "Continue Shopping" -->
                                <a href="#" class="primary-btn cart-btn" style="background-color: #975fb7; color: whitesmoke"
                                   onclick="window.location.href='/app/order'; return false;">CONTINUE SHOPPING</a>

                                <!-- Button for "Update Basket" -->
                                <a href="#" class="primary-btn cart-btn cart-btn-right" style="background-color: #ae6bd5; color: whitesmoke"
                                   onclick="window.location.reload(); return false;">Update Basket</a>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</section>
<!-- Shoping Cart Section End -->

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
    document.addEventListener('DOMContentLoaded', () => {
        // Handle quantity change
        document.querySelectorAll('.qty-btn').forEach(button => {
            button.addEventListener('click', (event) => {
                event.preventDefault(); // Prevent default button behavior
                const buttonElement = event.target;
                const form = buttonElement.closest('.quantity-form');
                const quantityElement = form.querySelector('.qty-value');
                const quantityInput = form.querySelector('.quantity-input');

                if (quantityElement && quantityInput) {
                    let currentQuantity = parseInt(quantityElement.textContent, 10);
                    const change = parseInt(buttonElement.getAttribute('data-change'), 10);
                    let newQuantity = currentQuantity + change;

                    // Ensure quantity is not less than 1
                    if (newQuantity < 1) {
                        newQuantity = 1;
                    }

                    // Update the quantity display and input
                    quantityElement.textContent = newQuantity;
                    quantityInput.value = newQuantity;

                    // Send the updated quantity to the server via AJAX
                    const formData = new URLSearchParams();
                    formData.append('basketId', quantityInput.dataset.basketId); // Using data attribute for basketId
                    formData.append('quantity', newQuantity);

                    fetch('/app/updatebasket', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                            'X-Requested-With': 'XMLHttpRequest'
                        },
                        body: formData.toString()
                    })
                        .then(response => {
                            if (response.ok) {
                                console.log('Quantity updated successfully');
                            } else {
                                console.error('Failed to update quantity');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
                }
            });
        });

        // Handle delete basket item
        document.querySelectorAll('.icon_close').forEach(icon => {
            icon.addEventListener('click', (event) => {
                const basketId = event.target.closest('td').dataset.basketId; // Get basketId from closest td element
                deleteBasketItem(basketId);
            });
        });
    });

    function deleteBasketItem(basketId) {
        if (confirm("Are you sure you want to delete this item from your basket?")) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/app/deletebasket", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    try {
                        if (xhr.status === 200) {
                            const response = JSON.parse(xhr.responseText);
                            if (response.success) {
                                // Remove the row from the table
                                const row = document.querySelector(`tr[data-basket-id="${basketId}"]`);
                                if (row) {
                                    row.remove();
                                    console.log(`Item with basketId ${basketId} removed from display.`);
                                } else {
                                    console.error(`Row with basketId ${basketId} not found.`);
                                }
                            } else {
                                console.error(`Failed to delete basket item: ${response.message}`);
                                alert(response.message || "Failed to delete basket item.");
                            }
                        } else {
                            console.error(`Request failed with status: ${xhr.status}`);
                            alert("Failed to delete basket item. Status: " + xhr.status);
                        }
                    } catch (e) {
                        console.error('Error parsing response:', e);
                        alert("An error occurred while processing the request.");
                    }
                }
            };

            xhr.send("basketId=" + encodeURIComponent(basketId));
        }
    }
</script>

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