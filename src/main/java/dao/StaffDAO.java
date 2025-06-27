/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import model.Staff;
import sun.applet.Main;
import utils.DBContext;

/**
 *
 * @author pc
 */
public class StaffDAO extends DBContext {

    public StaffDAO() {
        super();
    }

    public List<Staff> getStaffList() {
        List<Staff> list = new ArrayList();
        String sql = "SELECT StaffID, a.Email, FullName, HiredDate FROM Staff s join Accounts a on s.AccountID = a.AccountID;";
        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("StaffID");
                String email = rs.getString("Email");
                String fullName = rs.getString("FullName");
                Date hiredDate = rs.getTimestamp("HiredDate");
                String formattedDate = new SimpleDateFormat("dd-MM-yyyy").format(hiredDate);
                // Giả sử class Account có constructor phù hợp:
                list.add(new Staff(id, email, fullName, formattedDate));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Staff getStaffByID(int staffID) {
        Staff sta = null;
        String sql = "SELECT StaffID, a.Email, FullName,s.PhoneNumber, HiredDate,Position,s.BirthDate,s.Gender  FROM Staff s JOIN Accounts a ON s.AccountID = a.AccountID Where StaffID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("StaffID");
                    String email = rs.getString("Email");
                    String fullName = rs.getString("FullName");
                    String phone = rs.getString("PhoneNumber");
                    Date hiredDate = rs.getTimestamp("HiredDate");
                    String formattedDate = new SimpleDateFormat("dd-MM-yyyy").format(hiredDate);
                    String position = rs.getString("Position");
                    String birthday = rs.getString("BirthDate");
                    String gender = rs.getString("Gender");
                    sta = new Staff(id, email, fullName, phone, formattedDate,position, birthday, gender);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // hoặc log ra logger nếu dùng log4j, slf4j
        }
        return sta; // nếu không có bản ghi hoặc có lỗi
    }

    public List<Staff> searchStaffByName(String keyword) {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT StaffID, a.Email, FullName, HiredDate FROM Staff s JOIN Accounts a ON s.AccountID = a.AccountID WHERE LOWER(FullName) LIKE ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword.toLowerCase() + "%");  // tìm theo tên gần đúng

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("StaffID");
                    String email = rs.getString("Email");
                    String fullName = rs.getString("FullName");
                    Date hiredDate = rs.getTimestamp("HiredDate");
                    String formattedDate = new SimpleDateFormat("dd-MM-yyyy").format(hiredDate);

                    list.add(new Staff(id, email, fullName, formattedDate));
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return list;
    }

}
