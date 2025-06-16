<%-- 
    Document   : viewCategoryList
    Created on : Jun 13, 2025, 11:27:19 PM
    Author     : HP - Gia Khiêm
--%>

<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="Css/viewCategoryList.css">
        
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/admin/categoryManagement/deleteCategory/deleteCategory.jsp" />
        <div>
            <h1 class = "col-md-9 fw-bold display-5" style = "margin-left: 18.9%; margin-top: 5%">
                Category Management
            </h1>
        </div>

        <div class = "" style = "width: 80%; margin-left: 18.9%">
            <a href="CreateCategory" 
               class="btn btn-success d-flex align-items-center shadow rounded-pill px-3 py-2"
               style="margin-left: 91%; margin-top: 5%; margin-bottom: 1%; width: fit-content;">

                <img src="https://cdn0.iconfinder.com/data/icons/round-ui-icons/512/add_blue.png" 
                     alt="Add icon" 
                     style="width: 20px; height: 20px; margin-right: 8px; filter: brightness(0) invert(1);">

                <span style="color: white; font-weight: 500; font-size: 16px;">Add</span>
            </a>

            <%
                if (categoryList != null) {
            %>
            <table class="table table-striped table-hover">
                <tr class = "tableRow">
                    <td class ="tieuDe" style = "text-align: center">ID</td>
                    <td class ="tieuDe" style = "text-align: center">Category Name</td>
                    <td class ="tieuDe" style = "text-align: center">Description</td>
                    <td class ="tieuDe" style = "text-align: center">Quantity</td>
                    <td class ="tieuDe" style = "text-align: center">Created Date</td>
                    <td class ="tieuDe" style = "text-align: center">Action</td>
                </tr>
                <%
                    for (Category cate : categoryList) {
                        if (cate.getIsActive()) {
                %>
                <tr>
                    <td><%= cate.getCategoryId()%></td>
                    <td><%= cate.getCategoryName()%></td>
                    <td><%= cate.getDescriptionCategory()%></td>
                    <td><%= 50%></td>
                    <td><%= cate.getCreatedAt()%></td>


                    <td>
                        <a href="CategoryDetail?categoryId=<%= cate.getCategoryId()%>" class="btn btn-warning" style="color: white;"><i class="bi bi-tools"></i> Detail</a>
                        <a href="UpdateCategory?categoryId=<%= cate.getCategoryId()%>" class="btn btn-primary" ><i class="bi bi-tools"></i> Edit</a>
                        <button class="btn btn-danger" onclick="confirmDelete(<%= cate.getCategoryId()%>)">Delete</button>
                    </td>
                </tr>

                <%
                        }
                    }
                %>
            </table>
            <%
                } else {
                    out.println("No Data!");
                }
            %>
        </div>

    </body>
</html>


<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<script>
    window.onload = function () {
    <% if ("1".equals(success)) { %>
        Swal.fire({
            icon: 'success',
            title: 'Deleted!',
            text: 'The category has been hidden.',
            timer: 2000
        });
    <% } else if ("1".equals(error)) { %>
        Swal.fire({
            icon: 'error',
            title: 'Failed!',
            text: 'Could not hide the category.',
            timer: 2000
        });
    <% }%>
    };
</script>

