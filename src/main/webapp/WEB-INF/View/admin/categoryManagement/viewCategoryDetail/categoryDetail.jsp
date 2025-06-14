<%-- 
    Document   : categoryDetail
    Created on : Jun 14, 2025, 9:52:22 PM
    Author     : HP - Gia Khiêm
--%>

<%@page import="model.CategoryDetail"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<CategoryDetail> categoryDetailList = (List<CategoryDetail>) request.getAttribute("categoryDetailList");
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
    int categoryId = (int) request.getAttribute("categoryId");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="Css/categoryDetail.css">
        
    </head>
    <body>
        <div style="display: flex; align-items: center; gap: 10px; margin-left: 21.5%; margin-bottom: 3%;  margin-top: 3%">
            <h1 class = "display-5 fw-bold" style="font-size: 320%; margin: 0;">Category</h1>
            <span style="font-size: 120%; color: gray; margin-top: 4%;">View Category Detail</span>
        </div>

        <!--            <== Category name==>-->
        <div style = "margin-left: 21.5%; border-radius: 12px; border: 1px solid #ccc; width: 75%; margin-bottom: 3%; ">
            <h2 style = "margin-left: 1%;">
                Category Name
            </h2>
            <hr>
            <div>
                <%
                    if (categoryList != null) {
                        for (Category cate : categoryList) {
                            boolean check = cate.getCategoryId() == categoryId;
                %>
                <div class = "divLogo <%= check ? "activeCategory" : ""%>">
                    <img class = "logoCategory" src = "<%= cate.getImgUrlLogo()%>">
                    <h2 style = "margin-left: 9%;"><%= cate.getCategoryName()%></h2>
                </div>



                <%                    }
                    }
                %>
            </div>
        </div>
        <!--            <== Category name==>-->

        <!--            <== Category detail==>-->
        <div style="margin-left: 21.5%; border-radius: 12px; border: 1px solid #ccc; width: 75%;">
            <%
                if (categoryDetailList != null && !categoryDetailList.isEmpty()) {
                    int count = 1;
            %>
            <h2 style="margin-left: 1%;">Category Detail</h2>
            <hr>

            <div class="categoryDetailGrid">
                <% for (CategoryDetail cateDetail : categoryDetailList) {%>
                <div class="divContentCategoryDetail">
                    <h2 class="categoryDatailName">Category Detail <%= count++%></h2>
                    <h2><%= cateDetail.getCategoryDatailName()%></h2>
                </div>
                <% } %>
            </div>
            <%
            } else {
            %>
            <h1 style="text-align: center; color: gray;">No category detail data available.</h1>
            <%
                }
            %>
        </div>



        <!--            <== Category detail==>-->
        
    </body>
</html>
