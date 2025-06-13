/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Suppliers;
import utils.DBContext;

/**
 *
 * @author HP
 */
public class SupplierDAO extends DBContext {

    public SupplierDAO() {
    }

    public List<Suppliers> getAllSuppliers() {
        List<Suppliers> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Suppliers";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("supplierID");
                String taxId = rs.getString("taxId");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String phone = rs.getString("phoneNumber");
                String address = rs.getString("address");
                java.time.LocalDateTime createdDate = rs.getTimestamp("createdDate").toLocalDateTime();
                java.time.LocalDateTime lastModify = rs.getTimestamp("lastModify").toLocalDateTime();
                int deleted = rs.getInt("deleted");
                int activate = rs.getInt("activate");

                Suppliers supplier = new Suppliers(id, taxId, name, email, phone, address, createdDate, lastModify, deleted, activate);
                suppliers.add(supplier);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    public int createSupplier(Suppliers s) {
        int n = 0;
        String sql = "INSERT INTO Suppliers (taxId, name, email, phoneNumber, address, createdDate, lastModify, deleted, activate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, s.getTaxId());
            ps.setString(2, s.getName());
            ps.setString(3, s.getEmail());
            ps.setString(4, s.getPhoneNumber());
            ps.setString(5, s.getAddress());
            ps.setTimestamp(6, java.sql.Timestamp.valueOf(s.getCreatedDate()));
            ps.setTimestamp(7, java.sql.Timestamp.valueOf(s.getLastModify()));
            ps.setInt(8, s.getDeleted());
            ps.setInt(9, s.getActivate());
            n = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return n;
    }

    public boolean isSupplierExist(String taxId, String email) {
        String sql = "SELECT COUNT(*) FROM Suppliers WHERE taxId = ? OR email = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, taxId);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteSupplierByID(int supplierId) {
        String sql = "DELETE FROM Suppliers WHERE supplierID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, supplierId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Suppliers getSupplierById(int supplierID) {
        String sql = "SELECT * FROM Suppliers WHERE supplierID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, supplierID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Suppliers(
                        rs.getInt("supplierID"),
                        rs.getString("taxId"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getString("address"),
                        rs.getTimestamp("createdDate").toLocalDateTime(),
                        rs.getTimestamp("lastModify").toLocalDateTime(),
                        rs.getInt("deleted"),
                        rs.getInt("activate")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean updateSupplier(Suppliers s){
        String sql = "UPDATE Suppliers SET taxId = ?, name = ?, email = ?, phoneNumber = ?, address = ?, lastModify = GETDATE(), deleted = ?, activate = ? WHERE supplierID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,s.getTaxId());
            ps.setString(2, s.getName());
            ps.setString(3, s.getEmail());
            ps.setString(4, s.getPhoneNumber());
            ps.setString(5, s.getAddress());
            ps.setInt(6, s.getDeleted());
            ps.setInt(7, s.getActivate());
            ps.setInt(8, s.getSupplierID());
            
            int rows = ps.executeUpdate();
            return rows >0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
