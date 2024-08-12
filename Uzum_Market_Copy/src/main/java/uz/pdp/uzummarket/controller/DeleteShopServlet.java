package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.ShopService;

import java.io.IOException;

@WebServlet("/deleteShop")
public class DeleteShopServlet extends HttpServlet {

    private ShopService shopService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.shopService = new ShopService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
            return;
        }

        String id = req.getParameter("id");
        Shop shop = shopService.getShopById(Integer.valueOf(id));

        if (shop == null || !shop.getOwner().equals(user)) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Shop not found or not authorized.");
            return;
        }

        shopService.deleteShop(shop);

        resp.sendRedirect("/add-shop.jsp");
    }
}