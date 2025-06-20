<%-- 
    Document   : newProduct
    Created on : Jun 16, 2025, 12:58:19 PM
    Author     : HP - Gia Khiêm
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Product> productListDiscount = (List<Product>) request.getAttribute("productListDiscount");
    BigDecimal oldPrice;
    BigDecimal newPrice;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/newProduct2.css">

    </head>
    <body>

        <div class = "container" style = "border-radius: 15px; margin-top: 1%; background-color: #fff; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* bóng nhẹ */">

            <p class = "new-product-label">Discount product</p>

            <div style = "display: flex; border-radius: 10px; gap: 20px;">
                <div class = "banner-section" style = "flex: 0 0 300px; border-radius: 5px; margin-bottom: 1%">
                    <img style = "width: 100%; height: 400px; object-fit: cover; border-radius: 5px;" src = "https://24hstore.vn/upload_images/images/2023/12/07/sale-noel-24hstore-6.gif">
                </div>

                <!-- Products section - Takes remaining space -->
                <div class="row" style = "flex: 1; min-width: 0;">
                    <%
                        if (productListDiscount != null) {
                    %>

                    <%
                        for (Product pro : productListDiscount) {
                            if (pro.getDiscount() != 0) {
                                oldPrice = pro.getPrice();

                                BigDecimal price = pro.getPrice();
                                int discount = pro.getDiscount();

                                BigDecimal discountRate = BigDecimal.valueOf(discount).divide(BigDecimal.valueOf(100));
                                newPrice = price.multiply(BigDecimal.ONE.subtract(discountRate));
                    %>

                    <div class = "sanPhamMoi">
                        <a name="id" href="<%= request.getContextPath()%>/Detail?id=" 
                           style="text-decoration: none; color: inherit; display: block;">

                            <div class = "divHinh">
                                <img style = "width: 98%" src="<%= pro.getImageUrl()%>"  alt = "anhDienThoai" class = "anhDienThoaiDocQuyen">
                            </div>

                            <div class = "divTraGop">
                                <p class = "traGop">Trả góp 0%</p>
                            </div>


                            <%
                                BigDecimal giaCu = oldPrice;
                                BigDecimal giaMoi = newPrice;
                                BigDecimal giaDaGiam = giaCu.subtract(giaMoi);
                            %>
                            <%
                                Locale localeVN = new Locale("vi", "VN");
                                NumberFormat currencyVN = NumberFormat.getInstance(localeVN);

                                String giaCuFormatted = currencyVN.format(oldPrice);
                                String giaMoiFormatted = currencyVN.format(giaMoi);
                                String giamFormatted = currencyVN.format(giaDaGiam);
                            %>

                            <p class = "productName"> <%= pro.getProductName()%></p>

                            <p class = "giaCu">
                                <s><%= giaCuFormatted%></s> 
                                <span style = "color: red">-<%= (int) discount%>%</span></p>
                            <p class= "giaMoi"><%= giaMoiFormatted%> đ</p>
                            <p class = "giam">Giảm <%= giamFormatted%> đ</p>
                        </a>
                    </div>

                    <%
                    } else {
                        oldPrice = pro.getPrice();
                        Locale localeVN = new Locale("vi", "VN");
                        NumberFormat currencyVN = NumberFormat.getInstance(localeVN);
                        String giaCuFormatted = currencyVN.format(oldPrice);
                    %>
                    <div class = "sanPhamMoi">
                        <a name="id" href="<%= request.getContextPath()%>/Detail?id=" 
                           style="text-decoration: none; color: inherit; display: block;">

                            <div class = "divHinh">
                                <img style = "width: 98%" src="<%= pro.getImageUrl()%>"  alt = "anhDienThoai" class = "anhDienThoaiDocQuyen">
                            </div>

                            <div class = "divTraGop">
                                <p class = "traGop">Trả góp 0%</p>
                            </div>

                            <p class = "productName"> <%= pro.getProductName()%></p>

                            <p class= "giaMoi"><%= giaCuFormatted%> đ</p>
                            <p></p>
                            <p></p>

                        </a>
                    </div>
                    <%
                            }
                        }
                    } else {

                    %>
                    <p>null</p>
                    <%    }
                    %>

                </div>
            </div>
        </div>
    </body>
</html>

<style>
.banner-section {
    flex-shrink: 0; /* Prevent banner from shrinking */
}


</style>