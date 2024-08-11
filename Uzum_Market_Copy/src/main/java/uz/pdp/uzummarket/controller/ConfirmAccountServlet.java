package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.UserService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet(name = "confirm", value = "/confirm")
public class ConfirmAccountServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ConfirmAccountServlet.class.getName());
    private final UserService userService = UserService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        String message;
        String messageType;

        if (code != null && !code.isEmpty()) {
            User user = userService.findUserByCode(code);

            if (user != null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("username", user.getUsername());
                session.setAttribute("user", user);
                session.setAttribute("user_id", user.getId());
                session.setAttribute("role", user.getRole().toString());
                session.setMaxInactiveInterval(24 * 60 * 60);

                // Redirect based on user role
                String redirectPath;
                switch (user.getRole()) {
                    case ADMIN:
                        redirectPath = "/app/admin/main";
                        break;
                    case SELLER:
                        redirectPath = "/app/seller/main";
                        break;
                    default:
                        redirectPath = "/app/home";
                        break;
                }
                response.sendRedirect(redirectPath);
                return;
            } else {
                message = "Invalid confirmation code.";
                messageType = "danger";
            }
        } else {
            message = "Invalid confirmation code.";
            messageType = "danger";
        }

        request.setAttribute("message", message);
        request.setAttribute("messageType", messageType);
        request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
    }
}