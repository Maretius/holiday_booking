package com.example.holiday_booking;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
        System.out.println(start + " " + end);
        String sql = "INSERT INTO `reservation`(`user_id`, `flat_id`, `start`, `end`, `status`) "
               + "VALUES ("+user_id+", "+flat_id+", '"+start+"', '"+end+"', 'reserviert')";
        System.out.println(sql);
         DBConnection.connecttoDBtoUpdate(sql);

    }

    public static boolean readOne(String flatname, String startstring, String endstring) throws SQLException, ClassNotFoundException {
        int flat_id = Flat.readOneName(flatname);
        Timestamp start = convertStringToTimestamp(startstring);
        Timestamp end = convertStringToTimestamp(endstring);
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
            Date startdate = convertTimestampToDate(start);
            Date enddate = convertTimestampToDate(end);

            Date reservationstartdate = convertTimestampToDate(reservation.start);
            Date reservationenddate = convertTimestampToDate(reservation.end);

            if(isWithinRange(startdate, reservationstartdate, reservationenddate)){
                beginningreserved = true;
            }
            if(isWithinRange(enddate, reservationstartdate, reservationenddate)){
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
