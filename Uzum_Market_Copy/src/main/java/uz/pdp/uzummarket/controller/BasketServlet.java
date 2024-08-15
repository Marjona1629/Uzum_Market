package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.Basket;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.BasketService;

import java.io.IOException;
import java.util.List;

@WebServlet("/app/basket")
public class BasketServlet extends HttpServlet {

    private final BasketService basketService = new BasketService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            List<Basket> baskets = basketService.getBasketListByUserId(user.getId());
            req.setAttribute("baskets", baskets);
            req.getRequestDispatcher("/basket.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/login.jsp");
        }
    }
}