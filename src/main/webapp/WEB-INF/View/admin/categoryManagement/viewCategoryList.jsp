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
        <div>
            <h1 class = "col-md-9 divInfo">
                Category Management
            </h1>
        </div>
        <div class = "col-md-9 divInfo">
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
                %>
                <tr>
                    <td><%= cate.getCategoryId()%></td>
                    <td><%= cate.getCategoryName()%></td>
                    <td><%= cate.getDescriptionCategory()%></td>
                    <td><%= 50%></td>
                    <td><%= cate.getCreatedAt()%></td>
                    

                    <td>
                        <a href="" class="btn btn-primary"><i class="bi bi-tools"></i> Edit</a>
                        <a href="" class="btn btn-danger"><i class="bi bi-trash"></i> Delete</a>
                    </td>
                </tr>

                <%
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
