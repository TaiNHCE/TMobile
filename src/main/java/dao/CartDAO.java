package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.Product;
import model.ProductVariant;
import java.math.BigDecimal;
import utils.DBContext;

public class CartDAO extends DBContext {

    public CartDAO() {
        super();
    }

    public List<CartItem> getCartItemsByAccountId(int accountId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT ci.CartItemID, ci.CartID, ci.ProductID, ci.VariantID, ci.Quantity, ci.AddedAt, "
                + "p.ProductID, p.ProductName, p.Price, p.Discount, p.Stock, p.Status, p.isActive, "
                + "pv.VariantID AS PV_VariantID, pv.Color, pv.Storage, pv.Price AS VariantPrice, pv.Discount AS VariantDiscount, "
                + "pv.SKU, pv.ImageURL AS VariantImageURL, pv.isActive AS VariantIsActive "
                + "FROM CartItems ci "
                + "JOIN Cart c ON ci.CartID = c.CartID "
                + "JOIN Products p ON ci.ProductID = p.ProductID "
                + "LEFT JOIN ProductVariants pv ON ci.VariantID = pv.VariantID "
                + "WHERE c.AccountID = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo đối tượng CartItem
                    CartItem item = new CartItem();
                    item.setCartItemID(rs.getInt("CartItemID"));
                    item.setCartID(rs.getInt("CartID"));
                    item.setProductID(rs.getInt("ProductID"));
                    item.setVariantID(rs.getInt("VariantID") != 0 ? rs.getInt("VariantID") : null);
                    item.setQuantity(rs.getInt("Quantity"));
                    Timestamp addedAt = rs.getTimestamp("AddedAt");
                    if (addedAt != null) {
                        item.setAddedAt(new java.util.Date(addedAt.getTime()));
                    }

                    // Tạo đối tượng Product
                    Product product = new Product();
                    product.setProductId(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setPrice(rs.getBigDecimal("Price"));
                    product.setDiscount(rs.getInt("Discount"));
                    product.setStock(rs.getInt("Stock"));
                    product.setStatus(rs.getString("Status"));
                    product.setIsActive(rs.getBoolean("isActive"));
                    item.setProduct(product);

                    // Tạo đối tượng ProductVariant (nếu có)
                    if (rs.getInt("PV_VariantID") != 0) {
                        ProductVariant variant = new ProductVariant();
                        variant.setVariantId(rs.getInt("PV_VariantID"));
                        variant.setProductId(rs.getInt("ProductID"));
                        variant.setColor(rs.getString("Color"));
                        variant.setStorage(rs.getString("Storage"));
                        variant.setPrice(rs.getBigDecimal("VariantPrice"));
                        variant.setDiscount(rs.getInt("VariantDiscount"));
                        variant.setSku(rs.getString("SKU"));
                        variant.setImageUrl(rs.getString("VariantImageURL"));
                        variant.setIsActive(rs.getBoolean("VariantIsActive"));
                        item.setVariant(variant);
                    }

                    cartItems.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItems;
    }

    public CartItem getCartItemById(int cartItemId) {
        String sql = "SELECT ci.CartItemID, ci.CartID, ci.ProductID, ci.VariantID, ci.Quantity, ci.AddedAt, "
                + "p.ProductID, p.ProductName, p.Price, p.Discount, p.Stock, p.Status, p.isActive, "
                + "pv.VariantID AS PV_VariantID, pv.Color, pv.Storage, pv.Price AS VariantPrice, pv.Discount AS VariantDiscount, "
                + "pv.SKU, pv.ImageURL AS VariantImageURL, pv.isActive AS VariantIsActive, pv.Quantity AS VariantQuantity "
                + "FROM CartItems ci "
                + "JOIN Products p ON ci.ProductID = p.ProductID "
                + "LEFT JOIN ProductVariants pv ON ci.VariantID = pv.VariantID "
                + "WHERE ci.CartItemID = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartItemId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartItemID(rs.getInt("CartItemID"));
                    item.setCartID(rs.getInt("CartID"));
                    item.setProductID(rs.getInt("ProductID"));
                    item.setVariantID(rs.getInt("VariantID") != 0 ? rs.getInt("VariantID") : null);
                    item.setQuantity(rs.getInt("Quantity"));
                    Timestamp addedAt = rs.getTimestamp("AddedAt");
                    if (addedAt != null) {
                        item.setAddedAt(new java.util.Date(addedAt.getTime()));
                    }

                    Product product = new Product();
                    product.setProductId(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setPrice(rs.getBigDecimal("Price"));
                    product.setDiscount(rs.getInt("Discount"));
                    product.setStock(rs.getInt("Stock"));
                    product.setStatus(rs.getString("Status"));
                    product.setIsActive(rs.getBoolean("isActive"));
                    item.setProduct(product);

                    if (rs.getInt("PV_VariantID") != 0) {
                        ProductVariant variant = new ProductVariant();
                        variant.setVariantId(rs.getInt("PV_VariantID"));
                        variant.setProductId(rs.getInt("ProductID"));
                        variant.setColor(rs.getString("Color"));
                        variant.setStorage(rs.getString("Storage"));
                        variant.setPrice(rs.getBigDecimal("VariantPrice"));
                        variant.setDiscount(rs.getInt("VariantDiscount"));
                        variant.setSku(rs.getString("SKU"));
                        variant.setImageUrl(rs.getString("VariantImageURL"));
                        variant.setIsActive(rs.getBoolean("VariantIsActive"));
                        variant.setQuantity(rs.getInt("VariantQuantity"));
                        item.setVariant(variant);
                    }

                    return item;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteCartItem(int cartItemId) {
        String sql = "DELETE FROM CartItems WHERE CartItemID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartItemId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteMultipleCartItems(List<String> cartItemIds) {
        if (cartItemIds == null || cartItemIds.isEmpty()) {
            return false;
        }

        String sql = "DELETE FROM CartItems WHERE CartItemID IN ("
                + String.join(",", new String[cartItemIds.size()]).replaceAll("[^,]+", "?") + ")";
        try {
            conn.setAutoCommit(false);
            try ( PreparedStatement ps = conn.prepareStatement(sql)) {
                for (int i = 0; i < cartItemIds.size(); i++) {
                    ps.setInt(i + 1, Integer.parseInt(cartItemIds.get(i)));
                }
                int rowsAffected = ps.executeUpdate();
                conn.commit();
                return rowsAffected == cartItemIds.size();
            }
        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean updateCartItemQuantity(int cartItemId, int quantity) {
        String sql = "UPDATE CartItems SET Quantity = ? WHERE CartItemID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCartItemVariant(int cartItemId, Integer variantId) {
        String sql = "UPDATE CartItems SET VariantID = ? WHERE CartItemID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            if (variantId == null || variantId == 0) {
                ps.setNull(1, java.sql.Types.INTEGER);
            } else {
                ps.setInt(1, variantId);
            }
            ps.setInt(2, cartItemId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProductStock(int productId, int newStock) {
        String sql = "UPDATE Products SET Stock = ? WHERE ProductID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newStock);
            ps.setInt(2, productId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateVariantStock(int variantId, int newStock) {
        String sql = "UPDATE ProductVariants SET Quantity = ? WHERE VariantID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newStock);
            ps.setInt(2, variantId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
