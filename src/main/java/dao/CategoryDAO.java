/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import utils.DBContext;

/**
 *
 * @author HP - Gia Khiêm
 */
public class CategoryDAO extends DBContext{
    
    public CategoryDAO() {
        super();
    }
    
    public List<Category> getAllCategory() {
        List<Category> categoryList = new ArrayList<>();
        String sql = "SELECT CategoryID, CategoryName, Description, CreatedAt, ImgURLLogo FROM Categories";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int categoryId = rs.getInt("CategoryID");
                String categoryName = rs.getString("CategoryName");
                String descriptionCategory = rs.getString("Description");
                Timestamp createdAt = rs.getTimestamp("CreatedAt");
                String imgUrlLogo = rs.getString("ImgURLLogo");

                categoryList.add(new Category(categoryId, categoryName, descriptionCategory, createdAt, imgUrlLogo));
            }
            return categoryList;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return categoryList;
    }
    
    public Category getCategoryById(int categoryID) {
        Category category = null;
        String sql = "SELECT CategoryID, CategoryName, Description, CreatedAt, ImgURLLogo FROM Categories";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int categoryId = rs.getInt("CategoryID");
                String categoryName = rs.getString("CategoryName");
                String descriptionCategory = rs.getString("Description");
                Timestamp createdAt = rs.getTimestamp("CreatedAt");
                String imgUrlLogo = rs.getString("ImgURLLogo");

                category = new Category(categoryId, categoryName, descriptionCategory, createdAt, imgUrlLogo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return category;
    }
}
