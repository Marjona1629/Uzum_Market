package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.FavoriteList;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.FavoriteService;

import java.io.IOException;
import java.util.List;

@WebServlet("/app/favorites")
public class FavoriteServlet extends HttpServlet {

    private FavoriteService favoriteService;

    @Override
    public void init() throws ServletException {
        favoriteService = new FavoriteService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            List<FavoriteList> favoriteLists = favoriteService.getUserFavorites(user);
            req.setAttribute("favorites", favoriteLists);
            req.getRequestDispatcher("/favorite.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/login.jsp");
        }
    }
}