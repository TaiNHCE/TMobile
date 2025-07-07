package controller;

import dao.AddressDAO;
import model.Address;
import model.Customer;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ViewShippingAddressServlet", urlPatterns = {"/ViewShippingAddress"})
public class ViewShippingAddressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // DEV: Nếu chưa có customer, tạo sẵn customer id = 1
        if (session.getAttribute("customer") == null) {
            Customer dummy = new Customer();
            dummy.setId(1);
            session.setAttribute("customer", dummy);
        }

        Customer cus = (Customer) session.getAttribute("customer");
        AddressDAO dao = new AddressDAO();
        List<Address> addressList = dao.getAllAddressesByCustomerId(cus.getId());
        request.setAttribute("addressList", addressList);
        request.getRequestDispatcher("/WEB-INF/View/customer/shippingAddress/ViewShippingAddress.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thường không cần dùng
    }
}
