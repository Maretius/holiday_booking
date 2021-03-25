package com.example.holiday_booking;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class Reservation {
    public int id;
    public int user_id;
    public int flat_id;
    public Date start;
    public Date end;
    public String status;

    public static Reservation readOne(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM reservation WHERE id=" + id;
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
        Reservation reservation = new Reservation();
        while (rs.next()) {
            reservation.id = rs.getInt("id");
            reservation.user_id = rs.getInt("price");
            reservation.flat_id = rs.getInt("size");
            reservation.start = rs.getDate("start");
            reservation.end = rs.getDate("end");
            reservation.status = rs.getString("status");
        }
        return reservation;
    }

    public static ArrayList<Reservation> readAll() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM reservation";
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
        ArrayList<Reservation> reservationList = new ArrayList<>();
        while (rs.next()) {
            Reservation reservation = new Reservation();
            reservation.id = rs.getInt("id");
            reservation.user_id = rs.getInt("price");
            reservation.flat_id =  rs.getInt("size");
            reservation.start =  rs.getDate("start");
            reservation.end =  rs.getDate("end");
            reservation.status = rs.getString("status");
            reservationList.add(reservation);
        }
        return reservationList;
    }
}
