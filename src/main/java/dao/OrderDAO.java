package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;

import utils.DBContext;

public class OrderDAO extends DBContext {

    public List<Order> getOrderList() {
        List<Order> list = new ArrayList<>();
        String url = "select * from Orders where Orders.Status != 6 Order BY Orders.Status  ASC";
        try {

            PreparedStatement pre = conn.prepareStatement(url);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                Order o = new Order(rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getString("FullName"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address"),
                        rs.getInt("TotalAmount"),
                        rs.getString("OrderedDate"),
                        rs.getInt("Status"));
                list.add(o);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public Order getOrderByID(String orderID) {
        Order o = new Order();
        String query = "select * from Orders where Orders.OrderID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(query);
            pre.setString(1, orderID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                o.setOrderID(rs.getInt("OrderID"));
                o.setAccountID(rs.getInt("CustomerID"));
                o.setFullName(rs.getString("FullName"));
                o.setPhone(rs.getString("PhoneNumber"));
                o.setAddress(rs.getString("Address"));
                o.setTotalAmount(rs.getInt("TotalAmount"));
                o.setOrderDate(rs.getString("OrderedDate"));
                o.setStatus(rs.getInt("Status"));
                o.setDiscount(rs.getInt("Discount"));
            }
        } catch (Exception e) {
        }
        return o;
    }

    public boolean updateStatus(int orderId, int newStatus) {
    String query = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
    try {
        PreparedStatement pre = conn.prepareStatement(query);
        pre.setInt(1, newStatus);
        pre.setInt(2, orderId);
        return pre.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}



    public List<Order> searchOrders(String searchQuery) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM Orders WHERE "
                + "FullName LIKE ? OR "
                + "PhoneNumber LIKE ?  Order BY Status ASC";
        try {
            PreparedStatement pre = conn.prepareStatement(query);

            pre.setString(1, "%" + searchQuery + "%");
            pre.setString(2, "%" + searchQuery + "%");

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getString("FullName"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address"),
                        rs.getInt("TotalAmount"),
                        rs.getString("OrderedDate"),
                        rs.getInt("Status")
                );
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
        public int updateOrder(int orderID, int status) {
        int count = 0;
        String query = "Update Orders SET Orders.Status= ? WHERE Orders.OrderID=?";
          String query2 = "UPDATE Orders\n"
                + "SET Status = ?,\n"
                + "    DeliveredDate = DATEADD(HOUR, 7, GETUTCDATE())\n"
                + "WHERE OrderID = ?;";
        try {
            if(status == 4){
             PreparedStatement pre = conn.prepareStatement(query2);
            pre.setInt(1, status);
            pre.setInt(2, orderID);
                    
             count = pre.executeUpdate();
            }else{
            PreparedStatement pre = conn.prepareStatement(query);
            pre.setInt(1, status);
            pre.setInt(2, orderID);
                    
             count = pre.executeUpdate();
                    }
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return count;
    }

//
//    public Customer getCustomerByOrderId(int id) {
//        String sql = "SELECT c.CustomerID, c.FullName, c.PhoneNumber, c.Email, "
//                + "c.IsBlock, c.IsDeleted FROM customers c "
//                + "JOIN orders o ON c.CustomerID = o.CustomerID WHERE o.OrderID = ?";
//        try ( PreparedStatement ps = connector.prepareStatement(sql)) {
//            ps.setInt(1, id);
//            try ( ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    return new Customer(
//                            rs.getInt("CustomerID"),
//                            rs.getString("FullName"),
//                            null,
//                            null,
//                            null,
//                            rs.getString("PhoneNumber"),
//                            rs.getString("Email"),
//                            null,
//                            rs.getInt("IsBlock"),
//                            rs.getInt("IsDeleted"),
//                            null
//                    );
//                }
//            }
//        } catch (SQLException e) {
//            System.err.println(e.getMessage());
//        } catch (Exception e) {
//            System.err.println(e.getMessage());
//        }
//
//        return null; // Không tìm thấy khách hàng
//    }
//
//    public List<Order> getOrdersToDelete(int month) {
//        List<Order> list = new ArrayList<>();
//        String sql = "SELECT * FROM Orders "
//                + "WHERE [Status] = '5' "
//                + "AND OrderedDate < DATEADD(MONTH, -?, GETUTCDATE())";
//        try {
//            PreparedStatement pre = conn.prepareStatement(sql);
//            pre.setInt(1, month);
//            ResultSet rs = pre.executeQuery();
//            while (rs.next()) {
//                Order o = new Order(
//                        rs.getInt("OrderID"),
//                        rs.getInt("CustomerID"),
//                        rs.getString("FullName"),
//                        rs.getString("PhoneNumber"),
//                        rs.getString("Address"),
//                        rs.getInt("TotalAmount"),
//                        rs.getString("OrderedDate"),
//                        rs.getInt("Status")
//                );
//                list.add(o);
//            }
//        } catch (SQLException e) {
//            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
//        }
//        return list;
//    }
//
//    public static void main(String[] args) {
//        OrderDAO o = new OrderDAO();
////        o.addOrderDetail(1, 1, 3, 34000000);
////        List<Order> list = o.getAllOrderOfCustomer(1);
////        for (Order order : list) {
////            System.out.println(order.getAddress());
////        }
//        Order od = new Order(13, "Nguyen The Vinh", "0335150884", "fjds, fds fds, sdfhds, dshfdd", 20000000, 30000);
//        
//    }
}
