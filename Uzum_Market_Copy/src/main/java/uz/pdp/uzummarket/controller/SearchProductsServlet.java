package uz.pdp.uzummarket.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchProducts")
public class SearchProductsServlet extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("query");
        List<Product> products = productService.searchProductsByName(query);
        String jsonResponse = new Gson().toJson(products);
        resp.setContentType("application/json");
        resp.getWriter().write(jsonResponse);
    }
}
