/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import utils.EmailService;
import utils.OTPManager;

/**
 *
 * @author pc
 */
@WebServlet(name = "VerifyOTPServlet", urlPatterns = {"/Verify"})
public class VerifyOTPServlet extends HttpServlet {

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
            out.println("<title>Servlet VerifyOTPServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyOTPServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("WEB-INF/View/account/verify.jsp").forward(request, response);
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
        AccountDAO dao = new AccountDAO();
        int enteredOtp = Integer.parseInt(request.getParameter("otp"));
        HttpSession session = request.getSession();
        OTPManager otpManager = (OTPManager) session.getAttribute("otpManager");

        String email = (String) session.getAttribute("tempEmail");
        String password = (String) session.getAttribute("tempPassword");
        String passwordHash = dao.hashMD5(password);
        if (EmailService.verifyOTP(email, enteredOtp)) {
            // Tạo tài khoản mới
            Account acc = new Account();
            acc.setEmail(email);
            acc.setPasswordHash(passwordHash); // nhớ mã hóa nếu cần
            acc.setRoleID(3); // mặc định người dùng thường
            acc.setIsActive(true); // nếu có cột này

            boolean success = dao.addNewAccount(acc);

            if (success) {
                // Xóa session tạm
                session.removeAttribute("otp");
                session.removeAttribute("tempEmail");
                session.removeAttribute("tempPassword");

                // Gửi email thông báo tạo thành công
                utils.EmailService.sendSuccessEmail(email);
                response.sendRedirect("Login");
            } else {
                request.setAttribute("error", "Account creation failed.");
                request.getRequestDispatcher("WEB-INF/View/account/verify.jsp").forward(request, response);
            }
        } else if (otpManager == null || otpManager.isExpired()) {
            request.setAttribute("error", "Your OTP has expired. Please register again.");
            request.getRequestDispatcher("WEB-INF/View/account/verify.jsp").forward(request, response);
            return;
        } else {
            request.setAttribute("error", "Incorrect OTP.");
            request.getRequestDispatcher("WEB-INF/View/account/verify.jsp").forward(request, response);
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
