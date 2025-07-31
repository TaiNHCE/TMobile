package controller;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/UpdateCart"})
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        try {
            String action = request.getParameter("action");
            String accountIdRaw = request.getParameter("accountId");
            String cartItemIdRaw = request.getParameter("cartItemId");
            String quantityRaw = request.getParameter("quantity");

            // Debug input
            System.out.println("Received action: " + action);
            System.out.println("Received accountId: " + accountIdRaw);
            System.out.println("Received cartItemId: " + cartItemIdRaw);
            System.out.println("Received quantity: " + quantityRaw);

            if (action == null || cartItemIdRaw == null || quantityRaw == null) {
                response.getWriter().write("error:missing_parameters");
                return;
            }

            int cartItemId = Integer.parseInt(cartItemIdRaw);
            int quantity = Integer.parseInt(quantityRaw);

            // Ensure quantity is not negative
            if (quantity < 1) {
                quantity = 1;
            }

            // Update quantity in database
            CartDAO cartDAO = new CartDAO();
            boolean updated = cartDAO.updateCartItemQuantity(cartItemId, quantity);

            // Debug update result
            System.out.println("Update result for cartItemId " + cartItemId + ": " + updated + ", new quantity: " + quantity);

            if (updated) {
                response.getWriter().print("success");
            } else {
                response.getWriter().print("error:update_failed");
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid input: " + e.getMessage());
            response.getWriter().write("error");
        } catch (Exception e) {
            System.err.println("Server error: " + e.getMessage());
            response.getWriter().write("error");
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles cart item quantity updates";
    }
}