package uz.pdp.uzummarket.repositories;

import uz.pdp.uzummarket.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminRepository {

    public int getTotalCustomers() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = 'CUSTOMER'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        }
    }

    public int getPreviousYearCustomers() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = 'CUSTOMER' AND date_time >= (CURRENT_DATE - INTERVAL '1 YEAR')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        }
    }

    public int getTotalSellers() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = 'SELLER'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        }
    }

    public int getPreviousYearSellers() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = 'SELLER' AND date_time >= (CURRENT_DATE - INTERVAL '1 YEAR')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        }
    }

    public int getTotalShops() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM shops";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        }
    }

    public int getPreviousYearShops() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM shops WHERE date_time >= (CURRENT_DATE - INTERVAL '1 YEAR')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        }
    }

    public ResultSet getShopsList() throws SQLException {
        String sql = "SELECT shops.id, shops.name, shops.address, users.first_name, users.last_name " +
                "FROM shops " +
                "JOIN users ON shops.owner_id = users.user_id";
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        return stmt.executeQuery();
    }
}