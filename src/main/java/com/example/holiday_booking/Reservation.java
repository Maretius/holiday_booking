package com.example.holiday_booking;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Reservation {
    public int id;
    public int user_id;
    public int flat_id;
    public Date start;
    public Date end;
    public String status;
    public static void writeOne(String email, String flatname, String startdate, String enddate) throws SQLException, ClassNotFoundException {
        int user_id = User.readOneEmail(email);
        int flat_id = Flat.readOneName(flatname);
        Date start = convertStringToDate(startdate);
        Date end = convertStringToDate(enddate);
        System.out.println(start + " " + end);
        String sql = "INSERT INTO `reservation`(`user_id`, `flat_id`, `start`, `end`, `status`) "
                + "VALUES ("+user_id+", "+flat_id+", '"+start+"', '"+end+"', 'reserviert')";
        System.out.println(sql);
        DBConnection.connecttoDBtoUpdate(sql);

    }

    public static boolean readOne(String flatname, String startstring, String endstring) throws SQLException, ClassNotFoundException {
        int flat_id = Flat.readOneName(flatname);
        Date start = convertStringToDate(startstring);
        Date end = convertStringToDate(endstring);
        String sql = "SELECT * FROM reservation WHERE flat_id="+flat_id+" AND start='"+start+"' AND '"+end+"'";
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);

        ArrayList<Reservation> reservationlist = new ArrayList<>();
        boolean reserved = false;
        boolean beginningreserved = false;
        boolean endingreserved = false;

        while (rs.next()) {
            Reservation reservation = new Reservation();
            reservation.id = rs.getInt("id");
            reservation.flat_id = rs.getInt("flat_id");
            reservation.user_id = rs.getInt("user_id");
            reservation.start = rs.getTimestamp("start");
            reservation.end = rs.getTimestamp("end");
            reservation.status = rs.getString("status");
            reservationlist.add(reservation);
        }

        for (Reservation reservation: reservationlist) {
            Date startdate = start;
            Date enddate = end;

            if(isWithinRange(startdate, reservation.start, reservation.end)){
                beginningreserved = true;
            }
            if(isWithinRange(enddate, reservation.start, reservation.end)){
                endingreserved = true;
            }
        }

        if(beginningreserved || endingreserved){
            reserved = true;
        }

        return reserved;
    }

    public static boolean isWithinRange(Date testDate, Date startDate, Date endDate) {
        return !(testDate.before(startDate) || testDate.after(endDate));
    }

    public static Date convertTimestampToDate(Timestamp stamp){
        Date date = new Date(stamp.getTime());
        System.out.println(date);
        return date;
    }


    public static Date convertStringToDate(String strDate) {
        try {
            DateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
            // you can change format of date
            Date date = formatter.parse(strDate);


            return date;
        } catch (ParseException e) {
            System.out.println("Exception :" + e);
            return null;
        }
    }
}