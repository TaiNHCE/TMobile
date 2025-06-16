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
import model.CategoryDetail;
import model.CategoryDetailGroup;
import utils.DBContext;

/**
 *
 * @author HP - Gia Khiêm
 */
public class CategoryDAO extends DBContext {

    public CategoryDAO() {
        super();
    }

    public List<Category> getAllCategory() {
        List<Category> categoryList = new ArrayList<>();
        String sql = "SELECT CategoryID, CategoryName, Description, CreatedAt, ImgURLLogo, isActive FROM Categories";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int categoryId = rs.getInt("CategoryID");
                String categoryName = rs.getString("CategoryName");
                String descriptionCategory = rs.getString("Description");
                Timestamp createdAt = rs.getTimestamp("CreatedAt");
                String imgUrlLogo = rs.getString("ImgURLLogo");
                boolean isActive = rs.getBoolean("isActive");

                categoryList.add(new Category(categoryId, categoryName, descriptionCategory, createdAt, imgUrlLogo, isActive));
            }
            return categoryList;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return categoryList;
    }

    public List<CategoryDetailGroup> getCategoryDetailGroupById(int categoryId) {
        List<CategoryDetailGroup> categoryDetailGroupList = new ArrayList<>();
        String sql = "SELECT CategoryDetailsGroupID, NameCategoryDetailsGroup, CategoryID from CategoryDetailsGroup where CategoryID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int categoryDetailsGroupID = rs.getInt("CategoryDetailsGroupID");
                String nameCategoryDetailsGroup = rs.getString("NameCategoryDetailsGroup");
                int categoryID = rs.getInt("CategoryID");

                categoryDetailGroupList.add(new CategoryDetailGroup(categoryDetailsGroupID, nameCategoryDetailsGroup, categoryID));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categoryDetailGroupList;
    }

    public List<CategoryDetail> getCategoryDetailById(int categoryId) {
        List<CategoryDetail> categoryDetailList = new ArrayList<>();
        String sql = "SELECT CategoryDetailID, CategoryID, AttributeName, CategoryDetailsGroupID from CategoryDetails where CategoryID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int categoryDetailID = rs.getInt("CategoryDetailID");
                int categoryID = rs.getInt("CategoryID");
                String attributeName = rs.getString("AttributeName");
                int categoryDetailsGroupID = rs.getInt("CategoryDetailsGroupID");

                categoryDetailList.add(new CategoryDetail(categoryDetailID, categoryID, attributeName, categoryDetailsGroupID));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categoryDetailList;
    }

//    public List<CategoryDetail> getAllCategoryDetails() {
//        List<CategoryDetail> categoryDetailList = new ArrayList<>();
//        String sql = "SELECT CategoryID, CategoryName, Description, CreatedAt, ImgURLLogo FROM Categories";
//
//        try {
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                int categoryId = rs.getInt("CategoryID");
//                String categoryName = rs.getString("CategoryName");
//                String descriptionCategory = rs.getString("Description");
//                Timestamp createdAt = rs.getTimestamp("CreatedAt");
//                String imgUrlLogo = rs.getString("ImgURLLogo");
//
//                categoryList.add(new Category(categoryId, categoryName, descriptionCategory, createdAt, imgUrlLogo));
//            }
//            return categoryList;
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//        }
//        return categoryList;
//    }
    public Category getCategoryById(int categoryID) {
        Category category = null;
        String sql = "SELECT CategoryID, CategoryName, Description, CreatedAt, ImgURLLogo, isActive FROM Categories where categoryID = ?";
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
                boolean isActive = rs.getBoolean("isActive");

                category = new Category(categoryId, categoryName, descriptionCategory, createdAt, imgUrlLogo, isActive);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return category;
    }

    public boolean updateCategporyDetailGroup(int categoryDetailsGroupID, String nameCategoryDetailsGroup) {
        String sql = "UPDATE CategoryDetailsGroup SET NameCategoryDetailsGroup = ? WHERE CategoryDetailsGroupID = ?";
        try ( PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, nameCategoryDetailsGroup);
            pstmt.setInt(2, categoryDetailsGroupID);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCategporyDetail(int categoryDetailID, String attributeName) {
        String sql = "UPDATE CategoryDetails SET AttributeName = ? WHERE CategoryDetailID = ?";
        try ( PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, attributeName);
            pstmt.setInt(2, categoryDetailID);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCategory(int categoryId, String categoryName, String description) {
        String sql = "UPDATE Categories SET CategoryName = ? WHERE CategoryID = ?";
        try ( PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, categoryName);
            pstmt.setInt(2, categoryId);
            return pstmt.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteCategory(int categoryId) {
        String sql = "UPDATE Categories SET isActive = 0 WHERE CategoryID = ?";

        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);

            int affectedRows = stmt.executeUpdate();

            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
