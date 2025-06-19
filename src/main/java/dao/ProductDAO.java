/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import utils.DBContext;

/**
 *
 * @author HP - Gia Khiêm
 */
public class ProductDAO extends DBContext {

    public List<Product> getProductIsNew() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Discount, p.Stock, p.Status, "
                + "p.SupplierID, p.CategoryID, p.BrandID, p.IsFeatured, p.IsBestSeller, p.IsNew, p.WarrantyPeriod, p.isActive, pro.ImageURL "
                + "FROM Products p "
                + "JOIN ProductImages pro ON p.ProductID = pro.ProductID "
                + "where p.IsNew = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, true);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String description = rs.getString("Description");
                    BigDecimal price = rs.getBigDecimal("Price");
                    int discount = rs.getInt("Discount");
                    int stock = rs.getInt("Stock");
                    String status = rs.getString("Status");
                    int supplierID = rs.getInt("SupplierID");
                    int categoryID = rs.getInt("CategoryID");
                    int brandID = rs.getInt("BrandID");
                    boolean isFeatured = rs.getBoolean("IsFeatured");
                    boolean isBestSeller = rs.getBoolean("IsBestSeller");
                    boolean isNew = rs.getBoolean("IsNew");
                    int warrantyPeriod = rs.getInt("WarrantyPeriod");
                    boolean isActive = rs.getBoolean("isActive");
                    String ImageURL = rs.getString("ImageURL");

                    list.add(new Product(productID, productName, description, price, discount, stock, status, supplierID, categoryID, brandID, isBestSeller, isFeatured, isNew, warrantyPeriod, isActive, ImageURL));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductIsFeatured() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Discount, p.Stock, p.Status, "
                + "p.SupplierID, p.CategoryID, p.BrandID, p.IsFeatured, p.IsBestSeller, p.IsNew, p.WarrantyPeriod, p.isActive, pro.ImageURL "
                + "FROM Products p "
                + "JOIN ProductImages pro ON p.ProductID = pro.ProductID "
                + "where p.IsFeatured = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, true);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String description = rs.getString("Description");
                    BigDecimal price = rs.getBigDecimal("Price");
                    int discount = rs.getInt("Discount");
                    int stock = rs.getInt("Stock");
                    String status = rs.getString("Status");
                    int supplierID = rs.getInt("SupplierID");
                    int categoryID = rs.getInt("CategoryID");
                    int brandID = rs.getInt("BrandID");
                    boolean isFeatured = rs.getBoolean("IsFeatured");
                    boolean isBestSeller = rs.getBoolean("IsBestSeller");
                    boolean isNew = rs.getBoolean("IsNew");
                    int warrantyPeriod = rs.getInt("WarrantyPeriod");
                    boolean isActive = rs.getBoolean("isActive");
                    String ImageURL = rs.getString("ImageURL");

                    list.add(new Product(productID, productName, description, price, discount, stock, status, supplierID, categoryID, brandID, isBestSeller, isFeatured, isNew, warrantyPeriod, isActive, ImageURL));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductIsBestSeller() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Discount, p.Stock, p.Status, "
                + "p.SupplierID, p.CategoryID, p.BrandID, p.IsFeatured, p.IsBestSeller, p.IsNew, p.WarrantyPeriod, p.isActive, pro.ImageURL "
                + "FROM Products p "
                + "JOIN ProductImages pro ON p.ProductID = pro.ProductID "
                + "where p.IsBestSeller = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, true);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String description = rs.getString("Description");
                    BigDecimal price = rs.getBigDecimal("Price");
                    int discount = rs.getInt("Discount");
                    int stock = rs.getInt("Stock");
                    String status = rs.getString("Status");
                    int supplierID = rs.getInt("SupplierID");
                    int categoryID = rs.getInt("CategoryID");
                    int brandID = rs.getInt("BrandID");
                    boolean isFeatured = rs.getBoolean("IsFeatured");
                    boolean isBestSeller = rs.getBoolean("IsBestSeller");
                    boolean isNew = rs.getBoolean("IsNew");
                    int warrantyPeriod = rs.getInt("WarrantyPeriod");
                    boolean isActive = rs.getBoolean("isActive");
                    String ImageURL = rs.getString("ImageURL");

                    list.add(new Product(productID, productName, description, price, discount, stock, status, supplierID, categoryID, brandID, isBestSeller, isFeatured, isNew, warrantyPeriod, isActive, ImageURL));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getDiscountedProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Discount, p.Stock, p.Status, "
                + "p.SupplierID, p.CategoryID, p.BrandID, p.IsFeatured, p.IsBestSeller, p.IsNew, p.WarrantyPeriod, p.isActive, pro.ImageURL "
                + "FROM Products p "
                + "JOIN ProductImages pro ON p.ProductID = pro.ProductID "
                + "where p.Discount > 0";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String description = rs.getString("Description");
                    BigDecimal price = rs.getBigDecimal("Price");
                    int discount = rs.getInt("Discount");
                    int stock = rs.getInt("Stock");
                    String status = rs.getString("Status");
                    int supplierID = rs.getInt("SupplierID");
                    int categoryID = rs.getInt("CategoryID");
                    int brandID = rs.getInt("BrandID");
                    boolean isFeatured = rs.getBoolean("IsFeatured");
                    boolean isBestSeller = rs.getBoolean("IsBestSeller");
                    boolean isNew = rs.getBoolean("IsNew");
                    int warrantyPeriod = rs.getInt("WarrantyPeriod");
                    boolean isActive = rs.getBoolean("isActive");
                    String ImageURL = rs.getString("ImageURL");

