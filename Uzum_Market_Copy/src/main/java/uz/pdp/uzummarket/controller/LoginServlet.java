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

    private UserService userService =  UserService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = userService.login(username, password);

        if (user != null && user.isDeleted() != true) {
            if (user.getStatus() == Status.BLOCKED) {
                response.sendRedirect("/blockedUser.jsp");
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("username", user.getUsername());
            session.setAttribute("user", user);
            session.setAttribute("user_id",user.getId());
            session.setAttribute("role", user.getRole().toString());

            int expiry = 24 * 60 * 60;
            session.setMaxInactiveInterval(expiry);

            Cookie jsessionid = new Cookie("JSESSIONID", session.getId());
            jsessionid.setMaxAge(expiry);
            response.addCookie(jsessionid);

            if ("ADMIN".equalsIgnoreCase(user.getRole().toString())) {
                response.sendRedirect("/app/admin/main");
            } else if ("SELLER".equalsIgnoreCase(user.getRole().toString())) {
                response.sendRedirect("/app/seller/main");
            } else {
                response.sendRedirect("/app/home");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}