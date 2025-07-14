/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.ImportStockDetail;
import model.Product;
import utils.DBContext;

/**
 *
 * @author HP
 */
public class ImportStockDetailDAO extends DBContext {

    public int createImportStockDetails(ArrayList<ImportStockDetail> detailList) {
        String query = "INSERT INTO ImportStockDetails (ImportID, ProductID, Quantity, UnitPrice) VALUES";
        ArrayList<String> values = new ArrayList<>();

        for (ImportStockDetail d : detailList) {
            String value = "(" + d.getIoid() + "," + d.getProduct().getProductId() + "," + d.getQuantity() + "," + d.getUnitPrice() + ")";
            values.add(value);
        }

        for (String v : values) {
            query += " " + v + ",";
        }

        String finalQuery = query.substring(0, query.length() - 1);

        try {
            PreparedStatement ps = conn.prepareStatement(finalQuery);
            int rs = ps.executeUpdate();
            if (rs > 0) {
                return 1;
            }

        } catch (SQLException e) {
            System.out.println(e);
        }

        return 0;
    }

    public int createImportStockDetail(ImportStockDetail detail) {
        String query = "INSERT INTO ImportStockDetails (ImportID, ProductID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, detail.getIoid());
            ps.setInt(2, detail.getProduct().getProductId());
            ps.setInt(3, detail.getQuantity());
            ps.setLong(4, detail.getUnitPrice());

            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

        return 0;
    }

    public ArrayList<ImportStockDetail> getDetailsById(int detailId) {
        String query = "SELECT * FROM ImportStockDetails WHERE ImportID = ?";
        ArrayList<ImportStockDetail> list = null;
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, detailId);

            ResultSet rs = ps.executeQuery();
            list = new ArrayList<>();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                list.add(new ImportStockDetail(rs.getInt("ImportID"), p, rs.getInt("Quantity"), rs.getLong("UnitPrice")));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public int updateDetailById(ImportStockDetail d) {
        String query = "UPDATE ImportStockDetails SET Quantity = ?, UnitPrice= ? WHERE ProductID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, d.getQuantity());
            ps.setLong(2, d.getUnitPrice());
            ps.setInt(3, d.getProduct().getProductId());

            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

        return 0;
    }

    public int deleteDetailById(int productId, int importId) {
        String query = "DELETE FROM ImportStockDetails WHERE ProductID = ? AND ImportID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            ps.setInt(2, importId);

            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

        return 0;
    }

    public long calculateTotalPrice(int importId) {
        String query = "SELECT SUM(UnitPrice) AS TotalPrice FROM ImportStockDetails WHERE ImportID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, importId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("TotalPrice");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return 0;
    }

    public ArrayList<ImportStockDetail> getImportStocksToday() {
        ArrayList<ImportStockDetail> list = new ArrayList<>();

        String query = "SELECT *\n"
                + "FROM ImportStockDetails IOD\n"
                + "JOIN ImportStocks IO ON IOD.ImportID = IO.ImportID\n"
                + "JOIN Products P ON IOD.ProductID = P.ProductID\n"
                + "WHERE CAST(IO.ImportDate AS DATE) = CAST(GETDATE() AS DATE)\n"
                + "ORDER BY P.ProductID ASC";

        try {
            PreparedStatement ps = conn.prepareStatement(query);

            ResultSet rs = ps.executeQuery();
            list = new ArrayList<>();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                list.add(new ImportStockDetail(rs.getInt("ImportID"), p, rs.getInt("Quantity"), rs.getLong("UnitPrice")));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

}
