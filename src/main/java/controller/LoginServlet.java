package controller;

import dao.AccountDAO;
import model.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/View/customer/cartManagement/login.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AccountDAO dao = new AccountDAO();
        Account account = dao.authenticate(email, password);

        if (account != null) {
            // Lưu thông tin tài khoản vào session
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            // Chuyển hướng đến CartListServlet với accountId
            request.getRequestDispatcher("/WEB-INF/View/customer/homePage/homePage.jsp").forward(request, response);

        } else {
            // Đăng nhập thất bại, hiển thị lỗi
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for user login";
    }
}
