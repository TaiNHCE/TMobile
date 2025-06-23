/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import dao.BrandDAO;
import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import model.Brand;
import model.Category;
import model.Product;

/**
 *
 * @author HP - Gia Khiêm
 */
@MultipartConfig
@WebServlet(name = "StaffUpdateInfoServlet", urlPatterns = {"/StaffUpdateInfo"})
public class StaffUpdateInfoServlet extends HttpServlet {

    private Cloudinary cloudinary;

    @Override
    public void init() {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dgnyskpc3",
                "api_key", "398517693378845",
                "api_secret", "ho0bvkCgpHDBFoUW3M9bG8apAKk",
                "secure", true
        ));
    }

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
            out.println("<title>Servlet StaffUpdateInfoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffUpdateInfoServlet at " + request.getContextPath() + "</h1>");
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

        String productIdString = request.getParameter("productId");

        int productId = ((productIdString != null) ? Integer.parseInt(productIdString) : -1);

        if (productId != -1) {

            ProductDAO proDao = new ProductDAO();
            CategoryDAO cateDao = new CategoryDAO();
            BrandDAO brandDao = new BrandDAO();

            List<Category> categoryList = cateDao.getAllCategory();
            List<Brand> brandList = brandDao.getAllBrand();
            Product product = proDao.getProductByID(productId);

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("brandList", brandList);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/View/staff/productManagement/updateProduct/updateInfo/updateInfo.jsp").forward(request, response);
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

        ProductDAO proDAO = new ProductDAO();

        int id = Integer.parseInt(request.getParameter("id"));
        String productName = request.getParameter("productName");

        String priceFormatted = request.getParameter("price");
        priceFormatted = priceFormatted.replace(".", "") // bỏ dấu chấm ngăn cách hàng nghìn
                .replace("₫", "") // bỏ ký tự tiền
                .trim();
        BigDecimal price = new BigDecimal(priceFormatted);

        String stockStr = request.getParameter("stock");
        int stock = 0; // mặc định nếu rỗng

        if (stockStr != null && !stockStr.trim().isEmpty()) {
            try {
                stock = Integer.parseInt(stockStr.trim());
            } catch (NumberFormatException e) {
                e.printStackTrace(); // hoặc log lỗi, thông báo người dùng
            }
        }

        int Category = Integer.parseInt(request.getParameter("category"));
        int Brand = Integer.parseInt(request.getParameter("brand"));

        boolean isFeatured = request.getParameter("isFeatured") != null;
        boolean isBestSeller = request.getParameter("isBestSeller") != null;
        boolean isNew = request.getParameter("isNew") != null;
        boolean isActive = request.getParameter("isActive") != null;

//        <====================================== Xử lý ảnh ===========================================>
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        Part part = request.getPart("file");

            String imageUrl = "";
            if (part.getName().equals("file") && part.getSize() > 0) {

                InputStream is = part.getInputStream();

                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                byte[] data = new byte[1024];
                int bytesRead;
                while ((bytesRead = is.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, bytesRead);
                }
                byte[] fileBytes = buffer.toByteArray();

                Map uploadResult = cloudinary.uploader().upload(fileBytes,
                        ObjectUtils.asMap("resource_type", "auto"));

                imageUrl = (String) uploadResult.get("secure_url");
            }
        
//        <====================================== Xử lý anh ===========================================>

        boolean res = proDAO.updateProductInfo(id, productName, price, stock, Category, Brand, isFeatured, isBestSeller, isNew, isActive,imageUrl);

        if (res) {
            response.sendRedirect("StaffUpdateInfo?productId=" + id + "&success=1");
        } else {
            response.sendRedirect("StaffUpdateInfo?productId=" + id + "&error=1");
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
