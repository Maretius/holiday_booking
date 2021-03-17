package com.example.holiday_booking;

import java.sql.ResultSet;
import java.sql.SQLException;

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
           flat.info = rs.getString("info");
           flat.name = rs.getString("name");
        }
     return flat;
    }

}
