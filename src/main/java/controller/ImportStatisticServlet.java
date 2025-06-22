package controller;

import dao.ImportStockDAO;
import dao.InventoryStatisticDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import model.InventoryStatistic;

/**
 *
 * @author HP
 */
@WebServlet(name = "ImportStatisticServlet", urlPatterns = {"/ImportStatistic"})
public class ImportStatisticServlet extends HttpServlet {

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
        try {
            // Get search parameters
            String searchKeyword = request.getParameter("search");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            String supplierFilter = request.getParameter("supplier");
            
            // Initialize DAOs
            InventoryStatisticDAO invDao = new InventoryStatisticDAO();
            ImportStockDAO dao = new ImportStockDAO(); 
            
            // Get inventory list based on filters
            ArrayList<InventoryStatistic> inventoryList;
            
            // Apply filters
            if (hasFilters(searchKeyword, fromDateStr, toDateStr, supplierFilter)) {
                inventoryList = getFilteredInventory(invDao, searchKeyword, fromDateStr, toDateStr, supplierFilter);
            } else {
                inventoryList = invDao.getAllInventory();
            }
            
            // Get chart data (always get full data for charts)
            Map<String, Integer> dailyImport = dao.getImportStocksCountByDate();
            Map<String, Integer> monthlyImport = dao.getImportStocksCountByMonth();
            Map<String, Integer> supplierImport = dao.getStocksBySupplier();
            Map<String, Integer> topProductImport = dao.getTopImportedProducts();
            
            // Set attributes for JSP
            request.setAttribute("inventoryList", inventoryList);
            request.setAttribute("dailyImport", dailyImport);
            request.setAttribute("monthlyImport", monthlyImport);
            request.setAttribute("supplierImport", supplierImport);
            request.setAttribute("topProductImport", topProductImport);
            
            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStatistic.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching inventory statistics: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/View/staff/stockManagement/importStatistic.jsp").forward(request, response);
        }
    }
    
    /**
     * Check if any filters are applied
     */
    private boolean hasFilters(String searchKeyword, String fromDate, String toDate, String supplier) {
        return (searchKeyword != null && !searchKeyword.trim().isEmpty()) ||
               (fromDate != null && !fromDate.trim().isEmpty()) ||
               (toDate != null && !toDate.trim().isEmpty()) ||
               (supplier != null && !supplier.trim().isEmpty() && !"All".equals(supplier));
    }
    
    /**
     * Get filtered inventory based on search criteria
     */
    private ArrayList<InventoryStatistic> getFilteredInventory(InventoryStatisticDAO invDao, 
            String searchKeyword, String fromDateStr, String toDateStr, String supplierFilter) {
        
        ArrayList<InventoryStatistic> result = new ArrayList<>();
        
        try {
            // Start with all inventory
            ArrayList<InventoryStatistic> allInventory = invDao.getAllInventory();
            
            // Parse dates if provided
            Date fromDate = null;
            Date toDate = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            if (fromDateStr != null && !fromDateStr.trim().isEmpty()) {
                try {
                    fromDate = sdf.parse(fromDateStr);
                } catch (ParseException e) {
                    System.err.println("Error parsing fromDate: " + e.getMessage());
                }
            }
            
            if (toDateStr != null && !toDateStr.trim().isEmpty()) {
                try {
                    toDate = sdf.parse(toDateStr);
                    // Set time to end of day for toDate
                    toDate = new Date(toDate.getTime() + 24 * 60 * 60 * 1000 - 1);
                } catch (ParseException e) {
                    System.err.println("Error parsing toDate: " + e.getMessage());
                }
            }
            
            // Apply filters
            for (InventoryStatistic item : allInventory) {
                boolean matchesSearch = true;
                boolean matchesDateRange = true;
                boolean matchesSupplier = true;
                
                // Search filter (search in staff name, supplier name, product ID)
                if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                    String keyword = searchKeyword.toLowerCase().trim();
                    matchesSearch = (item.getFullName() != null && item.getFullName().toLowerCase().contains(keyword)) ||
                                   (item.getSupplierName() != null && item.getSupplierName().toLowerCase().contains(keyword)) ||
                                   (String.valueOf(item.getProductId()).contains(keyword));
                }
                
                // Date range filter
                if (fromDate != null || toDate != null) {
                    if (item.getImportDate() != null) {
                        if (fromDate != null && item.getImportDate().before(fromDate)) {
                            matchesDateRange = false;
                        }
                        if (toDate != null && item.getImportDate().after(toDate)) {
                            matchesDateRange = false;
                        }
                    } else {
                        matchesDateRange = false;
                    }
                }
                
                // Supplier filter
                if (supplierFilter != null && !supplierFilter.trim().isEmpty() && !"All".equals(supplierFilter)) {
                    matchesSupplier = supplierFilter.equals(item.getSupplierName());
                }
                
                // Add item if it matches all filters
                if (matchesSearch && matchesDateRange && matchesSupplier) {
                    result.add(item);
                }
            }
            
        } catch (Exception e) {
            System.err.println("Error in getFilteredInventory: " + e.getMessage());
            e.printStackTrace();
            // Return empty list on error
            return new ArrayList<>();
        }
        
        return result;
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
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Import Statistic Servlet with Search and Filter functionality";
    }
}