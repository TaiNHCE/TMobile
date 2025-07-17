package controller;

import dao.PromotionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/AddPromotionServlet")
public class AddPromotionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String targetType = request.getParameter("targetType");
            String targetIdStr = request.getParameter("targetId");
            String discountStr = request.getParameter("discount");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String name = request.getParameter("name");

            if (targetType == null || targetType.isEmpty() || !targetType.matches("BRAND|CATEGORY|PRODUCT")) {
                request.setAttribute("error", "Invalid target type!");
                request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
                return;
            }

            int targetId;
            try {
                targetId = Integer.parseInt(targetIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid target ID!");
                request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
                return;
            }

            int discount;
            try {
                discount = Integer.parseInt(discountStr);
                if (discount < 1 || discount > 100) {
                    request.setAttribute("error", "Discount percentage must be between 1 and 100!");
                    request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid discount percentage!");
                request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
                return;
            }

            Timestamp startDate, endDate;
            try {
                startDate = Timestamp.valueOf(startDateStr.replace("T", " ") + ":00");
                endDate = Timestamp.valueOf(endDateStr.replace("T", " ") + ":00");
                if (!endDate.after(startDate)) {
                    request.setAttribute("error", "End date must be after start date!");
                    request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
                    return;
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Invalid date format!");
                request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
                return;
            }

            PromotionDAO promotionDAO = new PromotionDAO();
            if (promotionDAO.isProductAlreadyInActivePromotion(targetId, targetType)) {
                request.setAttribute("error", "This target is already in an active promotion!");
                request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
                return;
            }

            if (promotionDAO.addPromotion(targetType, targetId, discount, startDate, endDate, name)) {
                response.sendRedirect("AdminProduct?successpro=1");
            } else {
                request.setAttribute("error", "Failed to add promotion!");
                request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/setPromotion/setPromotion.jsp").forward(request, response);
        }
    }
}