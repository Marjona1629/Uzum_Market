package uz.pdp.uzummarket.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet("/loadProducts")
public class LoadProductsServlet extends HttpServlet {

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryId = req.getParameter("categoryId");
        if (categoryId != null) {
            List<Product> products = productService.getAllProductsByCategory(Integer.parseInt(categoryId));
            ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(products);
            resp.setContentType("application/json");
            resp.getWriter().write(json);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is missing.");
        }
    }
}
