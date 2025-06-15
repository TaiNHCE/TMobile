package controller;

import dao.VoucherDAO;
import model.Voucher;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "VoucherServlet", urlPatterns = {"/Voucher"})
public class VoucherServlet extends HttpServlet {

    private VoucherDAO voucherDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        voucherDAO = new VoucherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                request.getRequestDispatcher("/WEB-INF/View/admin/voucherManagement/voucherForm.jsp").forward(request, response);
                break;

            case "detail":
                showVoucherDetail(request, response);
                break;

            case "edit":
                try {
                    String idRaw = request.getParameter("id");
                    if (idRaw == null || idRaw.isEmpty()) {
                        throw new IllegalArgumentException("Missing voucher ID.");
                    }
                    int id = Integer.parseInt(idRaw);
                    Voucher voucher = voucherDAO.getVoucherById(id);
                    request.setAttribute("voucher", voucher);
                    request.getRequestDispatcher("/WEB-INF/View/admin/voucherManagement/voucherForm.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("Voucher?error=InvalidID");
                }
                break;

            case "delete":
                try {
                    String idRaw = request.getParameter("id");
                    if (idRaw == null || idRaw.isEmpty()) {
                        throw new IllegalArgumentException("Missing voucher ID.");
                    }
                    int delId = Integer.parseInt(idRaw);
                    voucherDAO.deleteVoucher(delId);
                    response.sendRedirect("Voucher");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("Voucher?error=DeleteFailed");
                }
                break;

            default:
                String keyword = request.getParameter("searchCode");
                List<Voucher> list;

                if (keyword != null && !keyword.trim().isEmpty()) {
                    list = voucherDAO.searchByCode(keyword.trim());
                } else {
                    list = voucherDAO.getAllVouchers();
                }

                request.setAttribute("voucherList", list);
                request.getRequestDispatcher("/WEB-INF/View/admin/voucherManagement/voucherList.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // Parse data
            int id = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id")) : 0;

            String code = request.getParameter("code");
            if (code == null || code.trim().isEmpty()) {
                throw new IllegalArgumentException("Voucher code cannot be empty.");
            }

            int discount = Integer.parseInt(request.getParameter("discountPercent"));
            Date expiry = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("expiryDate"));
            double minAmount = Double.parseDouble(request.getParameter("minOrderAmount"));
            double maxDiscount = Double.parseDouble(request.getParameter("maxDiscountAmount"));
            int usageLimit = Integer.parseInt(request.getParameter("usageLimit"));
            int usedCount = Integer.parseInt(request.getParameter("usedCount"));
            boolean isActive = request.getParameter("isActive") != null;
            Date createdAt = new Date();
            String description = request.getParameter("description");

            // Validation
            if (voucherDAO.isCodeDuplicate(code, id)) {
                throw new IllegalArgumentException("Voucher code already exists. Please choose another.");
            }

            if (discount < 1 || discount > 100) {
                throw new IllegalArgumentException("Discount percent must be between 1 and 100.");
            }
            if (minAmount < 0 || maxDiscount < 0) {
                throw new IllegalArgumentException("Amounts cannot be negative.");
            }
            if (usageLimit < 1) {
                throw new IllegalArgumentException("Usage limit must be at least 1.");
            }
            if (usedCount < 0 || usedCount > usageLimit) {
                throw new IllegalArgumentException("Used count is not valid.");
            }
            if (expiry.before(new Date())) {
                throw new IllegalArgumentException("Expiry date must be today or later.");
            }

            // Create Voucher object
            Voucher v = new Voucher(id, code, discount, expiry, minAmount, maxDiscount,
                    usageLimit, usedCount, isActive, createdAt, description);

            // Insert or update
            if (id == 0) {
                voucherDAO.addVoucher(v);
            } else {
                voucherDAO.updateVoucher(v);
            }

            response.sendRedirect("Voucher");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error occurred: " + e.getMessage());

            try {
                // Re-populate form fields
                int id = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                        ? Integer.parseInt(request.getParameter("id")) : 0;
                String code = request.getParameter("code");
                int discount = Integer.parseInt(request.getParameter("discountPercent"));
                Date expiry = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("expiryDate"));
                double minAmount = Double.parseDouble(request.getParameter("minOrderAmount"));
                double maxDiscount = Double.parseDouble(request.getParameter("maxDiscountAmount"));
                int usageLimit = Integer.parseInt(request.getParameter("usageLimit"));
                int usedCount = Integer.parseInt(request.getParameter("usedCount"));
                boolean isActive = request.getParameter("isActive") != null;
                Date createdAt = new Date();
                String description = request.getParameter("description");

                Voucher retryVoucher = new Voucher(id, code, discount, expiry, minAmount,
                        maxDiscount, usageLimit, usedCount, isActive, createdAt, description);

                request.setAttribute("voucher", retryVoucher);
            } catch (Exception ex) {
                request.setAttribute("voucher", null);
            }

            request.getRequestDispatcher("/WEB-INF/View/admin/voucherManagement/voucherForm.jsp").forward(request, response);
        }
    }

    private void showVoucherDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idRaw = request.getParameter("id");
            if (idRaw == null || idRaw.isEmpty()) {
                throw new IllegalArgumentException("Missing voucher ID.");
            }
            int id = Integer.parseInt(idRaw);

            Voucher voucher = voucherDAO.getVoucherById(id);
            if (voucher != null) {
                request.setAttribute("voucher", voucher);
                request.getRequestDispatcher("/WEB-INF/View/admin/voucherManagement/voucherDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("Voucher?error=VoucherNotFound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Voucher?error=InvalidVoucherDetail");
        }
    }
}
