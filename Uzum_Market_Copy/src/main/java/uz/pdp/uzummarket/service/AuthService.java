package uz.pdp.uzummarket.service;

import jakarta.servlet.http.HttpServletRequest;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.enums.Role;
import uz.pdp.uzummarket.enums.Status;

import java.time.LocalDateTime;
import java.util.Random;

public class AuthService {

    public User createUser(HttpServletRequest request) {
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String isDeletedParam = request.getParameter("isDeleted");

        Boolean isDeleted = null;

        isDeleted = Boolean.parseBoolean(isDeletedParam);

        return User.builder()
                .username(username)
                .email(email)
                .password(password) // Consider hashing the password before saving
                .dateTime(LocalDateTime.now()) // Set the current time for dateTime
                .role(Role.valueOf(Role.CUSTOMER.toString())) // Set default role to CUSTOMER
                .status(Status.ACTIVE) // Set default status to ACTIVE
                .isDeleted(isDeleted)
                .code(generateCode())
                .build();
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
