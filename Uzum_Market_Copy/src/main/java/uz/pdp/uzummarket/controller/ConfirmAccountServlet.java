package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet(name = "confirm", value = "/confirm")
public class ConfirmAccountServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ConfirmAccountServlet.class.getName());

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
            try (Connection con = DBConnection.getConnection()) {
                // Check if the code exists in the database
                String checkQuery = "SELECT COUNT(*) FROM users WHERE code = ?";
                try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
                    checkStmt.setString(1, code);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next() && rs.getInt(1) > 0) {
                            // Update the user's confirmation status
                            String updateQuery = "UPDATE users SET hasConfirmed = TRUE WHERE code = ?";
                            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                                updateStmt.setString(1, code);
                                int rowsAffected = updateStmt.executeUpdate();

                                if (rowsAffected > 0) {
                                    message = "Your account has been confirmed. You can now log in.";
                                    messageType = "success";
                                    response.sendRedirect("login.jsp");
                                    return; // Ensure to stop further execution after redirect
                                } else {
                                    message = "Failed to confirm your account.";
                                    messageType = "danger";
                                }
                            }
                        } else {
                            message = "Invalid confirmation code.";
                            messageType = "danger";
                        }
                    }
                }
            } catch (SQLException e) {
                LOGGER.severe("SQL Exception: " + e.getMessage());
                message = "An error occurred while confirming your account.";
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
