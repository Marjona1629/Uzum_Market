package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.EmailService;
import uz.pdp.uzummarket.service.UserService;
import uz.pdp.uzummarket.service.AuthService;

import java.io.IOException;
import java.util.Base64;

@WebServlet(name = "signup", value = "/signup")
public class SignUpServlet extends HttpServlet {

    private final UserService userService = UserService.getInstance();
    private final AuthService authService = new AuthService();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User newUser = authService.createUser(request);

        if (newUser.getUsername() == null || newUser.getUsername().isEmpty() ||
                newUser.getEmail() == null || newUser.getEmail().isEmpty() ||
                newUser.getPassword() == null || newUser.getPassword().isEmpty()) {
            request.setAttribute("errorMessage", "Required fields are missing.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        try {
            userService.saveUser(newUser);
            String text = newUser.getEmail() + ":" + newUser.getCode();
            final String message = new String(Base64.getEncoder().encode(text.getBytes()));
            new Thread(() -> emailService.sendConfirmationCode(newUser.getEmail(), message)).start();
            response.sendRedirect("/login");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error creating user: " + e.getMessage());
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }
}
