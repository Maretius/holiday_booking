package com.example.holiday_booking;

import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
    public int id;
    public String firstname;
    public String lastname;
    public String email;
    public String role;
    public String password;



    public static User readOne(String email, String password) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE email='" + email.trim() +"'  AND password='" + password.trim() + "' ";
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
        User user = new User();

        while (rs.next()) {
            user.id = rs.getInt("id");
            user.firstname  = rs.getString("firstname");
            user.lastname  = rs.getString("lastname");
            user.email  = rs.getString("email");
            user.role  = rs.getString("role");
            user.password = rs.getString("password");
        }
        return user;
    }






}
