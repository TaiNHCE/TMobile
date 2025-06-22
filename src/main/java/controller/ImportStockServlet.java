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

        if (request.getParameter("supplierId") != null) {
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            Suppliers s = sd.getSupplierById(supplierId);
            session.setAttribute("supplier", s);
            response.sendRedirect("ImportStock");
            return;
        } else if (request.getParameter("productId") != null) {
            int pId = Integer.parseInt(request.getParameter("productId"));
            Product p = pd.getProductByID(pId);
            ImportStockDetail d = new ImportStockDetail();
            d.setProduct(p);
            d.setQuantity(Integer.parseInt(request.getParameter("importQuantity")));
            d.setUnitPrice(Long.parseLong(request.getParameter("importPrice")));

            boolean isContained = false;
            for (ImportStockDetail proDet : detailList) {
                if (proDet.getProduct().getProductId() == pId) {
                    isContained = true;
                }
            }

            if (!isContained) {
                detailList.add(d);
                int deleteIndex = -1;
                for (int i = 0; i < products.size(); ++i) {
                    if (products.get(i).getProductId() == d.getProduct().getProductId()) {
                        deleteIndex = i;
                    }
                }
                if (deleteIndex != -1) {
                    products.remove(deleteIndex);
                }
            } else {
                session.setAttribute("error", "Duplicated Product");
            }

            session.setAttribute("selectedProducts", detailList);
            session.setAttribute("products", products);

            // PHẢI luôn set suppliers cho request để JSP dùng
            request.setAttribute("suppliers", sd.getAllSuppliers());
            request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStock.jsp").forward(request, response);
            return;
        } else if (request.getParameter("action") != null) {
            String action = request.getParameter("action");
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
                for (int i = 0; i < detailList.size(); i++) {
                    if (detailList.get(i).getProduct().getProductId() == pId) {
                        detailList.get(i).setQuantity(Integer.parseInt(request.getParameter("quantity")));
                        detailList.get(i).setUnitPrice(Long.parseLong(request.getParameter("price")));
                        break;
                    }
                }
            }

            // Sắp xếp products tăng dần cho đẹp (có thể bỏ)
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

            // PHẢI luôn set suppliers cho request để JSP dùng
            request.setAttribute("suppliers", sd.getAllSuppliers());
            request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStock.jsp").forward(request, response);
            return;
        } else {
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

                // ==== LOG DEBUG TRƯỚC INSERT ====
                System.out.println("=== DEBUG IMPORT ===");
                System.out.println("StaffID: " + staffId);
                System.out.println("SupplierID: " + supTest.getSupplierID());
                System.out.println("TotalCost: " + sum);
                System.out.println("ImportStockDetail count: " + listTest.size());
                for (ImportStockDetail d : listTest) {
                    System.out.println("ProductID: " + d.getProduct().getProductId()
                            + ", Quantity: " + d.getQuantity()
                            + ", Price: " + d.getUnitPrice());
                }
                System.out.println("====================");

                ImportStock impStock = new ImportStock(staffId, supTest.getSupplierID(), sum);
                int impId = ioD.createImportStock(impStock);
                System.out.println("Returned importID = " + impId);

                if (impId <= 0) {
                    System.out.println("INSERT FAILED!!! importID <= 0");
                    session.setAttribute("error", "Không thể tạo phiếu nhập kho. Vui lòng kiểm tra lại dữ liệu nhập!");
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
                session.setAttribute("error", "Please select full");
                response.sendRedirect("ImportStock");
            }

        }
    }

    @Override
    public String getServletInfo() {
        return "Import stock controller";
    }
}
