package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.FavoriteService;

import java.io.IOException;

@WebServlet("/DeleteFavorite")
public class DeleteFavorite extends HttpServlet {

    private FavoriteService favoriteService = new FavoriteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null) {
            try {
                int productId = Integer.parseInt(productIdStr);

                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");

                if (user != null) {
                    favoriteService.removeFavorite(user, productId);
                    response.sendRedirect(request.getContextPath() + "/app/favorites");
                } else {
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product ID");
        }
    }
}