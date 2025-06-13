<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Suppliers" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <title>Supplier Detail</title>
        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList.css">

    </head>
    <body>
        <div class="container mt-5">
            <div class="card mx-auto shadow" style="max-width: 600px;">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Supplier Detail</h4>
                </div>
                <div class="card-body">
                    <%
                        Suppliers supplier = (Suppliers) request.getAttribute("supplier");
                        if (supplier != null) {
                    %>
                    <table class="table table-borderless">
                        <tr>
                            <th>Tax ID:</th>
                            <td><%= supplier.getTaxId()%></td>
                        </tr>
                        <tr>
                            <th>Name:</th>
                            <td><%= supplier.getName()%></td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td><%= supplier.getEmail()%></td>
                        </tr>
                        <tr>
                            <th>Phone Number:</th>
                            <td><%= supplier.getPhoneNumber()%></td>
                        </tr>
                        <tr>
                            <th>Address:</th>
                            <td><%= supplier.getAddress()%></td>
                        </tr>
                        <tr>
                            <th>Status:</th>
                            <td>
                                <% if (supplier.getActivate() == 1) { %>
                                <span name="btnacorinac" class="badge bg-success">Active</span>
                                <% } else { %>
                                <span name="btnacorinac" class="badge bg-secondary">Inactive</span>
                                <% }%>
                            </td>
                        </tr>
                    </table>
                    <div class="d-flex justify-content-between mt-4">
                        <a href="ViewSupplier" class="btn btn-outline-primary">
                            <i class="fa fa-arrow-left"></i> Back to List
                        </a>
                        <div>
                            <a href="UpdateSupplier?id=<%= supplier.getSupplierID()%>" class="btn btn-warning">Update</a>
                            <form action="DeleteSupplier" method="get" style="display:inline;">
                                <input type="hidden" name="supplierID" value="<%= supplier.getSupplierID()%>"/>
                                <input type="hidden" name="taxId" value="<%= supplier.getTaxId()%>"/>
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </div>
                    </div>
                    <%
                    } else {
                    %>
                    <div class="alert alert-danger">Supplier not found!</div>
                    <a href="ViewSupplier" class="btn btn-outline-primary">
                        <i class="fa fa-arrow-left"></i> Back to List
                    </a>
                    <% }%>
                </div>
            </div>
        </div>
    </body>
</html>
