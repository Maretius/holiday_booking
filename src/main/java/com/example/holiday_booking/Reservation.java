package com.example.holiday_booking;
import java.sql.*;
import java.time.*;

public class Reservation {
    int id;
    int user_id;
    int flat_id;
    Timestamp start;
    Timestamp end;
    String status;


    public static void writeOne(String email, String flatname, Timestamp start, Timestamp end) throws SQLException, ClassNotFoundException {
        int user_id = User.readOneEmail(email);
        int flat_id = Flat.readOneName(flatname);
        String sql = "INSERT INTO `reservation`(`user_id`, `flat_id`, `start`, `end`, `status`) "
               + "VALUES ('"+user_id+"', '"+flat_id+"', '"+start+"', '"+end+"', reserviert)";
         DBConnection.connecttoDBtoUpdate(sql);

    }
}
