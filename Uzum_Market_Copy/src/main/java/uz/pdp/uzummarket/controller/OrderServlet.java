package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.Basket;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.service.BasketService;
import uz.pdp.uzummarket.service.ProductService; // Assuming you have a ProductService

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/app/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BasketService basketService = new BasketService();

        // Assuming you have a way to get the userId from the session or request
        int userId = getUserIdFromSession(request);

        List<Basket> baskets = basketService.getBasketListByUserId(userId);

        // Group by product and calculate total
        Map<String, Double> productTotals = baskets.stream()
                .collect(Collectors.groupingBy(
                        b -> b.getProduct().getName(), // Adjust according to your product naming
                        Collectors.summingDouble(b -> b.getProduct().getPrice() * b.getQuantity())
                ));

        double total = productTotals.values().stream().mapToDouble(Double::doubleValue).sum();

        // Set attributes for the JSP
        request.setAttribute("productTotals", productTotals);
        request.setAttribute("total", total);

        // Forward to JSP
        request.getRequestDispatcher("/order.jsp").forward(request, response);
    }

    private int getUserIdFromSession(HttpServletRequest request) {
        // Implement logic to retrieve userId from session or request
        return 1; // Placeholder
    }
}