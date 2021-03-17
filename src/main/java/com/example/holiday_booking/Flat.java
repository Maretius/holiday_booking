package com.example.holiday_booking;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Flat {
    public int id;
    public String name;
    public int size;
    public int price;
    public String info;
    public String adress;
    public int singlebed;
    public int doublebed;
    public int wifi;
    public int tv;
    public int shower;
    public int kitchen;

    public static Flat readOne(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM flats WHERE id="+id ;
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
        Flat flat = new Flat();
        while (rs.next()) {
           flat.price = rs.getInt("price");
           flat.size =  rs.getInt("size");
           flat.adress =  rs.getString("adress");
           flat.singlebed =  rs.getInt("singlebed");
           flat.doublebed =  rs.getInt("doublebed");
           flat.wifi =  rs.getInt("wifi");
           flat.tv =  rs.getInt("tv");
           flat.shower =  rs.getInt("shower");
           flat.kitchen =  rs.getInt("kitchen");
           flat.info = rs.getString("info");
           flat.name = rs.getString("name");
        }
     return flat;
    }

    public static ArrayList<Flat> readAll() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM flats";
        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);
        ArrayList<Flat> flatlist = new ArrayList<>();
        while (rs.next()) {
            Flat flat = new Flat();
            flat.price = rs.getInt("price");
            flat.size =  rs.getInt("size");
            flat.adress =  rs.getString("adress");
            flat.singlebed =  rs.getInt("singlebed");
            flat.doublebed =  rs.getInt("doublebed");
            flat.wifi =  rs.getInt("wifi");
            flat.tv =  rs.getInt("tv");
            flat.shower =  rs.getInt("shower");
            flat.kitchen =  rs.getInt("kitchen");
            flat.info = rs.getString("info");
            flat.name = rs.getString("name");
            flatlist.add(flat);
        }
        return flatlist;
    }


    public static int countFlats() throws SQLException, ClassNotFoundException {
        String sql = "SELECT COUNT(id) AS rowcount FROM flats";

        ResultSet rs = DBConnection.connecttoDBtoSelect(sql);

        int count = rs.getInt("rowcount");
        return count;
    }


}
