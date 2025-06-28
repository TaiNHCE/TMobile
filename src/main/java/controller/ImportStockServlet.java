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

    SupplierDAO supplierDAO = new SupplierDAO();
    ProductDAO productDAO = new ProductDAO();
    ImportStockDAO importStockDAO = new ImportStockDAO();
    ImportStockDetailDAO importStockDetailDAO = new ImportStockDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String status = request.getParameter("status");
        // neu nhan nut cancel
        if (status != null && status.equals("cancel")) {
            session.removeAttribute("selectedProducts");
            session.setAttribute("success", "Stock import completed successfully!");
            response.sendRedirect("ImportStock?success=imported");
            return;
        }

        // luon set danh sach nha cung cap cho jsp
        List<Suppliers> suppliers = supplierDAO.getAllSuppliers();
        request.setAttribute("suppliers", suppliers);
        session.setAttribute("suppliers", suppliers);

        // luon set danh sach san pham cho jsp
        ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("products");
        if (products == null) {
            products = (ArrayList<Product>) productDAO.getProductList();
            session.setAttribute("products", products);
        }

        request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStock.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // lay danh sach chi tiet san pham duoc chon nhap kho tu session
        ArrayList<ImportStockDetail> detailList = (ArrayList<ImportStockDetail>) session.getAttribute("selectedProducts");
        if (detailList == null) {
            detailList = new ArrayList<>();
        }

        // lay danh sach san pham tu session neu chua co thi lay tu db
        ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("products");
        if (products == null) {
            products = (ArrayList<Product>) productDAO.getProductList();
            session.setAttribute("products", products);
        }

        // xu ly chon nha cung cap
        // xu ly chon nha cung cap
        String supplierIdRaw = request.getParameter("supplierId");
        if (supplierIdRaw != null && !supplierIdRaw.trim().isEmpty()) {
            try {
                int supplierId = Integer.parseInt(supplierIdRaw.trim());
                Suppliers supplier = supplierDAO.getSupplierById(supplierId);
                session.setAttribute("supplier", supplier);

                // Lay danh sach san pham theo supplierId
                ArrayList<Product> filteredProducts = (ArrayList<Product>) productDAO.getProductListBySupplierId(supplierId);
                session.setAttribute("products", filteredProducts); // Cap nhat lai list products

                // Xoa selectedProducts khi doi nha cung cap (reset lai de tranh nhap nham)
                session.setAttribute("selectedProducts", new ArrayList<ImportStockDetail>());
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid supplier ID.");
            }
            response.sendRedirect("ImportStock");
            return;
        }

        // xu ly them san pham vao danh sach nhap kho
        String productIdRaw = request.getParameter("productId");
        String quantityRaw = request.getParameter("importQuantity");
        String priceRaw = request.getParameter("unitPrice");

        if (productIdRaw != null && quantityRaw != null && priceRaw != null
                && !productIdRaw.trim().isEmpty() && !quantityRaw.trim().isEmpty() && !priceRaw.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdRaw.trim());
                int quantity = Integer.parseInt(quantityRaw.trim());
                long price = Long.parseLong(priceRaw.trim());

                Product product = productDAO.getProductByID(productId);
                ImportStockDetail detail = new ImportStockDetail();
                detail.setProduct(product);
                detail.setQuantity(quantity);
                detail.setUnitPrice(price);
                detail.setQuantityLeft(quantity);

                boolean isContained = false;
                // kiem tra da ton tai chua
                for (ImportStockDetail proDet : detailList) {
                    if (proDet.getProduct().getProductId() == productId) {
                        isContained = true;
                        break;
                    }
                }

                if (!isContained) {
                    detailList.add(detail);

                    int deleteIndex = -1;
                    // xoa khoi list product co san
                    for (int i = 0; i < products.size(); ++i) {
                        if (products.get(i).getProductId() == productId) {
                            deleteIndex = i;
                            break;
                        }
                    }
                    if (deleteIndex != -1) {
                        products.remove(deleteIndex);
                    }
                } else {
                    session.setAttribute("error", "Product already selected.");
                }

                session.setAttribute("selectedProducts", detailList);
                session.setAttribute("products", products);

                request.setAttribute("suppliers", supplierDAO.getAllSuppliers());
                request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStock.jsp").forward(request, response);
                return;

            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid input value.");
                response.sendRedirect("ImportStock");
                return;
            }
        }

        // xu ly sua hoac xoa san pham trong danh sach nhap kho
        String action = request.getParameter("action");
        if (action != null) {
            try {
                int productId = Integer.parseInt(request.getParameter("productEditedId"));

                if ("delete".equals(action)) {
                    // xoa san pham khoi danh sach
                    for (int i = 0; i < detailList.size(); i++) {
                        if (detailList.get(i).getProduct().getProductId() == productId) {
                            detailList.remove(i);
                            Product temp = productDAO.getProductByID(productId);
                            products.add(temp);
                            break;
                        }
                    }
                } else if ("save".equals(action)) {
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    long price = Long.parseLong(request.getParameter("price"));

                    // cap nhat so luong va gia
                    for (int i = 0; i < detailList.size(); i++) {
                        if (detailList.get(i).getProduct().getProductId() == productId) {
                            detailList.get(i).setQuantity(quantity);
                            detailList.get(i).setUnitPrice(price);
                            detailList.get(i).setQuantityLeft(quantity);
                            break;
                        }
                    }
                }

                // sap xep lai danh sach san pham theo id tang dan
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

                request.setAttribute("suppliers", supplierDAO.getAllSuppliers());
                request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStock.jsp").forward(request, response);
                return;

            } catch (NumberFormatException e) {
                session.setAttribute("error", "Cannot process product data.");
                response.sendRedirect("ImportStock");
                return;
            }
        }

        // xu ly submit nhap kho
        Suppliers supplier = (Suppliers) session.getAttribute("supplier");
        ArrayList<ImportStockDetail> selectedProducts = (ArrayList<ImportStockDetail>) session.getAttribute("selectedProducts");

        if (supplier != null && selectedProducts != null && !selectedProducts.isEmpty()) {
            long total = 0L;
            for (ImportStockDetail detail : selectedProducts) {
                total += detail.getQuantity() * detail.getUnitPrice();
            }

            Account account = (Account) session.getAttribute("staff");
            int staffId = 0;
            // lay staff id tu account neu co
            if (account != null) {
                StaffDAO staffDAO = new StaffDAO();
                staffId = staffDAO.getStaffIdByAccountId(account.getAccountID());
            }

            // tao phieu nhap kho
            ImportStock importStock = new ImportStock(staffId, supplier.getSupplierID(), total);
            int importId = importStockDAO.createImportStock(importStock);

            if (importId <= 0) {
                session.setAttribute("error", "Cannot create import stock receipt.");
                response.sendRedirect("ImportStock");
                return;
            }

            // tao chi tiet phieu nhap kho
            for (ImportStockDetail detail : selectedProducts) {
                detail.setIoid(importId);
                detail.setQuantityLeft(detail.getQuantity());
                importStockDetailDAO.createImportStockDetail(detail);
            }

            // cap nhat ton kho san pham
            importStockDAO.importStock(importId);

            // xoa du lieu tren session
            session.removeAttribute("selectedProducts");
            session.removeAttribute("supplier");
            session.removeAttribute("products");

            response.sendRedirect("ImportStock?success=imported");

        } else {
            response.sendRedirect("ImportStock?error=1");
        }
    }

    @Override
    public String getServletInfo() {
        return "Import stock controller";
    }
}
