package uz.pdp.uzummarket.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "home", value = "/app/home")
public class HomeServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService productService = new ProductService();
        List<Product> discountedProducts;

        try {
            discountedProducts = productService.getDiscountedProducts();
            if (!discountedProducts.isEmpty()) {
                request.setAttribute("discountedProducts", discountedProducts);
            } else {
                request.setAttribute("message", "No discounted products available.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to fetch discounted products.");
        }

        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}