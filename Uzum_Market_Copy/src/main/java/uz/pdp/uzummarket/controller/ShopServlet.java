package uz.pdp.uzummarket.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.enums.Status;
import uz.pdp.uzummarket.repositories.NotificationRepository;
import uz.pdp.uzummarket.service.NotificationService;
import uz.pdp.uzummarket.service.ShopService;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/app/seller/add-shop"})
public class ShopServlet extends HttpServlet {

    private ShopService shopService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.shopService = new ShopService();
    }

    final NotificationService notificationService = new NotificationService(new NotificationRepository());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        long unreadCount = notificationService.countUnreadNotificationsByUserId(user.getId());
        req.setAttribute("unreadCount", unreadCount);

        if (user == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
            return;
        }

        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String address = req.getParameter("address");

        Shop shop = Shop.builder()
                .name(name)
                .description(description)
                .address(address)
                .status(Status.ACTIVE)
                .owner(user)
                .build();

        shopService.createShop(shop);

        resp.sendRedirect("/seller.jsp");
    }
}