/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import utils.DBContext;

/**
 *
 * @author HP
 */
public class ImportStockDAO extends DBContext {
 
    public Map<String, Integer> getImportStocksCountByDate() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT CAST(OrderDate AS DATE) as ImportDate, SUM(TotalAmount) as TotalImport "
                   + "FROM PurchaseOrders "
                   + "GROUP BY CAST(OrderDate AS DATE) "
                   + "ORDER BY ImportDate";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("ImportDate"), rs.getInt("TotalImport"));
            }
        }
        return result;
    }

    // Thống kê nhập kho theo tháng (dạng: yyyy-MM)
    public Map<String, Integer> getImportStocksCountByMonth() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT FORMAT(OrderDate, 'yyyy-MM') as ImportMonth, SUM(TotalAmount) as TotalImport "
                   + "FROM PurchaseOrders "
                   + "GROUP BY FORMAT(OrderDate, 'yyyy-MM') "
                   + "ORDER BY ImportMonth";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("ImportMonth"), rs.getInt("TotalImport"));
            }
        }
        return result;
    }

    // Thống kê nhập kho theo nhà cung cấp
    public Map<String, Integer> getStocksBySupplier() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT s.Name as SupplierName, SUM(po.TotalAmount) as TotalImport "
                   + "FROM PurchaseOrders po "
                   + "JOIN Suppliers s ON po.SupplierID = s.SupplierID "
                   + "GROUP BY s.Name";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("SupplierName"), rs.getInt("TotalImport"));
            }
        }
        return result;
    }

    // Thống kê top sản phẩm nhập nhiều nhất
    public Map<String, Integer> getTopImportedProducts() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT p.ProductName, SUM(pod.Quantity) as TotalQuantity "
                   + "FROM PurchaseOrderDetails pod "
                   + "JOIN Products p ON pod.ProductID = p.ProductID "
                   + "GROUP BY p.ProductName "
                   + "ORDER BY TotalQuantity DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("ProductName"), rs.getInt("TotalQuantity"));
            }
        }
        return result;
    }
}
