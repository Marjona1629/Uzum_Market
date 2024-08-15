package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.Basket;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.BasketService;
import uz.pdp.uzummarket.service.ProductService;

import java.io.IOException;

@WebServlet("/app/addtobasket")
public class AddToCartServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int productId = Integer.parseInt(request.getParameter("productId"));

        ProductService productService = new ProductService();
        Product product = productService.getProductById(productId);

        User user = (User) session.getAttribute("user");
        if (user != null) {
            BasketService basketService = new BasketService();

            if (basketService.isProductInBasket(user.getId(), productId)) {
                response.sendRedirect("/basket.jsp?message=Product%20already%20in%20basket");
            } else {
                Basket basket = Basket.builder()
                        .user(user)
                        .product(product)
                        .quantity(1)
                        .isFormalized(false)
                        .build();

                basketService.createBasket(basket);
                response.sendRedirect("/home.jsp?message=Product%20added%20to%20basket");
            }
        } else {
            response.sendRedirect("/login");
        }
    }
}