/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbproject/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StaffDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
@WebServlet(name = "DeleteStaffServlet", urlPatterns = {"/DeleteStaffServlet"})
public class DeleteStaffServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method for deleting a staff member.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int staffId = Integer.parseInt(request.getParameter("id"));
                StaffDAO staffDAO = new StaffDAO();
                boolean isSuccess = staffDAO.deleteStaffById(staffId);

                if (isSuccess) {
                    // Redirect to deleteSuccess.jsp on successful deletion
                    request.getRequestDispatcher("/WEB-INF/View/admin/staffManagement/deleteSuccess.jsp").forward(request, response);

                } else {
                    // Set error message and forward to StaffList
                    request.setAttribute("message", "Failed to delete staff.");
                    request.getRequestDispatcher("StaffList").forward(request, response);
                }
            } catch (NumberFormatException e) {
                // Handle invalid staff ID
                request.setAttribute("message", "Invalid staff ID.");
                request.getRequestDispatcher("StaffList").forward(request, response);
            }
        } else {
            // Redirect to StaffList for invalid action
            response.sendRedirect("StaffList");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method (not used for deletion).
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("StaffList");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Handles staff deletion requests";
    }
}
