package controller;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "RemoveCartItemServlet", urlPatterns = {"/RemoveCartItem"})
public class RemoveCartItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String accountIdRaw = request.getParameter("accountId"); // Lấy accountId từ request

        if ("remove".equals(action)) {
            try {
                int cartItemId = Integer.parseInt(request.getParameter("id"));
                CartDAO cartDAO = new CartDAO();
                boolean isSuccess = cartDAO.deleteCartItem(cartItemId);

                if (isSuccess) {
                    response.sendRedirect("CartList?accountId=" + accountIdRaw + "&successdelete=1");
                } else {
                    response.sendRedirect("CartList?accountId=" + accountIdRaw + "&errordelete=1");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("message", "Invalid cart item ID.");
                response.sendRedirect("CartList?accountId=" + accountIdRaw);
            }
        } else {
            session.setAttribute("message", "Invalid action.");
            response.sendRedirect("CartList");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to remove items from cart";
    }
}
