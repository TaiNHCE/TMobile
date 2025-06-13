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
import java.time.LocalDateTime;
import model.Suppliers;

/**
 *
 * @author HP
 */
@WebServlet(name = "CreateSupplierServlet", urlPatterns = {"/CreateSupplier"})
public class CreateSupplierServlet extends HttpServlet {

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
            out.println("<title>Servlet CreateSupplierServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateSupplierServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/WEB-INF/View/admin/supplierManagement/createSupplier.jsp").forward(request, response);
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
        String taxId = request.getParameter("taxId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        int active = Integer.parseInt(request.getParameter("activate"));
        int deleted = 0; 

        String errorMsg = null;
        if (taxId == null || taxId.isEmpty() || name == null || name.isEmpty()) {
            errorMsg = "Tax ID and Company Name is not null!";
        }

        SupplierDAO dao = new SupplierDAO();

        
        if (dao.isSupplierExist(taxId, email)) {
            errorMsg = "Tax ID or Email already exists!";
        }

        if (errorMsg != null) {
            request.setAttribute("errorMsg", errorMsg);
            request.getRequestDispatcher("/WEB-INF/View/admin/supplierManagement/createSupplier.jsp").forward(request, response);
            return;
        }

        LocalDateTime now = LocalDateTime.now();
        Suppliers supplier = new Suppliers(0, taxId, name, email, phoneNumber, address, now, now, deleted, active);

        int result = dao.createSupplier(supplier);

        if (result > 0) {
            response.sendRedirect("ViewSupplier");
        } else {
            request.setAttribute("errorMsg", "Add supplier failed!");
            request.getRequestDispatcher("/WEB-INF/View/admin/supplierManagement/createSupplier.jsp").forward(request, response);
        }
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
