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
        String passwordhash = toHash(password);
        String sql = "SELECT * FROM users WHERE email='" + email.trim() +"'  AND password='" + passwordhash.trim() + "' ";
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
        System.out.println(user.firstname);
        return user;
    }

    public static int readOneEmail(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE email='"+email.trim()+"'";
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
        User user = new User();
        while (rs.next()) {
            user.id = rs.getInt("id");
        }
        return user.id;
    }

    public static void writeOne(String firstname, String lastname, String email, String password, String role) throws SQLException, ClassNotFoundException {
        String passwordhash = toHash(password);
        String sql = "INSERT INTO `users`(`firstname`, `lastname`, `email`, `role`, `password`) "
                + "VALUES ('"+firstname.trim() +"', '"+lastname.trim()+"', '"+email.trim()+"', '"+role.trim()+"', '"+passwordhash.trim()+"')";
        DBConnection.connecttoDBtoUpdate(sql);
    }

    private static String toHash(String password) {
        int hashcode = password.hashCode();
        return ""+hashcode+"";
    }


}
