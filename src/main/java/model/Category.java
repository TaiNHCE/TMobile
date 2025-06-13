/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HP - Gia Khiêm
 */
public class Category {
    private int categoryId;
    private String categoryName;
    private String descriptionCategory;
    private String imgUrlLogo;

    public Category(int categoryId, String categoryName, String descriptionCategory, String imgUrlLogo) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.descriptionCategory = descriptionCategory;
        this.imgUrlLogo = imgUrlLogo;
    }

    public Category() {
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setImgUrlLogo(String imgUrlLogo) {
        this.imgUrlLogo = imgUrlLogo;
    }

    public String getImgUrlLogo() {
        return imgUrlLogo;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public String getDescription() {
        return descriptionCategory;
    }

    public void setCategortId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setDescription(String descriptionCategory) {
        this.descriptionCategory = descriptionCategory;
    }

    @Override
    public String toString() {
        return "Category{" + "categortId=" + categoryId + ", categoryName=" + categoryName + ", descriptionCategory=" + descriptionCategory + '}';
    }
}
