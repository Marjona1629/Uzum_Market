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

@WebServlet("/app/product-details.jsp")
public class ProductDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdStr = request.getParameter("id");

        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            ProductService productService = new ProductService();
            Product product = productService.getProductById(productId);

            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }

            request.setAttribute("product", product);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/product-details.jsp");
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID format");
        }
    }
}