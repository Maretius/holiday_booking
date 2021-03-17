package com.example.holiday_booking;

import java.sql.*;

public class DBConnection {

    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    static final String DB_URL = "jdbc:mariadb://localhost:3306/holiday_booking";
    static final String USER = "root";
    static final String PASS = null;


    public static void main(String[] args) throws SQLException {

    }

    public static void connecttoDBtoUpdate(String sql) {
        System.out.println("init");
        Connection conn = null;
        Statement stmt = null;
        try {
            // Register JDBC driver
            Class.forName(JDBC_DRIVER);
            // Open a connection
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            // Execute a query
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);

        } catch (SQLException se) {
            // Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            // Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            // finally block used to close resources
            try {
                if (stmt != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
    }

    public static ResultSet connecttoDBtoSelect(String sql) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        Statement stmt = null;
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
        return stmt.executeQuery(sql);
    }

//    public static void createTable(){
//        String sql = "CREATE TABLE REGISTRATION "
//                + "(id INTEGER not NULL, "
//                + " first VARCHAR(255), "
//                + " last VARCHAR(255), "
//                + " age INTEGER, "
//                + " PRIMARY KEY ( id ))";
//        connecttoDBtoUpdate(sql);
//    }
//    public static void insertIntoFlats(){
//        String sql = "INSERT INTO Flats "
//                + "VALUES (1001, 'Wohnung 1', 19, 200, 'Geile Wohnung', 'Mannheimer Straße 5-7', 1, 0, 1, 0, 1, 1)";
//        connecttoDBtoUpdate(sql);
//    }
}