                    list.add(new Product(productID, productName, description, price, discount, stock, status, supplierID, categoryID, brandID, isBestSeller, isFeatured, isNew, warrantyPeriod, isActive, ImageURL));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductList() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Discount, p.Stock, p.Status, "
                + "p.SupplierID, p.CategoryID, p.BrandID, p.IsFeatured, p.IsBestSeller, p.IsNew, p.WarrantyPeriod, p.IsActive, "
                + "pi.ImageURL "
                + "FROM Products p "
                + "LEFT JOIN ProductImages pi ON p.ProductID = pi.ProductID";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String description = rs.getString("Description");
                BigDecimal price = rs.getBigDecimal("Price");
                int discount = rs.getInt("Discount");
                int stock = rs.getInt("Stock");
                String status = rs.getString("Status");
                int supplierId = rs.getInt("SupplierID");
                if (rs.wasNull()) {
                    supplierId = 0; // Xử lý null do ON DELETE SET NULL
                }
                int categoryId = rs.getInt("CategoryID");
                if (rs.wasNull()) {
                    categoryId = 0;
                }
                int brandId = rs.getInt("BrandID");
                if (rs.wasNull()) {
                    brandId = 0;
                }
                boolean isFeatured = rs.getBoolean("IsFeatured");
                boolean isBestSeller = rs.getBoolean("IsBestSeller");
                boolean isNew = rs.getBoolean("IsNew");
                int warrantyPeriod = rs.getInt("WarrantyPeriod");
                boolean isActive = rs.getBoolean("IsActive");
                String imageUrl = rs.getString("ImageURL");

                list.add(new Product(productID, productName, description, price, discount, stock, status,
                        supplierId, categoryId, brandId, isFeatured, isBestSeller, isNew,
                        warrantyPeriod, isActive, imageUrl));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> searchProductByName(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Discount, p.Stock, p.Status, "
                + "p.SupplierID, p.CategoryID, p.BrandID, p.IsFeatured, p.IsBestSeller, p.IsNew, p.WarrantyPeriod, p.IsActive, "
                + "pi.ImageURL "
                + "FROM Products p "
                + "LEFT JOIN ProductImages pi ON p.ProductID = pi.ProductID "
                + "WHERE LOWER(p.ProductName) LIKE ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword.toLowerCase() + "%");
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String description = rs.getString("Description");
                    BigDecimal price = rs.getBigDecimal("Price");
                    int discount = rs.getInt("Discount");
                    int stock = rs.getInt("Stock");
                    String status = rs.getString("Status");
                    int supplierId = rs.getInt("SupplierID");
                    if (rs.wasNull()) {
                        supplierId = 0;
                    }
                    int categoryId = rs.getInt("CategoryID");
                    if (rs.wasNull()) {
                        categoryId = 0;
                    }
                    int brandId = rs.getInt("BrandID");
                    if (rs.wasNull()) {
                        brandId = 0;
                    }
                    boolean isFeatured = rs.getBoolean("IsFeatured");
                    boolean isBestSeller = rs.getBoolean("IsBestSeller");
                    boolean isNew = rs.getBoolean("IsNew");
                    int warrantyPeriod = rs.getInt("WarrantyPeriod");
                    boolean isActive = rs.getBoolean("IsActive");
                    String imageUrl = rs.getString("ImageURL");

                    list.add(new Product(productID, productName, description, price, discount, stock, status,
                            supplierId, categoryId, brandId, isFeatured, isBestSeller, isNew,
                            warrantyPeriod, isActive, imageUrl));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Product getProductByID(int productID) {
        Product product = null;
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Discount, p.Stock, p.Status, "
                + "p.SupplierID, p.CategoryID, p.BrandID, p.IsFeatured, p.IsBestSeller, p.IsNew, p.WarrantyPeriod, p.IsActive, "
                + "pi.ImageURL "
                + "FROM Products p "
                + "LEFT JOIN ProductImages pi ON p.ProductID = pi.ProductID "
                + "WHERE p.ProductID = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String productName = rs.getString("ProductName");
                    String description = rs.getString("Description");
                    BigDecimal price = rs.getBigDecimal("Price");
                    int discount = rs.getInt("Discount");
                    int stock = rs.getInt("Stock");
                    String status = rs.getString("Status");
                    int supplierId = rs.getInt("SupplierID");
                    if (rs.wasNull()) {
                        supplierId = 0;
                    }
                    int categoryId = rs.getInt("CategoryID");
                    if (rs.wasNull()) {
                        categoryId = 0;
                    }
                    int brandId = rs.getInt("BrandID");
                    if (rs.wasNull()) {
                        brandId = 0;
                    }
                    boolean isFeatured = rs.getBoolean("IsFeatured");
                    boolean isBestSeller = rs.getBoolean("IsBestSeller");
                    boolean isNew = rs.getBoolean("IsNew");
                    int warrantyPeriod = rs.getInt("WarrantyPeriod");
                    boolean isActive = rs.getBoolean("IsActive");
                    String imageUrl = rs.getString("ImageURL");

                    product = new Product(productID, productName, description, price, discount, stock, status,
                            supplierId, categoryId, brandId, isFeatured, isBestSeller, isNew,
                            warrantyPeriod, isActive, imageUrl);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }

    public boolean activateProduct(int productId) {
        String sql = "UPDATE Products SET IsActive = 1 WHERE ProductID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean rejectProduct(int productId) {
        String sql = "UPDATE Products SET IsActive = 0 WHERE ProductID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean saveNotification(String title, String message, int productId) {
        String sql = "INSERT INTO Notifications (Title, Message, Type, IsRead, CreatedAt, RelatedEntityID, RelatedEntityType) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, message);
            ps.setString(3, "ProductUpdate");
            ps.setBoolean(4, false);
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            ps.setInt(6, productId);
            ps.setString(7, "Product");
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
