<%-- 
    Document   : categoryDetail
    Created on : Jun 14, 2025, 9:52:22 PM
    Author     : HP - Gia Khiêm
--%>

<%@page import="model.CategoryDetailGroup"%>
<%@page import="model.CategoryDetail"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<CategoryDetail> categoryDetailList = (List<CategoryDetail>) request.getAttribute("categoryDetailList");
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
    List<CategoryDetailGroup> categoryDetailGroup = (List<CategoryDetailGroup>) request.getAttribute("categoryDetaiGrouplList");
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
        <div style = "margin-left: 21.5%; border-radius: 12px; border: 1px solid #ccc; width: 75%; height: 25%; margin-bottom: 3%; ">
            <h2 style = "margin-left: 1%;">
                Category Name
            </h2>
            <hr>
            <div>
                <%
                    if (categoryList != null) {
                        for (Category cate : categoryList) {
                        if(cate.getIsActive() == true){
                            boolean check = (cate.getCategoryId() == categoryId);
                       
                %>
                <div class = "divLogo <%= check ? "activeCategory" : ""%>">
                    <img class = "logoCategory" src = "<%= cate.getImgUrlLogo()%>">
                    <h2 style = "margin-left: 9%;"><%= cate.getCategoryName()%></h2>
                </div>



                <%                    }
                    }
}
                %>
            </div>
        </div>
        <!--            <== Category name==>-->

        <!--            <== Category detail==>-->
        <!-- Vùng hiển thị tổng -->
        <div class="category-container">
            <h2>Technical Specifications</h2>
            <hr>
            <%
                if (categoryDetailGroup != null && !categoryDetailGroup.isEmpty()) {
                    int groupIndex = 0;
                    for (CategoryDetailGroup cateGroup : categoryDetailGroup) {
            %>

            <!-- Nhóm tiêu đề -->
            <div class="group-header" onclick="toggleDetails(<%= groupIndex%>)">
                <h2><%= cateGroup.getNameCategoryDetailsGroup()%></h2>
            </div>

            <!-- Chi tiết, ẩn ban đầu -->
            <div class="group-details" id="detailGroup<%= groupIndex%>">
                <%
                    if (categoryDetailList != null && !categoryDetailList.isEmpty()) {
                        for (CategoryDetail cateList : categoryDetailList) {
                            if (cateList.getCategoryDetailsGroupID() == cateGroup.getCategoryDetailsGroupID()) {
                %>
                <div class="detail-item">
                    <%= cateList.getCategoryDatailName()%>
                </div>
                <%
                            }
                        }
                    }
                %>
            </div>
            <%
                    groupIndex++;
                }
            } else {
            %>
            <p class="no-data-message">No data</p>
            <%
                }

            %>
        </div>




        <!--            <== Category detail==>-->

    </body>
</html>

<script>
    function toggleDetails(index) {
        var detailDiv = document.getElementById("detailGroup" + index);
        if (detailDiv.style.display === "none") {
            detailDiv.style.display = "block";
        } else {
            detailDiv.style.display = "none";
        }
    }
</script>
