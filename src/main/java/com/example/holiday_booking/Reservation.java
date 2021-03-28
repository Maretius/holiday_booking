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

    public static void writeOne(int userID, int flatId, String startdate, String enddate) throws SQLException, ClassNotFoundException {
        Date start = convertStringToDate(startdate);
        Date end = convertStringToDate(enddate);
        System.out.println(start + " " + end);
        String sql = "INSERT INTO `reservation`(`user_id`, `flat_id`, `start`, `end`, `status`) "
                + "VALUES ("+userID+", "+flatId+", '"+start+"', '"+end+"', 'reserviert')";
        DBConnection.connecttoDBtoUpdate(sql);

    }

    public static ArrayList<Reservation> readFlat(int id, int year, int month) throws SQLException, ClassNotFoundException {
        int nextMonth = month + 1;
        String sql = "SELECT * FROM reservation WHERE flat_id="+id+" AND ((start>='"+year+"-"+month + "-01' and start<'"+year+"-"+nextMonth+"-01') OR (end>='"+year+"-"+month+"-01' and end<'"+year+"-"+nextMonth+ "-01'))";
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
        ArrayList<Reservation> reservations = new ArrayList<>();
        while (rs.next()) {
            Reservation reservation = new Reservation();
            reservation.id = rs.getInt("id");
            reservation.user_id = rs.getInt("user_id");
            reservation.flat_id = rs.getInt("flat_id");
            reservation.start = rs.getDate("start");
            reservation.end = rs.getDate("end");
            reservation.status = rs.getString("status");
            reservations.add(reservation);
        }
        return reservations;
    }

    public static ArrayList<Reservation> readUserFlat(int userId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM reservation WHERE user_id="+userId;
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
        ArrayList<Reservation> reservations = new ArrayList<>();
        while (rs.next()) {
            Reservation reservation = new Reservation();
            reservation.id = rs.getInt("id");
            reservation.user_id = rs.getInt("user_id");
            reservation.flat_id = rs.getInt("flat_id");
            reservation.start = rs.getDate("start");
            reservation.end = rs.getDate("end");
            reservation.status = rs.getString("status");
            reservations.add(reservation);
        }
        return reservations;
    }

    public static ArrayList<Reservation> readallFlats() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM reservation";
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
        ArrayList<Reservation> reservations = new ArrayList<>();
        while (rs.next()) {
            Reservation reservation = new Reservation();
            reservation.id = rs.getInt("id");
            reservation.user_id = rs.getInt("user_id");
            reservation.flat_id = rs.getInt("flat_id");
            reservation.start = rs.getDate("start");
            reservation.end = rs.getDate("end");
            reservation.status = rs.getString("status");
            reservations.add(reservation);
        }
        return reservations;
    }

    public static void changeFlatStatus(int reservationId) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE reservation SET status='gebucht' WHERE id="+reservationId;
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
    }

    public static boolean checkReserved(int flatId, String startstring, String endstring) throws SQLException, ClassNotFoundException {
        Date start = convertStringToDate(startstring);
        Date end = convertStringToDate(endstring);
        if(start.after(end)){
            return true;
        }
        String sql = "SELECT * FROM `reservation` WHERE `flat_id`='"+flatId+"' AND (`start` BETWEEN '"+start+"' AND '"+end+"' OR `end` BETWEEN '"+start+"' AND '"+end+"' OR (start<='"+start+"' AND end>='"+end+"'));";
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);

        if (!rs.next() ) {
            System.out.println("no data");
            return false;
        }else{
            return true;
        }
    }
    public static Date convertStringToDate(String strDate) {
            java.sql.Date date = java.sql.Date.valueOf(strDate);
            System.out.println("Date: " + date);
            return date;

    }
}