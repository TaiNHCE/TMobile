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
    <meta charset="UTF-8">
    <title>Category Detail</title>
    <link rel="stylesheet" href="Css/categoryDetail.css">
    <link rel="stylesheet" href="Css/productDetail.css">
    
</head>
<body>
    <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 3%; margin-top: 3%">
        <h1 class="display-5 fw-bold" style="font-size: 320%; margin: 0;">Category</h1>
        <span style="font-size: 120%; color: gray; margin-top: 4%;">View Category Detail</span>
    </div>

    <!-- Category name -->
    <div style="border-radius: 12px; border: 1px solid #ccc; width: 85%; height: 25%; margin-bottom: 3%;">
        <h2 style="margin-left: 1%;">Category Name</h2>
        <hr>
        <div>
            <%
                if (categoryList != null) {
                    for (Category cate : categoryList) {
                        if (cate.getIsActive()) {
                            boolean check = (cate.getCategoryId() == categoryId);
            %>
            <div class="divLogo <%= check ? "activeCategory" : "" %>">
                <img class="logoCategory" src="<%= cate.getImgUrlLogo() %>">
                <h2 style="margin-left: 9%;"><%= cate.getCategoryName() %></h2>
            </div>
            <%      }
                    }
                }
            %>
        </div>
    </div>

    <!-- Technical Specifications -->
    <h2>Technical Specifications</h2>
    <div style="background-color: #FFFFFF; border-radius: 15px; width: 85%">
        <div style="width: 100%">
            <table class="category-table">
                <tbody>
                <%
                    if (categoryDetailGroup != null) {
                        int groupIndex = 0;
                        for (CategoryDetailGroup cateGroup : categoryDetailGroup) {
                %>
                    <!-- Group Header Row -->
                    <tr class="group-header" onclick="toggleDetails(<%= groupIndex %>)">
                        <td colspan="2" class="group-cell">
                            <div class="group-header-content">
                                <h2><%= cateGroup.getNameCategoryDetailsGroup() %></h2>
                                <span class="arrow-icon" id="arrow<%= groupIndex %>">▼</span>
                            </div>
                        </td>
                    </tr>

                    <!-- Group Detail Rows -->
                    <%
                        if (categoryDetailList != null && !categoryDetailList.isEmpty()) {
                            for (CategoryDetail cateList : categoryDetailList) {
                                if (cateList.getCategoryDetailsGroupID() == cateGroup.getCategoryDetailsGroupID()) {
                    %>
                    <tr class="hidden group-details detailGroup<%= groupIndex %>">
                        <td class="category-name"><%= cateList.getCategoryDatailName() %></td>
                        <td></td>
                    </tr>
                    <%
                                }
                            }
                        }
                        groupIndex++;
                    }
                } else {
                %>
                    <tr><td colspan="2" class="no-data-message">No data</td></tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function toggleDetails(index) {
            const rows = document.querySelectorAll('.detailGroup' + index);
            const arrowIcon = document.getElementById('arrow' + index);

            rows.forEach(row => {
                row.classList.toggle('hidden');
            });

            arrowIcon.innerText = arrowIcon.innerText === '▼' ? '▲' : '▼';
        }
    </script>
</body>

<style>
    .hidden {
    display: none !important;
}
</style>
</html>
