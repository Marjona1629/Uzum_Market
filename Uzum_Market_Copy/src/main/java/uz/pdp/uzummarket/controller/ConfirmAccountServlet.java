package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.repositories.UserRepository;
import uz.pdp.uzummarket.entities.User;

import java.io.IOException;
import java.util.Base64;

@WebServlet("/confirm")
public class ConfirmAccountServlet extends HttpServlet {

    private final UserRepository userRepository = UserRepository.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String confirmation = request.getParameter("confirmation");

        if (confirmation != null) {
            String decodedText = new String(Base64.getDecoder().decode(confirmation));
            String[] parts = decodedText.split(":");
            String email = parts[0];
            String code = parts[1];

            User user = userRepository.getUserByEmail(email).orElse(null);

            if (user != null && user.getCode().equals(code)) {
                user.setHasConfirmed(true);
                userRepository.update(user);

                // Redirect to home page after successful confirmation
                response.sendRedirect("home.jsp");
                return;
            }
        }

        // Redirect to an error page or display an error message
        response.sendRedirect("error.jsp");
    }
}
