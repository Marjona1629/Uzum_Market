package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.EmailService;
import uz.pdp.uzummarket.service.AuthService;

import java.io.IOException;
import java.util.Base64;

@WebServlet(name = "signup", value = "/signup")
public class SignUpServlet extends HttpServlet {

    private final AuthService authService = new AuthService();
    private final EmailService emailService = EmailService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            User user = authService.createUser(request);

            String text = user.getEmail() + ":" + user.getCode();
            final String message = new String(Base64.getEncoder().encode(text.getBytes()));
            new Thread(() -> emailService.sendConfirmationCode(user.getEmail(), message)).start();
            request.setAttribute("confirmationMessage", "A confirmation code has been sent to your email. Please enter it below.");
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error creating user: " + e.getMessage());
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }
}
