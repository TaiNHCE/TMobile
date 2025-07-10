package controller;

import dao.AddressDAO;
import model.Address;
import model.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddAddressServlet", urlPatterns = {"/AddAddress"})
public class AddAddressServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // DEV: Nếu chưa có customer, tạo sẵn customer id = 1
        if (session.getAttribute("customer") == null) {
            Customer dummy = new Customer();
            dummy.setId(1); // set sẵn ID = 1
            session.setAttribute("customer", dummy);
        }
        // Gọi trang thêm địa chỉ
        request.getRequestDispatcher("/WEB-INF/View/customer/shippingAddress/AddShippingAddress.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // DEV: Nếu chưa có customer, tạo sẵn customer id = 1
        if (session.getAttribute("customer") == null) {
            Customer dummy = new Customer();
            dummy.setId(1);
            session.setAttribute("customer", dummy);
        }

        Customer cus = (Customer) session.getAttribute("customer");
        AddressDAO addressDAO = new AddressDAO();

        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String addressDetails = request.getParameter("addressDetails");

        // Validate cơ bản phía server
        if (province == null || district == null || ward == null || addressDetails == null
                || province.trim().isEmpty() || district.trim().isEmpty()
                || ward.trim().isEmpty() || addressDetails.trim().isEmpty()) {
            request.setAttribute("error", "Please fill in all required fields.");
            request.getRequestDispatcher("/WEB-INF/View/customer/shippingAddress/AddShippingAddress.jsp").forward(request, response);
            return;
        }

        boolean isDefault = false;
        if (!addressDAO.hasDefaultAddress(cus.getId()) || request.getParameter("isDefault") != null) {
            isDefault = true;
        }
        if (isDefault) {
            addressDAO.unsetDefaultAddresses(cus.getId());
        }

        Address newAddress = new Address(
            0,
            cus.getId(),
            province,
            district,
            ward,
            addressDetails,
            isDefault
        );
        addressDAO.createAddress(newAddress);

        // Sau khi thêm xong, chuyển về trang danh sách địa chỉ
        response.sendRedirect("ViewShippingAddress");
    }
}
