/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;
import model.Product;

/**
 *
 * @author pc
 */
@WebServlet(name = "CartListServlet", urlPatterns = {"/CartList"})
public class CartListServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Không cần thiết trong trường hợp này vì sẽ sử dụng JSP
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CartDAO dao = new CartDAO();
        String action = request.getParameter("action");
        String accountIdRaw = request.getParameter("accountId");

        if (action == null) {
            action = "list";
        }

        try {
            int accountId = Integer.parseInt(accountIdRaw);

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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for listing cart items by AccountID";
    }
}
