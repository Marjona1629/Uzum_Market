package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.Notification;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.repositories.NotificationRepository;
import uz.pdp.uzummarket.service.NotificationService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "seller",urlPatterns = {"/app/seller/main"})
public class SellerServlet  extends HttpServlet {

    final NotificationService notificationService = new NotificationService(new NotificationRepository());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        long unreadCount = notificationService.countUnreadNotificationsByUserId(user.getId());
        req.setAttribute("unreadCount", unreadCount);
        req.getRequestDispatcher("/seller.jsp").forward(req, resp);
    }
}