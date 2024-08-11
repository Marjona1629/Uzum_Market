package uz.pdp.uzummarket.service;

import jakarta.servlet.http.HttpServletRequest;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.enums.Role;
import uz.pdp.uzummarket.enums.Status;
import uz.pdp.uzummarket.repositories.UserRepository;

import java.time.LocalDateTime;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AuthService {
    private static final Logger LOGGER = Logger.getLogger(AuthService.class.getName());
    private final UserRepository userRepository = UserRepository.getInstance();

    public User createUser(HttpServletRequest request) {
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String isDeletedParam = request.getParameter("isDeleted");

        if (email == null || username == null || password == null) {
            throw new IllegalArgumentException("Required parameters are missing.");
        }

        Boolean isDeleted = Boolean.parseBoolean(isDeletedParam);

        User user = User.builder()
                .username(username)
                .email(email)
                .password(password) // Consider hashing the password before saving
                .dateTime(LocalDateTime.now()) // Set the current time for dateTime
                .role(Role.CUSTOMER) // Set default role to CUSTOMER
                .status(Status.ACTIVE) // Set default status to ACTIVE
                .isDeleted(isDeleted)
                .code(generateCode())
                .hasConfirmed(false)
                .build();

        LOGGER.log(Level.INFO, "Creating user: {0}", user);

        try {
            userRepository.save(user);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error saving user to database: {0}", e.getMessage());
            throw new RuntimeException("Failed to save user", e);
        }

        return user;
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
