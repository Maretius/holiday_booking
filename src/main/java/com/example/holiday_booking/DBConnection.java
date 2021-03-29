package com.example.holiday_booking;

import java.sql.*;

public class DBConnection {

    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    static final String USER = "replica";
    static final String PASS = "replica";


    public static void main(String[] args) throws SQLException {

    }

    public static void connecttoDBtoUpdate(String sql) throws ClassNotFoundException, SQLException {
        String DB_URL = "jdbc:mariadb://192.168.0.106:3306/holiday_booking";
        Connection conn = null;
        Statement stmt = null;
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);
    }

    public static ResultSet connecttoDBtoSelect(String sql) throws SQLException, ClassNotFoundException {
        String DB_URL = "jdbc:mariadb://192.168.0.104:3306/holiday_booking";
        Connection conn = null;
        Statement stmt = null;
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
        return stmt.executeQuery(sql);
    }
}