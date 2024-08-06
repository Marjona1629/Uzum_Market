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
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet("/confirm")
public class ConfirmAccountServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ConfirmAccountServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        String message;
        String messageType;

        if (code != null && !code.isEmpty()) {
            try (Connection con = DBConnection.getConnection()) {
                String updateQuery = "UPDATE users SET hasConfirmed = TRUE WHERE code = ?";
                try (PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
                    pstmt.setString(1, code);
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        message = "Your account has been confirmed. You can now log in.";
                        messageType = "success";
                        response.sendRedirect("login.jsp");
                        return; // Ensure to stop further execution
                    } else {
                        message = "Invalid confirmation code.";
                        messageType = "danger";
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
        request.getRequestDispatcher("/confirmation-status.jsp").forward(request, response);
    }
}
