package uz.pdp.uzummarket.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.SneakyThrows;
import uz.pdp.uzummarket.entities.Notification;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.repositories.NotificationRepository;
import uz.pdp.uzummarket.service.NotificationService;

import java.util.List;

@WebServlet("/show-notifications")
public class NotificationServlet extends HttpServlet {

    private NotificationService notificationService;

    public NotificationServlet() {
        this.notificationService = new NotificationService(new NotificationRepository()); // or use a service locator pattern
    }

    @Override
    @SneakyThrows
    protected void doGet(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            long unreadCount = notificationService.countUnreadNotificationsByUserId(user.getId());
            List<Notification> notifications = notificationService.getNotificationsByUserId(user.getId());

            request.setAttribute("unreadCount", unreadCount);
            request.setAttribute("notifications", notifications);
            request.getRequestDispatcher("/notifications.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}