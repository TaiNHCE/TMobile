/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import model.Customer;
import sun.applet.Main;
import utils.DBContext;

/**
 *
 * @author pc
 */
public class CustomerDAO extends DBContext {
    public CustomerDAO() {
        super();
    }

   public List<Customer> getAll() {
    List<Customer> list = new ArrayList<>();
    String sql = "SELECT UserID, Email, PasswordHash, FullName, PhoneNumber, CreatedAt, IsActive FROM Users;";

    try (PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            int id = rs.getInt("UserID");
            String email = rs.getString("Email");
            String password = rs.getString("PasswordHash");
            String fullName = rs.getString("FullName");
            String phone = rs.getString("PhoneNumber");
            Date createdAt = rs.getTimestamp("CreatedAt");
            boolean isActive = rs.getBoolean("IsActive");

            // Giả sử class Account có constructor phù hợp:
            list.add(new Customer(id, email, password, fullName, phone, createdAt, isActive));
        }
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
    return list;
}
  public Customer getCustomerbyID(int customerID) {
    Customer cus = null;
    String sql = "SELECT * FROM Users WHERE UserID = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, customerID);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int id = rs.getInt("UserID");
                String email = rs.getString("Email");
                String password = rs.getString("PasswordHash");
                String fullName = rs.getString("FullName");
                String phone = rs.getString("PhoneNumber");
                Date createdAt = rs.getTimestamp("CreatedAt");
                boolean isActive = rs.getBoolean("IsActive");
                String birthday = rs.getString("BirthDate");
                String gender = rs.getString("Gender");
                cus = new Customer(id, email, password, fullName, phone, createdAt, isActive, birthday, gender);
            }
        }
    } catch (Exception e) {
        e.printStackTrace(); // hoặc log ra logger nếu dùng log4j, slf4j
    }
    return cus; // nếu không có bản ghi hoặc có lỗi
}

    public static void main(String[] args) {
        CustomerDAO dao = new CustomerDAO(); // giả sử bạn đã có class này
        List<Customer> accounts = dao.getAll();

        for (Customer acc : accounts) {
            System.out.println("ID: " + acc.getId());
            System.out.println("Email: " + acc.getEmail());
            System.out.println("Password: " + acc.getPassword());
            System.out.println("Full Name: " + acc.getFullName());
            System.out.println("Phone: " + acc.getPhone());
            System.out.println("Created At: " + acc.getCreateAt());
            System.out.println("Is Active: " + acc.isActive());
            System.out.println("------------------------------");
        }
    }
}