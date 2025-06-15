/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author VinhNTCE181630
 */
import model.Voucher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import utils.DBContext;

public class VoucherDAO extends DBContext {

    // Lấy danh sách tất cả voucher
    public List<Voucher> getAllVouchers() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Voucher v = mapResultSetToVoucher(rs);
                list.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy voucher theo ID
    public Voucher getVoucherById(int id) {
        String sql = "SELECT * FROM Vouchers WHERE VoucherID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVoucher(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isCodeDuplicate(String code, int excludeId) {
        String sql = "SELECT COUNT(*) FROM Vouchers WHERE Code = ? AND VoucherID <> ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setInt(2, excludeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm voucher
    public boolean addVoucher(Voucher v) {
        String sql = "INSERT INTO Vouchers (Code, DiscountPercent, ExpiryDate, MinOrderAmount, "
                + "MaxDiscountAmount, UsageLimit, UsedCount, IsActive, CreatedAt, Description) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, v.getCode());
            ps.setInt(2, v.getDiscountPercent());
            ps.setDate(3, new java.sql.Date(v.getExpiryDate().getTime()));
            ps.setDouble(4, v.getMinOrderAmount());
            ps.setDouble(5, v.getMaxDiscountAmount());
            ps.setInt(6, v.getUsageLimit());
            ps.setInt(7, v.getUsedCount());
            ps.setBoolean(8, v.isActive());
            ps.setDate(9, new java.sql.Date(v.getCreatedAt().getTime()));
            ps.setString(10, v.getDescription());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật voucher
    public boolean updateVoucher(Voucher v) {
        String sql = "UPDATE Vouchers SET Code=?, DiscountPercent=?, ExpiryDate=?, MinOrderAmount=?, "
                + "MaxDiscountAmount=?, UsageLimit=?, UsedCount=?, IsActive=?, Description=? "
                + "WHERE VoucherID = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, v.getCode());
            ps.setInt(2, v.getDiscountPercent());
            ps.setDate(3, new java.sql.Date(v.getExpiryDate().getTime()));
            ps.setDouble(4, v.getMinOrderAmount());
            ps.setDouble(5, v.getMaxDiscountAmount());
            ps.setInt(6, v.getUsageLimit());
            ps.setInt(7, v.getUsedCount());
            ps.setBoolean(8, v.isActive());
            ps.setString(9, v.getDescription());
            ps.setInt(10, v.getVoucherID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa voucher
    public boolean deleteVoucher(int id) {
        String sql = "DELETE FROM Vouchers WHERE VoucherID = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Voucher> searchByCode(String keyword) {
        List<Voucher> result = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers WHERE Code LIKE ?";

        try (
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                result.add(extractVoucher(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    private Voucher extractVoucher(ResultSet rs) throws SQLException {
        int id = rs.getInt("VoucherID");
        String code = rs.getString("Code");
        int discountPercent = rs.getInt("DiscountPercent");
        Date expiryDate = rs.getDate("ExpiryDate");
        double minOrderAmount = rs.getDouble("MinOrderAmount");
        double maxDiscountAmount = rs.getDouble("MaxDiscountAmount");
        int usageLimit = rs.getInt("UsageLimit");
        int usedCount = rs.getInt("UsedCount");
        boolean isActive = rs.getBoolean("IsActive");
        Timestamp createdAt = rs.getTimestamp("CreatedAt"); // hoặc getDate nếu kiểu là DATE
        String description = rs.getString("Description");

        return new Voucher(id, code, discountPercent, expiryDate, minOrderAmount,
                maxDiscountAmount, usageLimit, usedCount, isActive, createdAt, description);
    }

    // Helper - chuyển từ ResultSet thành Object
    private Voucher mapResultSetToVoucher(ResultSet rs) throws SQLException {
        Voucher v = new Voucher();
        v.setVoucherID(rs.getInt("VoucherID"));
        v.setCode(rs.getString("Code"));
        v.setDiscountPercent(rs.getInt("DiscountPercent"));
        v.setExpiryDate(rs.getDate("ExpiryDate"));
        v.setMinOrderAmount(rs.getDouble("MinOrderAmount"));
        v.setMaxDiscountAmount(rs.getDouble("MaxDiscountAmount"));
        v.setUsageLimit(rs.getInt("UsageLimit"));
        v.setUsedCount(rs.getInt("UsedCount"));
        v.setActive(rs.getBoolean("IsActive"));
        v.setCreatedAt(rs.getDate("CreatedAt"));
        v.setDescription(rs.getString("Description"));
        return v;
    }
}
