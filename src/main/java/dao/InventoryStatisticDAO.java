package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import model.InventoryStatistic;

public class InventoryStatisticDAO {

    private Connection connection;

    public InventoryStatisticDAO(Connection connection) {
        this.connection = connection;
    }

    /**
     * Lấy toàn bộ danh sách thống kê tồn kho với các thông tin chi tiết
     * @throws SQLException
     */
    public List<InventoryStatistic> getAllInventory() throws SQLException {
        List<InventoryStatistic> list = new ArrayList<>();

        String sql = "SELECT " +
                     "c.CategoryID, c.CategoryName, " +
                     "b.BrandName, " +
                     "p.Model, " +
                     "p.ProductName AS FullName, " +
                     "i.Quantity AS StockQuantity, " +
                     "s.SupplierName, " +
                     "pi.ImportDate, " +
                     "pi.ImportQuantity, " +
                     "pi.ProductImportPrice, " +
                     "p.Model AS ModelName, " +
                     "p.ProductID " +
                     "FROM Inventory i " +
                     "JOIN Products p ON i.ProductID = p.ProductID " +
                     "JOIN Categories c ON p.CategoryID = c.CategoryID " +
                     "JOIN Brands b ON p.BrandID = b.BrandID " +
                     "JOIN Suppliers s ON p.SupplierID = s.SupplierID " +
                     "JOIN ProductImport pi ON p.ProductID = pi.ProductID " +
                     "ORDER BY p.ProductName";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                InventoryStatistic stat = new InventoryStatistic();
                stat.setCategoryId(rs.getInt("CategoryID"));
                stat.setCategoryName(rs.getString("CategoryName"));
                stat.setBrandName(rs.getString("BrandName"));
                stat.setModel(rs.getString("Model"));
                stat.setFullName(rs.getString("FullName"));
                stat.setStockQuantity(rs.getInt("StockQuantity"));
                stat.setSupplierName(rs.getString("SupplierName"));
                stat.setImportDate(rs.getDate("ImportDate"));
                stat.setImportQuantity(rs.getInt("ImportQuantity"));
                stat.setProductImportPrice(rs.getBigDecimal("ProductImportPrice"));
                stat.setModelName(rs.getString("ModelName"));
                stat.setProductId(rs.getInt("ProductID"));
                list.add(stat);
            }
        }
        return list;
    }

    /**
 * Tìm kiếm tồn kho theo từ khóa (có thể tìm theo tên sản phẩm, nhà cung cấp, thương hiệu,...)
 */
public List<InventoryStatistic> searchInventory(String keyword) throws SQLException {
    List<InventoryStatistic> list = new ArrayList<>();
    String sql = """
        SELECT 
            c.CategoryID, c.CategoryName,
            b.BrandName,
            p.Model,
            p.ProductName AS FullName,
            i.Quantity AS StockQuantity,
            s.SupplierName,
            pi.ImportDate,
            pi.ImportQuantity,
            pi.ProductImportPrice,
            p.Model AS ModelName,
            p.ProductID
        FROM Inventory i
        JOIN Products p ON i.ProductID = p.ProductID
        JOIN Categories c ON p.CategoryID = c.CategoryID
        JOIN Brands b ON p.BrandID = b.BrandID
        JOIN Suppliers s ON p.SupplierID = s.SupplierID
        JOIN ProductImport pi ON p.ProductID = pi.ProductID
        WHERE p.ProductName LIKE ? OR s.SupplierName LIKE ? OR b.BrandName LIKE ?
        ORDER BY p.ProductName
    """;

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        String searchPattern = "%" + keyword + "%";
        ps.setString(1, searchPattern);
        ps.setString(2, searchPattern);
        ps.setString(3, searchPattern);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            InventoryStatistic stat = new InventoryStatistic();
            stat.setCategoryId(rs.getInt("CategoryID"));
            stat.setCategoryName(rs.getString("CategoryName"));
            stat.setBrandName(rs.getString("BrandName"));
            stat.setModel(rs.getString("Model"));
            stat.setFullName(rs.getString("FullName"));
            stat.setStockQuantity(rs.getInt("StockQuantity"));
            stat.setSupplierName(rs.getString("SupplierName"));
            stat.setImportDate(rs.getDate("ImportDate"));
            stat.setImportQuantity(rs.getInt("ImportQuantity"));
            stat.setProductImportPrice(rs.getBigDecimal("ProductImportPrice"));
            stat.setModelName(rs.getString("ModelName"));
            stat.setProductId(rs.getInt("ProductID"));
            list.add(stat);
        }
    }
    return list;
}

/**
 * Lấy tồn kho theo categoryId
 */
public List<InventoryStatistic> getInventoryByCategory(int categoryId) throws SQLException {
    List<InventoryStatistic> list = new ArrayList<>();
    String sql = """
        SELECT 
            c.CategoryID, c.CategoryName,
            b.BrandName,
            p.Model,
            p.ProductName AS FullName,
            i.Quantity AS StockQuantity,
            s.SupplierName,
            pi.ImportDate,
            pi.ImportQuantity,
            pi.ProductImportPrice,
            p.Model AS ModelName,
            p.ProductID
        FROM Inventory i
        JOIN Products p ON i.ProductID = p.ProductID
        JOIN Categories c ON p.CategoryID = c.CategoryID
        JOIN Brands b ON p.BrandID = b.BrandID
        JOIN Suppliers s ON p.SupplierID = s.SupplierID
        JOIN ProductImport pi ON p.ProductID = pi.ProductID
        WHERE c.CategoryID = ?
        ORDER BY p.ProductName
    """;

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, categoryId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            InventoryStatistic stat = new InventoryStatistic();
            stat.setCategoryId(rs.getInt("CategoryID"));
            stat.setCategoryName(rs.getString("CategoryName"));
            stat.setBrandName(rs.getString("BrandName"));
            stat.setModel(rs.getString("Model"));
            stat.setFullName(rs.getString("FullName"));
            stat.setStockQuantity(rs.getInt("StockQuantity"));
            stat.setSupplierName(rs.getString("SupplierName"));
            stat.setImportDate(rs.getDate("ImportDate"));
            stat.setImportQuantity(rs.getInt("ImportQuantity"));
            stat.setProductImportPrice(rs.getBigDecimal("ProductImportPrice"));
            stat.setModelName(rs.getString("ModelName"));
            stat.setProductId(rs.getInt("ProductID"));
            list.add(stat);
        }
    }
    return list;
}


