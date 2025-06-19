package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RejectProductServlet", urlPatterns = {"/RejectProductServlet"})
public class RejectProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng từ view-product-detail.jsp đến rejectProduct.jsp
        String productId = request.getParameter("productId");
        if (productId != null) {
            request.setAttribute("productId", productId);
            request.getRequestDispatcher("/WEB-INF/View/admin/productManagement/rejectProduct.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("message", "Invalid product ID.");
            response.sendRedirect("ProductList?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý form từ rejectProduct.jsp
        String productIdRaw = request.getParameter("productId");
        String title = request.getParameter("title");
        String message = request.getParameter("message");

        try {
            int productId = Integer.parseInt(productIdRaw);
            ProductDAO dao = new ProductDAO();

            // Từ chối sản phẩm
            boolean updated = dao.rejectProduct(productId);
            if (updated) {
                // Lưu thông báo
                dao.saveNotification(title, message, productId);
                request.getSession().setAttribute("message", "Product rejected successfully.");
            } else {
                request.getSession().setAttribute("message", "Failed to reject product.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "Invalid product ID.");
        } catch (Exception e) {
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
        }

        // Chuyển hướng về danh sách sản phẩm
        response.sendRedirect("ProductList?action=list");
    }
}