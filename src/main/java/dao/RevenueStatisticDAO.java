/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.RevenueStatistic;
import utils.DBContext;

/**
 *
 * @author HP
 */
public class RevenueStatisticDAO extends DBContext {

    public ArrayList<RevenueStatistic> getRevenueByDay() {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "SELECT o.OrderDate, "
                + "COUNT(DISTINCT o.OrderID) AS TotalOrder, "
                + "SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue, "
                + "SUM(oi.Quantity) AS TotalProductsSold "
                + "FROM Orders o "
                + "JOIN OrderItems oi ON o.OrderID = oi.OrderID "
                + "GROUP BY o.OrderDate "
                + "ORDER BY o.OrderDate";

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                RevenueStatistic stat = new RevenueStatistic();
                stat.setOrderDate(rs.getDate("OrderDate"));
                stat.setTotalOrder(rs.getInt("TotalOrder"));
                stat.setTotalRevenue(rs.getLong("TotalRevenue"));
                stat.setTotalProductsSold(rs.getInt("TotalProductsSold"));
                list.add(stat);
            }
        } catch (Exception e) {
            System.err.println("Error in getRevenueByDay: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                // Không đóng conn
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public ArrayList<RevenueStatistic> getRevenueByMonth() {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "SELECT MONTH(o.OrderDate) AS Month, "
                + "YEAR(o.OrderDate) AS Year, "
                + "COUNT(DISTINCT o.OrderID) AS TotalOrder, "
                + "SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue, "
                + "SUM(oi.Quantity) AS TotalProductsSold "
                + "FROM Orders o "
                + "JOIN OrderItems oi ON o.OrderID = oi.OrderID "
                + "GROUP BY MONTH(o.OrderDate), YEAR(o.OrderDate) "
                + "ORDER BY Year, Month";

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                RevenueStatistic stat = new RevenueStatistic();
                stat.setOrderMonth(rs.getInt("Month"));
                stat.setOrderYear(rs.getInt("Year"));
                stat.setTotalOrder(rs.getInt("TotalOrder"));
                stat.setTotalRevenue(rs.getLong("TotalRevenue"));
                stat.setTotalProductsSold(rs.getInt("TotalProductsSold"));
                list.add(stat);
            }
        } catch (Exception e) {
            System.err.println("Error in getRevenueByMonth: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public ArrayList<RevenueStatistic> getRevenueByCategory(int categoryId) {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "SELECT c.CategoryID, "
                + "c.CategoryName, "
                + "COUNT(DISTINCT o.OrderID) AS TotalOrder, "
                + "SUM(oi.Quantity * oi.UnitPrice) AS Revenue, "
                + "SUM(oi.Quantity) AS TotalProductsSold "
                + "FROM Orders o "
                + "JOIN OrderItems oi ON o.OrderID = oi.OrderID "
                + "JOIN Products p ON p.ProductID = oi.ProductID "
                + "JOIN Categories c ON c.CategoryID = p.CategoryID "
                + "WHERE c.CategoryID = ? "
                + "GROUP BY c.CategoryID, c.CategoryName";

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();

            while (rs.next()) {
                RevenueStatistic stat = new RevenueStatistic();
                stat.setCategoryId(rs.getInt("CategoryID"));
                stat.setCategoryName(rs.getString("CategoryName"));
                stat.setTotalOrder(rs.getInt("TotalOrder"));
                stat.setTotalRevenue(rs.getLong("Revenue"));
                stat.setTotalProductsSold(rs.getInt("TotalProductsSold"));
                list.add(stat);
            }
        } catch (Exception e) {
            System.err.println("Error in getRevenueByCategory: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public ArrayList<RevenueStatistic> getRevenueByCategoryOnDay(java.sql.Date date) {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "SELECT c.CategoryID, c.CategoryName, "
                + "SUM(oi.Quantity * oi.UnitPrice) AS Revenue "
                + "FROM Orders o "
                + "JOIN OrderItems oi ON o.OrderID = oi.OrderID "
                + "JOIN Products p ON oi.ProductID = p.ProductID "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "WHERE CAST(o.OrderDate AS DATE) = ? "
                + "GROUP BY c.CategoryID, c.CategoryName";

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setDate(1, date);
            rs = ps.executeQuery();

            while (rs.next()) {
                RevenueStatistic stat = new RevenueStatistic();
                stat.setCategoryId(rs.getInt("CategoryID"));
                stat.setCategoryName(rs.getString("CategoryName"));
                stat.setTotalRevenue(rs.getLong("Revenue"));
                list.add(stat);
            }
        } catch (Exception e) {
            System.err.println("Error in getRevenueByCategoryOnDay: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public ArrayList<RevenueStatistic> getRevenueByCategoryOnMonth(int month, int year) {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "SELECT c.CategoryID, c.CategoryName, "
                + "SUM(oi.Quantity * oi.UnitPrice) AS Revenue "
                + "FROM Orders o "
                + "JOIN OrderItems oi ON o.OrderID = oi.OrderID "
                + "JOIN Products p ON oi.ProductID = p.ProductID "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "WHERE MONTH(o.OrderDate) = ? AND YEAR(o.OrderDate) = ? "
                + "GROUP BY c.CategoryID, c.CategoryName";

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, month);
            ps.setInt(2, year);
            rs = ps.executeQuery();

            while (rs.next()) {
                RevenueStatistic stat = new RevenueStatistic();
                stat.setCategoryId(rs.getInt("CategoryID"));
                stat.setCategoryName(rs.getString("CategoryName"));
                stat.setTotalRevenue(rs.getLong("Revenue"));
                list.add(stat);
            }
        } catch (Exception e) {
            System.err.println("Error in getRevenueByCategoryOnMonth: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public long getMonthlyRevenue(int month, int year) {
        String sql = "SELECT SUM(oi.Quantity * oi.UnitPrice) FROM Orders o JOIN OrderItems oi ON o.OrderID = oi.OrderID WHERE MONTH(o.OrderDate) = ? AND YEAR(o.OrderDate) = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

}
