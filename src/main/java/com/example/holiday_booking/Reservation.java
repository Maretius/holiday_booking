package com.example.holiday_booking;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.util.Date;

public class Reservation {
    int id;
    int user_id;
    int flat_id;
    Timestamp start;
    Timestamp end;
    String status;


    public static void writeOne(String email, String flatname, String startdate, String enddate) throws SQLException, ClassNotFoundException {
        int user_id = User.readOneEmail(email);
        int flat_id = Flat.readOneName(flatname);
        Timestamp start = convertStringToTimestamp(startdate);
        Timestamp end = convertStringToTimestamp(enddate);
        String sql = "INSERT INTO `reservation`(`user_id`, `flat_id`, `start`, `end`, `status`) "
               + "VALUES ('"+user_id+"', '"+flat_id+"', '"+start+"', '"+end+"', `reserviert`)";
        System.out.println(sql);
         DBConnection.connecttoDBtoUpdate(sql);

    }

    public static Timestamp convertStringToTimestamp(String strDate) {
        try {
            DateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
            // you can change format of date
            Date date = formatter.parse(strDate);
            Timestamp timeStampDate = new Timestamp(date.getTime());

            return timeStampDate;
        } catch (ParseException e) {
            System.out.println("Exception :" + e);
            return null;
        }
    }
}
