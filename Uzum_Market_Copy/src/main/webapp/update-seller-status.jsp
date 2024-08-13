<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>

<%
    String userId = request.getParameter("id");
    String action = request.getParameter("action");
    boolean updateSuccess = false;
    String message = "";
    String status = "";

    if (userId != null && !userId.isEmpty() && action != null && !action.isEmpty()) {
        try (Connection con = DBConnection.getConnection()) {
            String query = "";
            if ("block".equals(action)) {
                query = "UPDATE users SET status = CASE WHEN status = 'ACTIVE' THEN 'BLOCKED' ELSE 'ACTIVE' END WHERE id = ?";
                try (PreparedStatement pstmt = con.prepareStatement(query)) {
                    pstmt.setInt(1, Integer.parseInt(userId));
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        // Update shop status
                        query = "UPDATE shops SET status = 'BLOCKED' WHERE owner_id = ?";
                        try (PreparedStatement shopPstmt = con.prepareStatement(query)) {
                            shopPstmt.setInt(1, Integer.parseInt(userId));
                            shopPstmt.executeUpdate();
                        }
                        updateSuccess = true;
                        status = getStatusForUser(Integer.parseInt(userId), con);
                        message = "Seller and shop status updated successfully!";
                    } else {
                        message = "No rows affected. User ID may not exist.";
                    }
                }
            } else if ("unblock".equals(action)) {
                query = "UPDATE users SET status = 'ACTIVE' WHERE id = ?";
                try (PreparedStatement pstmt = con.prepareStatement(query)) {
                    pstmt.setInt(1, Integer.parseInt(userId));
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        updateSuccess = true;
                        status = getStatusForUser(Integer.parseInt(userId), con);
                        message = "Seller status updated successfully!";
                    } else {
                        message = "No rows affected. User ID may not exist.";
                    }
                }
            } else {
                message = "Invalid action.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "SQL Exception: " + e.getMessage();
        }
    } else {
        message = "Invalid request parameters.";
    }

    response.setContentType("application/json");
    response.getWriter().write("{\"success\": " + updateSuccess + ", \"message\": \"" + message + "\", \"status\": \"" + status + "\"}");
%>

<%!
    private String getStatusForUser(int userId, Connection con) throws SQLException {
        String status = "";
        try (PreparedStatement stmt = con.prepareStatement("SELECT status FROM users WHERE id = ?")) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    status = rs.getString("status");
                }
            }
        }
        return status;
    }
%>