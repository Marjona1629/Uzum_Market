package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.service.ProductService;

import java.io.IOException;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer productId = Integer.parseInt(req.getParameter("id"));
        Product product = productService.getProductById(productId);
        productService.deleteProduct(product);
        resp.sendRedirect(req.getContextPath() + "/app/seller/addProductServlet");
    }
}
