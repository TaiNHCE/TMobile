/*
 * Click nbfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.ProductVariant;
import utils.DBContext;

/**
 *
 * @author pc
 */
public class ProductDAO extends DBContext {

    public ProductDAO() {
        super();
    }

    public List<ProductVariant> getAllVariantsForCartItems(List<CartItem> cartItems) {
        List<ProductVariant> list = new ArrayList<>();
        if (cartItems == null || cartItems.isEmpty()) {
            return list;
        }

        StringBuilder sql = new StringBuilder("SELECT VariantID, ProductID, Color, Storage, Quantity, Price, Discount, ImageURL, IsActive ");
        sql.append("FROM ProductVariants WHERE ProductID IN (");
        for (int i = 0; i < cartItems.size(); i++) {
            sql.append("?");
            if (i < cartItems.size() - 1) {
                sql.append(",");
            }
        }
        sql.append(")");

        try ( PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < cartItems.size(); i++) {
                ps.setInt(i + 1, cartItems.get(i).getProduct().getProductId());
            }
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int variantId = rs.getInt("VariantID");
                    int productId = rs.getInt("ProductID");
                    String color = rs.getString("Color");
                    String storage = rs.getString("Storage");
                    int quantity = rs.getInt("Quantity");
                    BigDecimal price = rs.getBigDecimal("Price");
                    int discount = rs.getInt("Discount");
                    String imageUrl = rs.getString("ImageURL");
                    boolean isActive = rs.getBoolean("IsActive");

                    ProductVariant variant = new ProductVariant(variantId, productId, color, storage, quantity, price, discount, imageUrl, isActive);
                    list.add(variant);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
