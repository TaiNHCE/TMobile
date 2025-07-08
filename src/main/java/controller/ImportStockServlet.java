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
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.ImportStock;
import model.ImportStockDetail;
import model.Product;
import model.Staff;
import model.Suppliers;

@WebServlet(name = "ImportStockServlet", urlPatterns = {"/ImportStock"})
public class ImportStockServlet extends HttpServlet {

    SupplierDAO supplierDAO = new SupplierDAO();
    ProductDAO productDAO = new ProductDAO();
    ImportStockDAO importStockDAO = new ImportStockDAO();
    ImportStockDetailDAO importStockDetailDAO = new ImportStockDetailDAO();

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
            out.println("<title>Servlet ImportStatisticServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportStatisticServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String status = request.getParameter("status");
        // Cancel button: clear session data and redirect
        if (status != null && status.equals("cancel")) {
            session.removeAttribute("selectedProducts");
            session.setAttribute("success", "Stock import completed successfully!");
            response.sendRedirect("ImportStock?success=imported");
            return;
        }

        // Always load supplier list for JSP
        List<Suppliers> suppliers = supplierDAO.getAllSuppliers();
        request.setAttribute("suppliers", suppliers);
        session.setAttribute("suppliers", suppliers);

        // Always load product list for JSP if not available in session
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

        // Get product detail list from session
        ArrayList<ImportStockDetail> detailList = (ArrayList<ImportStockDetail>) session.getAttribute("selectedProducts");
        if (detailList == null) {
            detailList = new ArrayList<>();
        }

        // Get product list from session or database
        ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("products");
        if (products == null) {
            products = (ArrayList<Product>) productDAO.getProductList();
            session.setAttribute("products", products);
        }

        // 1. Handle supplier selection
        String supplierIdRaw = request.getParameter("supplierId");
        if (supplierIdRaw != null && !supplierIdRaw.trim().isEmpty()) {
            try {
                int supplierId = Integer.parseInt(supplierIdRaw.trim());
                Suppliers supplier = supplierDAO.getSupplierById(supplierId);
                session.setAttribute("supplier", supplier);

                ArrayList<Product> allProducts = (ArrayList<Product>) productDAO.getProductList();
                session.setAttribute("products", allProducts);

                session.setAttribute("selectedProducts", new ArrayList<ImportStockDetail>());
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid supplier ID.");
            }
            response.sendRedirect("ImportStock");
            return;
        }

        // 2. Handle adding product to import list
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
                if (price >= product.getPrice().longValue()) {
                    session.setAttribute("error", "Import price (" + price + ") must be less than sale price (" 
                        + product.getPrice().longValue() + ").");
                    response.sendRedirect("ImportStock");
                    return;
                }
                ImportStockDetail detail = new ImportStockDetail();
                detail.setProduct(product);
                detail.setQuantity(quantity);
                detail.setUnitPrice(price);
                detail.setQuantityLeft(quantity);

                boolean isContained = false;
                for (ImportStockDetail proDet : detailList) {
                    if (proDet.getProduct().getProductId() == productId) {
                        isContained = true;
                        break;
                    }
                }

                if (!isContained) {
                    detailList.add(detail);

                    int deleteIndex = -1;
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

        // 3. Handle edit/delete product in import list
        String action = request.getParameter("action");
        if (action != null) {
            try {
                int productId = Integer.parseInt(request.getParameter("productEditedId"));

                if ("delete".equals(action)) {
                    // Remove product from detail list
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

                    Product product = productDAO.getProductByID(productId);
                    if (price >= product.getPrice().longValue()) {
                        session.setAttribute("error", "Import price (" + price + ") must be less than sale price (" + product.getPrice().longValue() + ").");
                        response.sendRedirect("ImportStock");
                        return;
                    }
                    // Update product detail
                    for (int i = 0; i < detailList.size(); i++) {
                        if (detailList.get(i).getProduct().getProductId() == productId) {
                            detailList.get(i).setQuantity(quantity);
                            detailList.get(i).setUnitPrice(price);
                            detailList.get(i).setQuantityLeft(quantity);
                            break;
                        }
                    }
                }

                // Sort products by ID ascending
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

        // 4. Handle final import submit
        Suppliers supplier = (Suppliers) session.getAttribute("supplier");
        ArrayList<ImportStockDetail> selectedProducts = (ArrayList<ImportStockDetail>) session.getAttribute("selectedProducts");

        if (supplier != null && selectedProducts != null && !selectedProducts.isEmpty()) {
            long total = 0L;
            for (ImportStockDetail detail : selectedProducts) {
                total += detail.getQuantity() * detail.getUnitPrice();
            }

            Account account = (Account) session.getAttribute("staff");
            int staffId = 0;
            if (account != null) {
                StaffDAO staffDAO = new StaffDAO();
                staffId = staffDAO.getStaffIdByAccountId(account.getAccountID());
            }

            ImportStock importStock = new ImportStock(staffId, supplier.getSupplierID(), total);
            int importId = importStockDAO.createImportStock(importStock);

            if (importId <= 0) {
                session.setAttribute("error", "Cannot create import stock receipt.");
                response.sendRedirect("ImportStock");
                return;
            }

            for (ImportStockDetail detail : selectedProducts) {
                detail.setIoid(importId);
                detail.setQuantityLeft(detail.getQuantity());
                importStockDetailDAO.createImportStockDetail(detail);
            }

            importStockDAO.importStock(importId);

            session.removeAttribute("selectedProducts");
            session.removeAttribute("supplier");
            session.removeAttribute("products");

            response.sendRedirect("ImportStock?success=imported");
            return;
        } else {
            response.sendRedirect("ImportStock?error=1");
            return;
        }
    }

    @Override
    public String getServletInfo() {
        return "Import stock controller";
    }
}
