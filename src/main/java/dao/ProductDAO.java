/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
}
