/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import model.Customer;
import model.Staff;
import sun.applet.Main;
import utils.DBContext;
/**
 *
 * @author pc
 */
public class StaffDAO extends DBContext{
    public StaffDAO(){
        super();
    }
    public List<Staff> getStaffList(){
        List<Staff> list = new ArrayList();
        
     String sql = "SELECT StaffID, a.Email, FullName, HiredDate FROM Staff s join Accounts a on s.AccountID = a.AccountID;";

    try (PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            int id = rs.getInt("StaffID");
            String email = rs.getString("Email");
            String fullName = rs.getString("FullName");   
            Date createdAt = rs.getTimestamp("HiredDate");

            // Giả sử class Account có constructor phù hợp:
            list.add(new Staff(id, email, fullName, createdAt));
        }
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
    return list;
}
}
