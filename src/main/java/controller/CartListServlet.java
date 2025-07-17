/*
 * Click nbfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.CartItem;
import model.ProductVariant;

/**
 * Servlet for handling cart operations
 */
@WebServlet(name = "CartListServlet", urlPatterns = {"/CartList"})
public class CartListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CartDAO dao = new CartDAO();
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        if (action == null) {
            action = "list";
        }

        try {
            int accountId = (user != null) ? user.getAccountID() : 0;

            if (action.equalsIgnoreCase("list")) {
                List<CartItem> cartItems = dao.getCartItemsByAccountId(accountId);

                request.setAttribute("cartItems", cartItems);
                if (cartItems.isEmpty()) {
                    request.setAttribute("message", "No items found in the cart.");
                }
                request.getRequestDispatcher("/WEB-INF/View/customer/cartManagement/viewCart.jsp").forward(request, response);
            }
            if (action.equalsIgnoreCase("shop")) {
                request.getRequestDispatcher("/WEB-INF/View/customer/homePage/homePage.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid Account ID.");
            request.getRequestDispatcher("/WEB-INF/View/customer/cartManagement/viewCart.jsp").forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CartDAO cartDAO = new CartDAO();
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String[] selectedItems = request.getParameterValues("selectedItems");

                // Check if the cart item is selected
                boolean isSelected = false;
                if (selectedItems != null) {
                    for (String selectedItem : selectedItems) {
                        if (Integer.parseInt(selectedItem) == cartItemId) {
                            isSelected = true;
                            break;
                        }
                    }
                }

                if (!isSelected) {
                    session.setAttribute("message", "Please select the item to update quantity!");
                    response.sendRedirect("CartList?accountId=" + request.getParameter("accountId"));
                    return;
                }

                // Check stock availability
                CartItem cartItem = cartDAO.getCartItemById(cartItemId);
                int stock = cartItem.getVariant() != null ? cartItem.getVariant().getQuantity() : cartItem.getProduct().getStock();
                if (quantity > stock) {
                    session.setAttribute("message", "Requested quantity exceeds available stock!");
                } else {
                    boolean success = cartDAO.updateCartItemQuantity(cartItemId, quantity);
                    if (success) {
                        // Update stock
                        if (cartItem.getVariant() != null) {
                            cartDAO.updateVariantStock(cartItem.getVariant().getVariantId(), stock - quantity);
                        } else {
                            cartDAO.updateProductStock(cartItem.getProductID(), stock - quantity);
                        }
                        session.setAttribute("message", "Quantity updated successfully!");
                    } else {
                        session.setAttribute("message", "Error updating quantity!");
                    }
                }
            } else if ("updateVariant".equals(action)) {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                String variantIdStr = request.getParameter("variantId");
                Integer variantId = variantIdStr.equals("0") ? null : Integer.parseInt(variantIdStr);
                boolean success = cartDAO.updateCartItemVariant(cartItemId, variantId);
                session.setAttribute("message", success ? "Variant updated successfully!" : "Error updating variant!");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("message", "Invalid input.");
        }

        response.sendRedirect("CartList?accountId=" + request.getParameter("accountId"));
    }

    @Override
    public String getServletInfo() {
        return "Servlet for listing cart items by AccountID";
    }
}