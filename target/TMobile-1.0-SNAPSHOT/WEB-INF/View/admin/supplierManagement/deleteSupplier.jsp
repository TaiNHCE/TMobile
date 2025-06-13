<%-- 
    Document   : deleteSupplier
    Created on : Jun 13, 2025, 5:38:03 PM
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String supplierID = (String) request.getAttribute("supplierID");
    String taxId = (String) request.getAttribute("taxId");

    if (supplierID == null) {
        supplierID = request.getParameter("supplierID");
    }
    if (taxId == null) {
        taxId = request.getParameter("taxId");
    }

    if (supplierID == null || taxId == null) {
        response.sendRedirect("ViewSupplier");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delete Supplier</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/deleteSupplier.css">

    </head>
    <body>
        <div class="delete-container">
            <div class="delete-icon">⚠️</div>
            <div class="delete-title">Confirm Delete</div>
            <div class="delete-msg">
                Are you sure you want to delete this supplier?
            </div>

            <div class="supplier-info">
                <strong>Tax ID:</strong> <%= taxId%>
            </div>

            <div class="warning-text">
                This action cannot be undone!
            </div>

            <form method="post" action="DeleteSupplier" style="display:inline;">
                <input type="hidden" name="supplierID" value="<%= supplierID%>"/>
                <div class="btn-group">
                    <button type="submit" class="btn btn-delete">
                        Delete
                    </button>
                    <button type="button" class="btn btn-cancel" 
                            onclick="window.location = 'ViewSupplier'">
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    </body>
</html>