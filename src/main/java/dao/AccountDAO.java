/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Account;
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

    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
        String pass = "123456";
        System.out.println(dao.hashMD5(pass));
    }
}
