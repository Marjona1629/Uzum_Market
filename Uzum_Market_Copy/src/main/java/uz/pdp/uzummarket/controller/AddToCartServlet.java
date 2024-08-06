package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.service.ProductService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Retrieve the product from the database (this example assumes you have a method for this)
        ProductService productService = new ProductService();
        Product product = productService.getProductById(productId);

        // Retrieve the shopping cart from the session or create a new one
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Add the product to the cart
        cart.add(product);
        session.setAttribute("cart", cart);

        // Redirect to the shopping cart page
        response.sendRedirect("shoping-cart.jsp");
    }
}
