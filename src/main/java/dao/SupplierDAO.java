package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Suppliers;
import utils.DBContext;

public class SupplierDAO extends DBContext {

    public List<Suppliers> getAllSuppliers() {
        List<Suppliers> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Suppliers";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Suppliers s = new Suppliers(
                        rs.getInt("supplierID"),
                        rs.getString("taxId"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getString("address"),
                        rs.getTimestamp("createdDate").toLocalDateTime(),
                        rs.getTimestamp("lastModify").toLocalDateTime(),
                        rs.getInt("deleted"),
                        rs.getInt("activate"),
                        rs.getString("contactPerson"),
                        rs.getString("supplyGroup"),
                        rs.getString("description")
                );
                suppliers.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    public int createSupplier(Suppliers s) {
        int n = 0;
        String sql = "INSERT INTO Suppliers (taxId, name, email, phoneNumber, address, createdDate, lastModify, deleted, activate, contactPerson, supplyGroup, description) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            ps.setString(10, s.getContactPerson());
            ps.setString(11, s.getSupplyGroup());
            ps.setString(12, s.getDescription());
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
            return ps.executeUpdate() > 0;
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
                        rs.getInt("activate"),
                        rs.getString("contactPerson"),
                        rs.getString("supplyGroup"),
                        rs.getString("description")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateSupplier(Suppliers s) {
        String sql = "UPDATE Suppliers SET taxId = ?, name = ?, email = ?, phoneNumber = ?, address = ?, "
                + "lastModify = GETDATE(), deleted = ?, activate = ?, contactPerson = ?, supplyGroup = ?, description = ? "
                + "WHERE supplierID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, s.getTaxId());
            ps.setString(2, s.getName());
            ps.setString(3, s.getEmail());
            ps.setString(4, s.getPhoneNumber());
            ps.setString(5, s.getAddress());
            ps.setInt(6, s.getDeleted());
            ps.setInt(7, s.getActivate());
            ps.setString(8, s.getContactPerson());
            ps.setString(9, s.getSupplyGroup());
            ps.setString(10, s.getDescription());
            ps.setInt(11, s.getSupplierID());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Suppliers> findSuppliersByName(String name) {
        List<Suppliers> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Suppliers WHERE LOWER(name) LIKE ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + name.toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Suppliers s = new Suppliers(
                        rs.getInt("supplierID"),
                        rs.getString("taxId"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getString("address"),
                        rs.getTimestamp("createdDate").toLocalDateTime(),
                        rs.getTimestamp("lastModify").toLocalDateTime(),
                        rs.getInt("deleted"),
                        rs.getInt("activate"),
                        rs.getString("contactPerson"),
                        rs.getString("supplyGroup"),
                        rs.getString("description")
                );
                suppliers.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return suppliers;
    }

}
