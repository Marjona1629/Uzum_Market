<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>

<%
    String userId = request.getParameter("id");
    boolean updateSuccess = false;
    String message = "";

    if (userId != null && !userId.isEmpty()) {
        try (Connection con = DBConnection.getConnection()) {
            String updateQuery = "UPDATE users SET isDeleted = TRUE WHERE id = ?";
            try (PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
                pstmt.setInt(1, Integer.parseInt(userId));
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    updateSuccess = true;
                    message = "Seller marked as deleted successfully!";
                } else {
                    message = "No rows affected. User ID may not exist.";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "SQL Exception: " + e.getMessage();
        }
    } else {
        message = "Invalid user ID.";
    }

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write("{\"success\": " + updateSuccess + ", \"message\": \"" + message + "\"}");
%>