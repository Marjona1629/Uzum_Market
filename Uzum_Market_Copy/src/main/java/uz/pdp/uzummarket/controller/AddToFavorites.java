package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.FavoriteList;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.FavoriteService;
import uz.pdp.uzummarket.service.ProductService;

import java.io.IOException;

@WebServlet("/AddToFavorites")
public class AddToFavorites extends HttpServlet {

    private FavoriteService favoriteService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        favoriteService = new FavoriteService();
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productIdParam = req.getParameter("productId");
        if (productIdParam == null || productIdParam.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing or invalid");
            return;
        }

        Integer productId;
        try {
            productId = Integer.valueOf(productIdParam);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID must be a valid number");
            return;
        }

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.setContentType("text/plain");
            resp.getWriter().write("Please log in to add products to your favorites.");
            return;
        }

        Product product = productService.getProductById(productId);
        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            return;
        }

        if (favoriteService.isProductInFavorites(user, product)) {
            resp.setContentType("text/plain");
            resp.getWriter().write("Product is already in your favorites.");
            return;
        }

        // Add to favorites if not already in the list
        FavoriteList favoriteList = new FavoriteList();
        favoriteList.setUser(user);
        favoriteList.setProduct(product);
        favoriteService.addToFavoriteList(favoriteList);

        resp.setContentType("text/plain");
        resp.getWriter().write("Product added to favorites successfully!");
    }
}
