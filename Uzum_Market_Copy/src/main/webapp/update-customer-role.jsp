<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>

<%
    String userId = request.getParameter("user_id");
    boolean updateSuccess = false;
    String message = "";

    if (userId != null && !userId.isEmpty()) {
        try {
            Connection con = DBConnection.getConnection();
            String updateQuery = "UPDATE users SET isDeleted = TRUE WHERE user_id = ?";
            PreparedStatement pstmt = con.prepareStatement(updateQuery);
            pstmt.setInt(1, Integer.parseInt(userId));
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                updateSuccess = true;
                message = "User deleted successfully!";
            } else {
                message = "No rows affected. User ID may not exist.";
            }

            pstmt.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            message = "SQL Exception: " + e.getMessage();
        }
    } else {
        message = "Invalid user ID.";
    }

    response.setContentType("application/json");
    response.getWriter().write("{\"success\": " + updateSuccess + ", \"message\": \"" + message + "\"}");
%>
