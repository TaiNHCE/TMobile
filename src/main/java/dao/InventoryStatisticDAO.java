package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.InventoryStatistic;
import utils.DBContext;

public class InventoryStatisticDAO extends DBContext {

    public ArrayList<InventoryStatistic> getAllInventory() {
        ArrayList<InventoryStatistic> list = new ArrayList<>();
        String sql
                = "SELECT "
                + "  c.CategoryName, "
                + "  b.BrandName, "
                + "  p.ProductName, "
                + "  ISNULL(SUM(isd.Quantity), 0) AS TotalImported, "
                + "  ISNULL((SELECT SUM(oi.Quantity) FROM OrderItems oi WHERE oi.ProductID = p.ProductID), 0) AS TotalSold, "
                + "  ISNULL(SUM(isd.Quantity), 0) - ISNULL((SELECT SUM(oi.Quantity) FROM OrderItems oi WHERE oi.ProductID = p.ProductID), 0) AS Stock, "
                + "  s.Name AS SupplierName, "
                + "  (SELECT TOP 1 istk.ImportDate "
                + "      FROM ImportStocks istk "
                + "      JOIN ImportStockDetails isd2 ON istk.ImportID = isd2.ImportID "
                + "      WHERE isd2.ProductID = p.ProductID "
                + "      ORDER BY istk.ImportDate DESC) AS LastImportDate, "
                + "  (SELECT TOP 1 isd2.UnitPrice "
                + "      FROM ImportStockDetails isd2 "
                + "      JOIN ImportStocks istk2 ON istk2.ImportID = isd2.ImportID "
                + "      WHERE isd2.ProductID = p.ProductID "
                + "      ORDER BY istk2.ImportDate DESC) AS LastImportPrice, "
                + "  p.ProductID, c.CategoryID "
                + "FROM Products p "
                + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "LEFT JOIN Brands b ON p.BrandID = b.BrandID "
                + "LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID "
                + "LEFT JOIN ImportStockDetails isd ON isd.ProductID = p.ProductID "
                + "GROUP BY c.CategoryName, b.BrandName, p.ProductName, s.Name, p.ProductID, c.CategoryID";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                InventoryStatistic stat = new InventoryStatistic();
                stat.setCategoryName(rs.getString("CategoryName"));
                stat.setBrandName(rs.getString("BrandName"));
                stat.setFullName(rs.getString("ProductName"));
                stat.setImportQuantity(rs.getInt("TotalImported"));
                stat.setSoldQuantity(rs.getInt("TotalSold"));
                stat.setStockQuantity(rs.getInt("Stock"));
                stat.setSupplierName(rs.getString("SupplierName"));
                stat.setImportDate(rs.getDate("LastImportDate"));
                stat.setProductImportPrice(rs.getBigDecimal("LastImportPrice"));
                stat.setProductId(rs.getInt("ProductID"));
                stat.setCategoryId(rs.getInt("CategoryID"));
                list.add(stat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<InventoryStatistic> searchInventory(String keyword) {
        ArrayList<InventoryStatistic> list = new ArrayList<>();
        String sql
                = "SELECT "
                + "  c.CategoryName, "
                + "  b.BrandName, "
                + "  p.ProductName, "
                + "  ISNULL(SUM(isd.Quantity), 0) AS TotalImported, "
                + "  ISNULL((SELECT SUM(oi.Quantity) FROM OrderItems oi WHERE oi.ProductID = p.ProductID), 0) AS TotalSold, "
                + "  ISNULL(SUM(isd.Quantity), 0) - ISNULL((SELECT SUM(oi.Quantity) FROM OrderItems oi WHERE oi.ProductID = p.ProductID), 0) AS Stock, "
                + "  s.Name AS SupplierName, "
                + "  (SELECT TOP 1 istk.ImportDate "
                + "      FROM ImportStocks istk "
                + "      JOIN ImportStockDetails isd2 ON istk.ImportID = isd2.ImportID "
                + "      WHERE isd2.ProductID = p.ProductID "
                + "      ORDER BY istk.ImportDate DESC) AS LastImportDate, "
                + "  (SELECT TOP 1 isd2.UnitPrice "
                + "      FROM ImportStockDetails isd2 "
                + "      JOIN ImportStocks istk2 ON istk2.ImportID = isd2.ImportID "
                + "      WHERE isd2.ProductID = p.ProductID "
                + "      ORDER BY istk2.ImportDate DESC) AS LastImportPrice, "
                + "  p.ProductID, c.CategoryID "
                + "FROM Products p "
                + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "LEFT JOIN Brands b ON p.BrandID = b.BrandID "
                + "LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID "
                + "LEFT JOIN ImportStockDetails isd ON isd.ProductID = p.ProductID "
                + "WHERE p.ProductName LIKE ? OR b.BrandName LIKE ? OR c.CategoryName LIKE ? "
                + "GROUP BY c.CategoryName, b.BrandName, p.ProductName, s.Name, p.ProductID, c.CategoryID";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchValue = "%" + keyword + "%";
            ps.setString(1, searchValue);
            ps.setString(2, searchValue);
            ps.setString(3, searchValue);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    InventoryStatistic stat = new InventoryStatistic();
                    stat.setCategoryName(rs.getString("CategoryName"));
                    stat.setBrandName(rs.getString("BrandName"));
                    stat.setFullName(rs.getString("ProductName"));
                    stat.setImportQuantity(rs.getInt("TotalImported"));
                    stat.setSoldQuantity(rs.getInt("TotalSold"));
                    stat.setStockQuantity(rs.getInt("Stock"));
                    stat.setSupplierName(rs.getString("SupplierName"));
                    stat.setImportDate(rs.getDate("LastImportDate"));
                    stat.setProductImportPrice(rs.getBigDecimal("LastImportPrice"));
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

    public ArrayList<InventoryStatistic> getInventoryByCategory(int categoryId) {
        ArrayList<InventoryStatistic> list = new ArrayList<>();
        String sql
                = "SELECT "
                + "  c.CategoryName, "
                + "  b.BrandName, "
                + "  p.ProductName, "
                + "  ISNULL(SUM(isd.Quantity), 0) AS TotalImported, "
                + "  ISNULL((SELECT SUM(oi.Quantity) FROM OrderItems oi WHERE oi.ProductID = p.ProductID), 0) AS TotalSold, "
                + "  ISNULL(SUM(isd.Quantity), 0) - ISNULL((SELECT SUM(oi.Quantity) FROM OrderItems oi WHERE oi.ProductID = p.ProductID), 0) AS Stock, "
                + "  s.Name AS SupplierName, "
                + "  (SELECT TOP 1 istk.ImportDate "
                + "      FROM ImportStocks istk "
                + "      JOIN ImportStockDetails isd2 ON istk.ImportID = isd2.ImportID "
                + "      WHERE isd2.ProductID = p.ProductID "
                + "      ORDER BY istk.ImportDate DESC) AS LastImportDate, "
                + "  (SELECT TOP 1 isd2.UnitPrice "
                + "      FROM ImportStockDetails isd2 "
                + "      JOIN ImportStocks istk2 ON istk2.ImportID = isd2.ImportID "
                + "      WHERE isd2.ProductID = p.ProductID "
                + "      ORDER BY istk2.ImportDate DESC) AS LastImportPrice, "
                + "  p.ProductID, c.CategoryID "
                + "FROM Products p "
                + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "LEFT JOIN Brands b ON p.BrandID = b.BrandID "
                + "LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID "
                + "LEFT JOIN ImportStockDetails isd ON isd.ProductID = p.ProductID "
                + "WHERE c.CategoryID = ? "
                + "GROUP BY c.CategoryName, b.BrandName, p.ProductName, s.Name, p.ProductID, c.CategoryID";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    InventoryStatistic stat = new InventoryStatistic();
                    stat.setCategoryName(rs.getString("CategoryName"));
                    stat.setBrandName(rs.getString("BrandName"));
                    stat.setFullName(rs.getString("ProductName"));
                    stat.setImportQuantity(rs.getInt("TotalImported"));
                    stat.setSoldQuantity(rs.getInt("TotalSold"));
                    stat.setStockQuantity(rs.getInt("Stock"));
                    stat.setSupplierName(rs.getString("SupplierName"));
                    stat.setImportDate(rs.getDate("LastImportDate"));
                    stat.setProductImportPrice(rs.getBigDecimal("LastImportPrice"));
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
