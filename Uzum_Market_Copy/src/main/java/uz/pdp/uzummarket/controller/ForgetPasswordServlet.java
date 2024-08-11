package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.AuthService;
import uz.pdp.uzummarket.service.EmailService;
import uz.pdp.uzummarket.service.UserService;

import java.io.IOException;
import java.util.Base64;
import java.util.Optional;
import java.util.Random;

@WebServlet("/send-confirmation")
public class ForgetPasswordServlet extends HttpServlet {
    private final UserService userService = UserService.getInstance();
    private final EmailService emailService = EmailService.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            if (email == null || email.isEmpty()) {
                request.setAttribute("errorMessage", "Email is required.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            Optional<User> optionalUser = userService.getUserByEmail(email);
            if (optionalUser.isEmpty()) {
                request.setAttribute("errorMessage", "No account found with the provided email.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            User user = optionalUser.get();

            user.setCode(generateCode());
            userService.updateUser(user);

            String text = user.getEmail() + ":" + user.getCode();
            String encodedMessage = Base64.getEncoder().encodeToString(text.getBytes());

            new Thread(() -> emailService.sendConfirmationCode(user.getEmail(), encodedMessage)).start();

            request.setAttribute("confirmationMessage", "A confirmation code has been sent to your email. Please enter it below.");
            request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }

    }

    private String generateCode() {
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }
}