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

@WebServlet(name = "UpdateAddressServlet", urlPatterns = {"/UpdateAddress"})
public class UpdateAddressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // DEV MODE: nếu chưa login thì tạo dummy customer id=1
        Customer cus = (Customer) session.getAttribute("customer");
        if (cus == null) {
            cus = new Customer();
            cus.setId(1);
            session.setAttribute("customer", cus);
        }

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect("ViewShippingAddress");
            return;
        }

        int addressId = Integer.parseInt(idStr);

        AddressDAO dao = new AddressDAO();
        Address addr = dao.getAddressById(addressId);

        // Không cho sửa nếu không đúng chủ sở hữu (optionally)
        if (addr == null || addr.getCustomerId() != cus.getId()) {
            response.sendRedirect("ViewShippingAddress");
            return;
        }

        request.setAttribute("address", addr);
        request.setAttribute("hasDefault", dao.hasDefaultAddress(cus.getId()));
        request.getRequestDispatcher("/WEB-INF/View/customer/shippingAddress/UpdateShippingAddress.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // DEV MODE: nếu chưa login thì tạo dummy customer id=1
        Customer cus = (Customer) session.getAttribute("customer");
        if (cus == null) {
            cus = new Customer();
            cus.setId(1);
            session.setAttribute("customer", cus);
        }

        int addressId = Integer.parseInt(request.getParameter("id"));
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String addressDetails = request.getParameter("addressDetails");

        // Validate cơ bản
        if (province == null || district == null || ward == null || addressDetails == null
                || province.trim().isEmpty() || district.trim().isEmpty()
                || ward.trim().isEmpty() || addressDetails.trim().isEmpty()) {
            request.setAttribute("error", "Please fill in all required fields.");
            AddressDAO dao = new AddressDAO();
            Address addr = dao.getAddressById(addressId);
            request.setAttribute("address", addr);
            request.getRequestDispatcher("/WEB-INF/View/customer/shippingAddress/UpdateShippingAddress.jsp").forward(request, response);
            return;
        }

        boolean isDefault = false;
        AddressDAO dao = new AddressDAO();
        if (!dao.hasDefaultAddress(cus.getId()) || request.getParameter("isDefault") != null) {
            isDefault = true;
        }
        if (isDefault) {
            dao.unsetDefaultAddresses(cus.getId());
        }

        Address address = new Address(
            addressId,
            cus.getId(),
            province,
            district,
            ward,
            addressDetails,
            isDefault
        );
        dao.updateAddress(address);

        response.sendRedirect("ViewShippingAddress");
    }
}
