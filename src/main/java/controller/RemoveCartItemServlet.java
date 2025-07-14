/*
 * Click nbfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author USER
 */
@WebServlet(name = "RemoveCartItemServlet", urlPatterns = {"/RemoveCartItem"})
public class RemoveCartItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("remove".equals(action)) {
            try {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                CartDAO cartDAO = new CartDAO();
                boolean isSuccess = cartDAO.deleteCartItem(cartItemId);

                if (isSuccess) {
                    session.setAttribute("message", "Item removed successfully!");
                } else {
                    session.setAttribute("message", "Failed to remove item.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("message", "Invalid cart item ID.");
            }
            request.getRequestDispatcher("/WEB-INF/View/customer/cartManagement/deletesuccess.jsp").forward(request, response);

        } else {
            session.setAttribute("message", "Invalid action.");
            response.sendRedirect("ViewCartServlet");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("ViewCartServlet");
    }

    @Override
    public String getServletInfo() {
        return "Servlet to remove items from cart";
    }
}
