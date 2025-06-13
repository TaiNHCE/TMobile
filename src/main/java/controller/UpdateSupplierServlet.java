/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Suppliers;

/**
 *
 * @author HP
 */
@WebServlet(name = "UpdateSupplierServlet", urlPatterns = {"/UpdateSupplier"})
public class UpdateSupplierServlet extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateSupplierServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateSupplierServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
    String sid = request.getParameter("id");
    if (sid == null) {
        response.sendRedirect("ViewSupplier"); // hoặc báo lỗi phù hợp
        return;
    }

    try {
        int supplierID = Integer.parseInt(sid);
        SupplierDAO dao = new SupplierDAO();
        Suppliers supplier = dao.getSupplierById(supplierID);

        if (supplier == null) {
            request.setAttribute("errorMessage", "Supplier not found!");
        }
        request.setAttribute("supplier", supplier);
        request.getRequestDispatcher("updateSupplier.jsp").forward(request, response);
    } catch (NumberFormatException ex) {
        request.setAttribute("errorMessage", "Invalid supplier ID!");
        request.getRequestDispatcher("updateSupplier.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        int supplierID = Integer.parseInt(request.getParameter("supplierID"));
        String taxId = request.getParameter("taxId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        int activate = Integer.parseInt(request.getParameter("activate"));

        SupplierDAO dao = new SupplierDAO();
        Suppliers supplier = dao.getSupplierById(supplierID);

        if (supplier == null) {
            request.setAttribute("errorMessage", "Supplier not found!");
            request.getRequestDispatcher("updateSupplier.jsp").forward(request, response);
            return;
        }

        supplier.setTaxId(taxId);
        supplier.setName(name);
        supplier.setEmail(email);
        supplier.setPhoneNumber(phoneNumber);
        supplier.setAddress(address);
        supplier.setActivate(activate);
        supplier.setLastModify(java.time.LocalDateTime.now());

        boolean success = dao.updateSupplier(supplier);
        if (success) {
            request.setAttribute("successMessage", "Supplier updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to update supplier. Please try again.");
        }
        request.setAttribute("supplier", supplier);
        request.getRequestDispatcher("updateSupplier.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
