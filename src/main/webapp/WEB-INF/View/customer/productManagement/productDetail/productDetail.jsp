<%-- 
    Document   : productDetail
    Created on : Jul 10, 2025, 12:18:54 PM
    Author     : HP - Gia Khiêm
--%>

<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Product product = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/customerProductDetail.css">
    </head>

    <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />
    <body>
        <div style = "display: flex; gap: 1%;">
            
            <div style= "width: 59%;">
                <div style="display: flex; gap: 4px; font-size: 14px; color: #555; margin-top: 2%; margin-bottom: 2%;">
                    <a href="/" style="text-decoration: none; color: #007bff;">Home</a> >
                    <a href="#" style="text-decoration: none; color: #007bff;"><%= product.getCategoryName()%></a> >
                    <a href="#" style="text-decoration: none; color: #000;"><%= product.getProductName()%></a>
                </div>


                <h1 style = "font-size: 20px"> <%= product.getProductName()%></h1>

                <div class = "customerDivImageDetail">
                    <jsp:include page="/WEB-INF/View/customer/productManagement/productDetail/imageProduct.jsp" />
                </div>

                <div class = "customerDivCommitted">
                    <jsp:include page="/WEB-INF/View/customer/productManagement/productDetail/committed.jsp" />
                </div>

                <div class = "customerDivinfomationDetail" style = "margin-top: 15px;">
                    <jsp:include page="/WEB-INF/View/customer/productManagement/productDetail/infomationDetail.jsp" />
                </div>

            </div>

            <div class = "customerDivaddToCartAndBuyNow" style = "width: 40%; margin-top: 6.8%; max-height: 820px;">
                <jsp:include page="/WEB-INF/View/customer/productManagement/productDetail/addToCartAndBuyNow.jsp" />
            </div>
        </div>
    </body>
    <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

    <style>
        body {
            background-color: #F2F4F7;
        }
    </style>
</html>
