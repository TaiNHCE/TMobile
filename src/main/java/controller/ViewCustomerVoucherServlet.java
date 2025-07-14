package controller;

import dao.CustomerVoucherDAO;
import model.CustomerVoucher;
import model.Customer;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
@WebServlet(name = "ViewCustomerVoucherServlet", urlPatterns = {"/ViewCustomerVoucher"})
public class ViewCustomerVoucherServlet extends HttpServlet {

    private CustomerVoucherDAO customerVoucherDAO = new CustomerVoucherDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy customer từ session (login xong phải set lên session rồi nhé!)
        Customer customer = (Customer) request.getSession().getAttribute("customer");
        if (customer == null) {
            // Nếu chưa đăng nhập thì chuyển về login
            response.sendRedirect("LoginPage"); // sửa lại đường dẫn đúng nếu cần
            return;
        }
        int customerId = customer.getId();

        // Lấy danh sách voucher của khách này (cả personal & global)
        List<CustomerVoucher> voucherList = customerVoucherDAO.getAllVouchersForCustomer(customerId);

        // Gán lên request để JSP dùng
        request.setAttribute("voucherList", voucherList);
        request.setAttribute("customer", customer); // Nếu JSP cần hiển thị info

        // Chuyển tiếp sang trang JSP hiển thị
        request.getRequestDispatcher("/WEB-INF/View/customer/voucherCustomer/voucherListCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu cần xử lý POST thì tùy bạn, còn nếu chỉ GET thì gọi lại GET cho tiện
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "View all personal and global vouchers for a customer (get from session)";
    }
}
