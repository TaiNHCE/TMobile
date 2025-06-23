/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ImportStockDAO;
import dao.ImportStockDetailDAO;
import dao.ProductDAO;
import dao.StaffDAO;
import dao.SupplierDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.ImportStock;
import model.ImportStockDetail;
import model.Product;
import model.Staff;
import model.Suppliers;

/**
 *
 * @author
 */
@WebServlet(name = "ImportStockServlet", urlPatterns = {"/ImportStock"})
public class ImportStockServlet extends HttpServlet {

    SupplierDAO sd = new SupplierDAO();
    ProductDAO pd = new ProductDAO();
    ImportStockDAO ioD = new ImportStockDAO();
    ImportStockDetailDAO iodD = new ImportStockDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String status = request.getParameter("status");
        if (status != null && status.equals("cancel")) {
            session.removeAttribute("selectedProducts");
            session.removeAttribute("supplier");
            session.removeAttribute("products"); // <--- THÊM DÒNG NÀY!
            session.setAttribute("success", "Nhập kho thành công!");
            response.sendRedirect("ImportStock");

            return;
        }

        // Đảm bảo luôn set danh sách suppliers cho JSP
        List<Suppliers> suppliers = sd.getAllSuppliers(); // hoặc sd.getAllActiveSuppliers()
        request.setAttribute("suppliers", suppliers); // cho modal
        session.setAttribute("suppliers", suppliers);

        // Đảm bảo luôn set danh sách products cho JSP
        ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("products");
        if (products == null) {
            products = (ArrayList<Product>) pd.getProductList();
            session.setAttribute("products", products);
        }

        request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStock.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        ArrayList<ImportStockDetail> detailList = (ArrayList<ImportStockDetail>) session.getAttribute("selectedProducts");
        if (detailList == null) {
            detailList = new ArrayList<>();
        }

        ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("products");
        if (products == null) {
            products = (ArrayList<Product>) pd.getProductList();
            session.setAttribute("products", products);
        }

        // --- Xử lý chọn nhà cung cấp ---
        String supplierIdRaw = request.getParameter("supplierId");
        if (supplierIdRaw != null && !supplierIdRaw.trim().isEmpty()) {
            try {
                int supplierId = Integer.parseInt(supplierIdRaw.trim());
                Suppliers s = sd.getSupplierById(supplierId);
                session.setAttribute("supplier", s);
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Mã nhà cung cấp không hợp lệ.");
            }
            response.sendRedirect("ImportStock");
            return;
        }

        // --- Xử lý thêm sản phẩm ---
        String productIdRaw = request.getParameter("productId");
        String quantityRaw = request.getParameter("importQuantity");
        String priceRaw = request.getParameter("unitPrice");

        if (productIdRaw != null && quantityRaw != null && priceRaw != null
                && !productIdRaw.trim().isEmpty() && !quantityRaw.trim().isEmpty() && !priceRaw.trim().isEmpty()) {
            try {
                int pId = Integer.parseInt(productIdRaw.trim());
                int quantity = Integer.parseInt(quantityRaw.trim());
                long price = Long.parseLong(priceRaw.trim());

                Product p = pd.getProductByID(pId);
                ImportStockDetail d = new ImportStockDetail();
                d.setProduct(p);
                d.setQuantity(quantity);
                d.setUnitPrice(price);

                boolean isContained = false;
                for (ImportStockDetail proDet : detailList) {
                    if (proDet.getProduct().getProductId() == pId) {
                        isContained = true;
                        break;
                    }
                }

                if (!isContained) {
                    detailList.add(d);

                    int deleteIndex = -1;
                    for (int i = 0; i < products.size(); ++i) {
                        if (products.get(i).getProductId() == pId) {
                            deleteIndex = i;
                            break;
                        }
                    }
                    if (deleteIndex != -1) {
                        products.remove(deleteIndex);
                    }
                } else {
                    session.setAttribute("error", "Sản phẩm đã được chọn.");
                }

                session.setAttribute("selectedProducts", detailList);
                session.setAttribute("products", products);

                request.setAttribute("suppliers", sd.getAllSuppliers());
                request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStock.jsp").forward(request, response);
                return;

            } catch (NumberFormatException e) {
                session.setAttribute("error", "Giá trị nhập không hợp lệ.");
                response.sendRedirect("ImportStock");
                return;
            }
        }

        // --- Xử lý hành động sửa hoặc xóa ---
        String action = request.getParameter("action");
        if (action != null) {
            try {
                int pId = Integer.parseInt(request.getParameter("productEditedId"));

                if ("delete".equals(action)) {
                    for (int i = 0; i < detailList.size(); i++) {
                        if (detailList.get(i).getProduct().getProductId() == pId) {
                            detailList.remove(i);
                            Product temp = pd.getProductByID(pId);
                            products.add(temp);
                            break;
                        }
                    }
                } else if ("save".equals(action)) {
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    long price = Long.parseLong(request.getParameter("price"));

                    for (int i = 0; i < detailList.size(); i++) {
                        if (detailList.get(i).getProduct().getProductId() == pId) {
                            detailList.get(i).setQuantity(quantity);
                            detailList.get(i).setUnitPrice(price);
                            break;
                        }
                    }
                }

                // Sort lại product list theo id tăng dần
                for (int i = 0; i < products.size() - 1; i++) {
                    for (int j = i + 1; j < products.size(); j++) {
                        if (products.get(i).getProductId() > products.get(j).getProductId()) {
                            Product temp = products.get(i);
                            products.set(i, products.get(j));
                            products.set(j, temp);
                        }
                    }
                }

                session.setAttribute("selectedProducts", detailList);
                session.setAttribute("products", products);

                request.setAttribute("suppliers", sd.getAllSuppliers());
                request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStock.jsp").forward(request, response);
                return;

            } catch (NumberFormatException e) {
                session.setAttribute("error", "Không thể xử lý dữ liệu sản phẩm.");
                response.sendRedirect("ImportStock");
                return;
            }
        }

        // --- Xử lý khi nhấn nút Submit nhập kho ---
        Suppliers supTest = (Suppliers) session.getAttribute("supplier");
        ArrayList<ImportStockDetail> listTest = (ArrayList<ImportStockDetail>) session.getAttribute("selectedProducts");

        if (supTest != null && listTest != null && !listTest.isEmpty()) {
            long sum = 0L;
            for (ImportStockDetail proDet : listTest) {
                sum += proDet.getQuantity() * proDet.getUnitPrice();
            }

            Account acc = (Account) session.getAttribute("staff");
            int staffId = 0;
            if (acc != null) {
                StaffDAO staffDAO = new StaffDAO();
                staffId = staffDAO.getStaffIdByAccountId(acc.getAccountID());
            }

            ImportStock impStock = new ImportStock(staffId, supTest.getSupplierID(), sum);
            int impId = ioD.createImportStock(impStock);

            if (impId <= 0) {
                session.setAttribute("error", "Không thể tạo phiếu nhập kho.");
                response.sendRedirect("ImportStock");
                return;
            }

            for (ImportStockDetail proDet : listTest) {
                proDet.setIoid(impId);
                iodD.createImportStockDetail(proDet);
            }

            ioD.importStock(impId);

            session.removeAttribute("selectedProducts");
            session.removeAttribute("supplier");
            session.setAttribute("success", "Nhập kho thành công!");
            response.sendRedirect("ImportStock");
        } else {
            session.setAttribute("error", "Vui lòng chọn nhà cung cấp và sản phẩm.");
            response.sendRedirect("ImportStock");
        }
    }

    @Override
    public String getServletInfo() {
        return "Import stock controller";
    }
}
