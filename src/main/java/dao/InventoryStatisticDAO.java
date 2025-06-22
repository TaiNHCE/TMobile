/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author HP
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.InventoryStatistic;
import utils.DBContext;

public class InventoryStatisticDAO extends DBContext {

    public ArrayList<InventoryStatistic> getAllInventory() {
        ArrayList<InventoryStatistic> list = new ArrayList<>();
        String sql = "SELECT c.CategoryName, b.BrandName, p.ProductName, "
                + "ISNULL(SUM(isd.Quantity), 0) AS TotalImported, "
                + "ISNULL((SELECT SUM(oi.Quantity) FROM OrderItems oi WHERE oi.ProductID = p.ProductID), 0) AS TotalSold, "
                + "ISNULL(SUM(isd.Quantity), 0) - ISNULL((SELECT SUM(oi.Quantity) FROM OrderItems oi WHERE oi.ProductID = p.ProductID), 0) AS Stock, "
                + "s.Name AS SupplierName, isks.ImportDate AS ImportDate, isd.UnitPrice AS ProductImportPrice, "
                + "p.ProductID, c.CategoryID "
                + "FROM Products p "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "JOIN Brands b ON p.BrandID = b.BrandID "
                + "JOIN Suppliers s ON p.SupplierID = s.SupplierID "
                + "JOIN ImportStockDetails isd ON isd.ProductID = p.ProductID "
                + "JOIN ImportStocks isks ON isks.ImportID = isd.ImportID "
                + "GROUP BY c.CategoryName, b.BrandName, p.ProductName, s.Name, isks.ImportDate, isd.UnitPrice, p.ProductID, c.CategoryID";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                InventoryStatistic stat = new InventoryStatistic();
                stat.setCategoryName(rs.getString("CategoryName"));
                stat.setBrandName(rs.getString("BrandName"));
                stat.setFullName(rs.getString("ProductName"));
                stat.setImportQuantity(rs.getInt("TotalImported"));
                stat.setSoldQuantity(rs.getInt("TotalSold"));
                stat.setStockQuantity(rs.getInt("Stock"));
                stat.setSupplierName(rs.getString("SupplierName"));
                stat.setImportDate(rs.getDate("ImportDate"));
                stat.setProductImportPrice(rs.getBigDecimal("ProductImportPrice"));
                stat.setProductId(rs.getInt("ProductID"));
                stat.setCategoryId(rs.getInt("CategoryID"));
                list.add(stat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Other methods like searchInventory and getInventoryByCategory need similar adjustments
    // Example for searchInventory method:

    public ArrayList<InventoryStatistic> searchInventory(String keyword) {
        ArrayList<InventoryStatistic> list = new ArrayList<>();
        String sql = "SELECT c.CategoryName, b.BrandName, p.ProductName, p.Stock, s.Name AS SupplierName, "
                + "isks.ImportDate AS ImportDate, isd.Quantity AS ImportQuantity, isd.UnitPrice AS ProductImportPrice, "
                + "p.ProductID, c.CategoryID "
                + "FROM Products p "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "JOIN Brands b ON p.BrandID = b.BrandID "
                + "JOIN Suppliers s ON p.SupplierID = s.SupplierID "
                + "JOIN ImportStockDetails isd ON isd.ProductID = p.ProductID "
                + "JOIN ImportStocks isks ON isks.ImportID = isd.ImportID "
                + "WHERE p.ProductName LIKE ? OR b.BrandName LIKE ? OR c.CategoryName LIKE ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchValue = "%" + keyword + "%";
            ps.setString(1, searchValue);
            ps.setString(2, searchValue);
            ps.setString(3, searchValue);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    InventoryStatistic stat = new InventoryStatistic();
                    stat.setCategoryName(rs.getString("CategoryName"));
                    stat.setBrandName(rs.getString("BrandName"));
                    stat.setFullName(rs.getString("ProductName"));
                    stat.setStockQuantity(rs.getInt("Stock"));
                    stat.setSupplierName(rs.getString("SupplierName"));
                    stat.setImportDate(rs.getDate("ImportDate"));
                    stat.setImportQuantity(rs.getInt("ImportQuantity"));
                    stat.setProductImportPrice(rs.getBigDecimal("ProductImportPrice"));
                    stat.setProductId(rs.getInt("ProductID"));
                    stat.setCategoryId(rs.getInt("CategoryID"));
                    list.add(stat);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
