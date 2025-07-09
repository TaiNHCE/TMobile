/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.Account;
import model.Customer;
import utils.DBContext;

/**
 *
 * @author pc
 */
public class AccountDAO extends DBContext {

    public AccountDAO() {
        super();
    }

    public String hashMD5(String pass) {
        try {
            MessageDigest mes = MessageDigest.getInstance("MD5");
            byte[] mesMD5 = mes.digest(pass.getBytes());
            //[0x0a, 0x7a, 0x12, 0x09,...]
            StringBuilder str = new StringBuilder();
            for (byte b : mesMD5) {
                //0x0a
                String ch = String.format("%02x", b);
                //0a
                str.append(ch);
            }
            //str = 0a7a1209
            return str.toString();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return "";
    }

    public Account verifyMD5(String email, String pass) {
        Account acc = new Account();
        String sql = "SELECT * FROM Accounts WHERE Email = ? AND PasswordHash = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashMD5(pass));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                acc.setAccountID(rs.getInt("AccountID"));
                acc.setEmail(rs.getString("Email"));
                acc.setPasswordHash(rs.getString("PasswordHash"));
                acc.setIsActive(rs.getBoolean("IsActive"));
                acc.setRoleID(rs.getInt("RoleID"));
                return acc;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    public boolean checkEmailExisted(String email) {
    String sql = "SELECT * FROM Accounts WHERE Email = ?";
    try {
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return true;
        }
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
    return false;
}   
   public boolean changePassword(int id, String oldPassword, String newPassword) {
    String sqlCheck = "SELECT Password FROM Accounts WHERE AccountID = ?";
    String sqlUpdate = "UPDATE Accounts SET Password = ? WHERE AccountID = ?";
    
    try (PreparedStatement checkStmt = conn.prepareStatement(sqlCheck)) {
        checkStmt.setInt(1, id);
        ResultSet rs = checkStmt.executeQuery();
        
        if (rs.next()) {
            String currentPasswordHash = rs.getString("Password");
            String oldPasswordHash = hashMD5(oldPassword);
            
            // Kiểm tra mật khẩu cũ đúng không
            if (!currentPasswordHash.equals(oldPasswordHash)) {
                return false; // Mật khẩu cũ sai
            }
        } else {
            return false; // Không tìm thấy account
        }
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }

    // Nếu đúng thì update mật khẩu mới
    try (PreparedStatement updateStmt = conn.prepareStatement(sqlUpdate)) {
        String newPasswordHash = hashMD5(newPassword);
        updateStmt.setString(1, newPasswordHash);
        updateStmt.setInt(2, id);
        int rowsAffected = updateStmt.executeUpdate();
        return rowsAffected > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}
 public boolean addNewAccount(Account acc) {
    String sql = "INSERT INTO Accounts (Email, PasswordHash, RoleID, IsActive) VALUES (?, ?, ?, ?)";
    try {
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, acc.getEmail());
        ps.setString(2, acc.getPasswordHash()); 
        ps.setInt(3, 3);
        ps.setBoolean(4, true); 

        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
    return false;
}

    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
        String pass = "123456";
        System.out.println(dao.hashMD5(pass));
    }
}
