package com.example.holiday_booking;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static void main( String[] args ) throws SQLException {

    }
    public static void connecttoDB() throws SQLException, ClassNotFoundException {
            System.out.println("init");
            Class.forName("org.mariadb.jdbc.Driver");
            try {
                try (Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/holiday_booking", "root", null)){
                    System.out.println("connected");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        }
}
