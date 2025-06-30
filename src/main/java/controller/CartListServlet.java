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
import model.CartItem;
import model.ProductVariant;

/**
 *
 * @author pc
 */
@WebServlet(name = "CartListServlet", urlPatterns = {"/CartList"})
public class CartListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();
        String action = request.getParameter("action");
        String accountIdRaw = request.getParameter("accountId");

        if (action == null) {
            action = "list";
        }

        try {
            int accountId = Integer.parseInt(accountIdRaw);
            HttpSession session = request.getSession();

            if (action.equalsIgnoreCase("list")) {
                List<CartItem> cartItems = cartDAO.getCartItemsByAccountId(accountId);
                List<ProductVariant> allVariants = productDAO.getAllVariantsForCartItems(cartItems);
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("allVariants", allVariants);
                if (cartItems.isEmpty()) {
                    session.setAttribute("message", "No items found in the cart.");
                }
                request.getRequestDispatcher("/WEB-INF/View/customer/cartManagement/viewCart.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("shop")) {
                // Lưu accountId vào session để sử dụng trên homePage.jsp
                session.setAttribute("accountId", accountId);
                // Chuyển hướng đến homePage.jsp
                request.getRequestDispatcher("/WEB-INF/View/customer/homePage/homePage.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
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
                boolean success = cartDAO.updateCartItemQuantity(cartItemId, quantity);
                session.setAttribute("message", success ? "Số lượng đã được cập nhật!" : "Lỗi khi cập nhật số lượng!");
            } else if ("updateVariant".equals(action)) {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                String variantIdStr = request.getParameter("variantId");
                Integer variantId = variantIdStr.equals("0") ? null : Integer.parseInt(variantIdStr);
                boolean success = cartDAO.updateCartItemVariant(cartItemId, variantId);
                session.setAttribute("message", success ? "Màu sắc đã được cập nhật!" : "Lỗi khi cập nhật màu sắc!");
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