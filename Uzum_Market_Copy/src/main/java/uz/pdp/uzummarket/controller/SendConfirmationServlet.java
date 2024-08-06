/*
package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.util.DBConnection;
import uz.pdp.uzummarket.util.EmailUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet("/send-confirmation")
public class SendConfirmationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String message;
        String messageType;

        if (email != null && !email.isEmpty()) {
            try (Connection con = DBConnection.getConnection()) {
                String confirmationCode = UUID.randomUUID().toString();
                String updateQuery = "UPDATE users SET code = ?, hasConfirmed = FALSE WHERE user_email = ?";
                try (PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
                    pstmt.setString(1, confirmationCode);
                    pstmt.setString(2, email);
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        try {
                            EmailUtils.sendConfirmationEmail(email, confirmationCode);
                            message = "Confirmation email has been sent to your email.";
                            messageType = "success";
                        } catch (Exception e) {
                            message = "Failed to send confirmation email.";
                            messageType = "danger";
                        }
                    } else {
                        message = "Email address not found.";
                        messageType = "danger";
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                message = "An error occurred while sending confirmation email.";
                messageType = "danger";
            }
        } else {
            message = "Invalid email address.";
            messageType = "danger";
        }

        request.setAttribute("message", message);
        request.setAttribute("messageType", messageType);
        request.getRequestDispatcher("/confirmation-sent.jsp").forward(request, response);
    }
}
*/
