package uz.pdp.uzummarket.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public interface DBConnection {

    String user = "postgres";
    String password = "1111";
    String url = "jdbc:postgresql://localhost:5432/uzum_market";

    static Properties getProperties() {
        Properties properties = new Properties();
        properties.put("user", user);
        properties.put("password", password);
        return properties;
    }
    static Connection getConnection() throws SQLException {
        DriverManager.registerDriver(new org.postgresql.Driver());
        return  DriverManager.getConnection(url, getProperties());
    }

}
