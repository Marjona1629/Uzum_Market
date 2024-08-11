package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.enums.Status;
import uz.pdp.uzummarket.service.UserService;

import java.io.IOException;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = UserService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = userService.login(username, password);

        if (user != null && !user.isDeleted()) {
            if (user.getStatus() == Status.BLOCKED) {
                response.sendRedirect("/blockedUser.jsp");
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("user", user);
            session.setAttribute("user_id", user.getId());
            session.setAttribute("role", user.getRole().toString());

            session.setMaxInactiveInterval(24 * 60 * 60);

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
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}