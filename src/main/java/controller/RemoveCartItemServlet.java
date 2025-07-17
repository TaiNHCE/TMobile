package controller;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import model.Account;

@WebServlet(name = "RemoveCartItemServlet", urlPatterns = {"/RemoveCartItem"})
public class RemoveCartItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        int accountId = (user != null) ? user.getAccountID() : 0;

        if ("deleteMultiple".equals(action)) {
            try {
                String selectedItems = request.getParameter("selectedItems");
                if (selectedItems == null || selectedItems.isEmpty()) {
                    session.setAttribute("message", "No items selected for deletion.");
                    response.sendRedirect("CartList?accountId=" + accountId);
                    return;
                }

                List<String> itemIds = Arrays.asList(selectedItems.split(","));
                CartDAO cartDAO = new CartDAO();
                boolean isSuccess = cartDAO.deleteMultipleCartItems(itemIds);

                if (isSuccess) {
                    session.setAttribute("message", "Items deleted successfully.");
                    response.sendRedirect("CartList?accountId=" + accountId);
                } else {
                    session.setAttribute("message", "Error deleting items.");
                    response.sendRedirect("CartList?accountId=" + accountId);
                }
            } catch (Exception e) {
                session.setAttribute("message", "An error occurred while deleting items.");
                response.sendRedirect("CartList?accountId=" + accountId);
            }
        } else {
            session.setAttribute("message", "Invalid action.");
            response.sendRedirect("CartList?accountId=" + accountId);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        int accountId = (user != null) ? user.getAccountID() : 0;

        if ("remove".equals(action)) {
            try {
                int cartItemId = Integer.parseInt(request.getParameter("id"));
                CartDAO cartDAO = new CartDAO();
                boolean isSuccess = cartDAO.deleteCartItem(cartItemId);

                if (isSuccess) {
                    session.setAttribute("message", "Item deleted successfully.");
                    response.sendRedirect("CartList?accountId=" + accountId);
                } else {
                    session.setAttribute("message", "Error deleting item.");
                    response.sendRedirect("CartList?accountId=" + accountId);
                }
            } catch (NumberFormatException e) {
                session.setAttribute("message", "Invalid cart item ID.");
                response.sendRedirect("CartList?accountId=" + accountId);
            }
        } else {
            session.setAttribute("message", "Invalid action.");
            response.sendRedirect("CartList?accountId=" + accountId);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to remove items from cart";
    }
}