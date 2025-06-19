/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author HP - Gia Khiêm
 */
public class Product {

    private int productId;
    private String productName;
    private String description;
    private BigDecimal price;
    private int discount;
    private int stock;
    private String status;
    private int supplierId;
    private int categoryId;
    private int brandId;
    private boolean isFeatured;
    private boolean isBestSeller;
    private boolean isNew;
    private int warrantyPeriod;
    private boolean isActive;
    private String imageUrl;

    public Product(int productId, String productName, String description, BigDecimal price, int discount, int stock, String status, int supplierId, int categoryId, int brandId, boolean isFeatured, boolean isBestSeller, boolean isNew, int warrantyPeriod, boolean isActive, String imageUrl) {
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.stock = stock;
        this.status = status;
        this.supplierId = supplierId;
        this.categoryId = categoryId;
        this.brandId = brandId;
        this.isFeatured = isFeatured;
        this.isBestSeller = isBestSeller;
        this.isNew = isNew;
        this.warrantyPeriod = warrantyPeriod;
        this.isActive = isActive;
        this.imageUrl = imageUrl;
    }

    public Product(int productId, String productName, BigDecimal price, int discount, int stock, String status, boolean isActive) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.discount = discount;
        this.stock = stock;
        this.status = status;
        this.isActive = isActive;
    }

   

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public boolean isIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public boolean isIsBestSeller() {
        return isBestSeller;
    }

    public void setIsBestSeller(boolean isBestSeller) {
        this.isBestSeller = isBestSeller;
    }

    public boolean isIsNew() {
        return isNew;
    }

    public void setIsNew(boolean isNew) {
        this.isNew = isNew;
    }

    public int getWarrantyPeriod() {
        return warrantyPeriod;
    }

    public void setWarrantyPeriod(int warrantyPeriod) {
        this.warrantyPeriod = warrantyPeriod;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

}
