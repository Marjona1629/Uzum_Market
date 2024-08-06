<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="uz.pdp.uzummarket.util.DBConnection" %>
<%@ page import="java.sql.ResultSet" %>

<%
    String userId = request.getParameter("user_id");
    String action = request.getParameter("action"); // Get action parameter
    boolean updateSuccess = false;
    String message = "";
    String status = "";

    if (userId != null && !userId.isEmpty() && action != null && !action.isEmpty()) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstmt = null;

            if (action.equals("block")) {
                pstmt = con.prepareStatement("UPDATE users SET status = CASE WHEN status = 'ACTIVE' THEN 'BLOCKED' ELSE 'ACTIVE' END WHERE user_id = ?");
                pstmt.setInt(1, Integer.parseInt(userId));
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Update shop status
                    PreparedStatement shopPstmt = con.prepareStatement("UPDATE shops SET status = 'BLOCKED' WHERE owner_id = ?");
                    shopPstmt.setInt(1, Integer.parseInt(userId));
                    shopPstmt.executeUpdate();
                    shopPstmt.close();

                    updateSuccess = true;
                    status = getStatusForUser(Integer.parseInt(userId), con); // Get updated status
                    message = "Customer status updated successfully!";
                } else {
                    message = "No rows affected. User ID may not exist.";
                }
            } else if (action.equals("unblock")) {
                pstmt = con.prepareStatement("UPDATE users SET status = 'ACTIVE' WHERE user_id = ?");
                pstmt.setInt(1, Integer.parseInt(userId));
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    updateSuccess = true;
                    status = getStatusForUser(Integer.parseInt(userId), con); // Get updated status
                    message = "Customer status updated successfully!";
                } else {
                    message = "No rows affected. User ID may not exist.";
                }
            }

            if (pstmt != null) {
                pstmt.close();
            } else {
                message = "Invalid action.";
            }

            con.close();
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
        PreparedStatement stmt = con.prepareStatement("SELECT status FROM users WHERE user_id = ?");
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getString("status");
        }
        return "";
    }
%>
