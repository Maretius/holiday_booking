package com.example.holiday_booking;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    static final String DB_URL = "jdbc:mariadb://localhost:3306/holiday_booking";

    //  Database credentials
    static final String USER = "root";
    static final String PASS = null;


    public static void main(String[] args) throws SQLException {

    }

    public static void connecttoDBtoUpdate(String sql) {
        System.out.println("init");
        Connection conn = null;
        Statement stmt = null;
        try {
            //STEP 2: Register JDBC driver
            Class.forName(JDBC_DRIVER);

            //STEP 3: Open a connection
            System.out.println("Connecting to a selected database...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Connected database successfully...");

            //STEP 4: Execute a query
            System.out.println("Executing...");
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);

            System.out.println("Executed...");
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            //finally block used to close resources
            try {
                if (stmt != null) {
                    conn.close();
                }
            } catch (SQLException se) {
            }// do nothing
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
        System.out.println("Goodbye!");
    }

    public static ResultSet connecttoDBtoSelect(String sql) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        Statement stmt = null;
        Flat flat = new Flat();
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);


        return rs;
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