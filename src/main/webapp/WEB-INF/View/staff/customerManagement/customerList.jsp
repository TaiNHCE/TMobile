<%-- 
    Document   : customerList
    Created on : Jun 9, 2025, 1:21:22 PM
    Author     : pc
--%>

<%@page import="java.util.List"%>
<%@page import="model.Customer"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css">
    </head>
    <body>
        <div class="container">
            <div class="wrapper">
                <main class="main-content">
                    <h1>Customer List</h1>
                    <form class="search-form" action="CustomerList" method="get">        
                        <input type="text" name="keyword" class="form-control" placeholder="Search customer by name">
                        <input type="hidden" name="action" value="search">
                        <button type="submit" class="search-btn">Search</button>
                    </form>
                <table aria-label="Staff table">
                    <th>ID</th>
                    <th>Email</th>
                    <th>Full Name</th>
                    <th>Phone</th>
                    <th>Created At</th>
                    <th>Status</th>
                    <th>Action</th>
                    </tr>
                    <%
                        List<Customer> cusList = (List<Customer>) request.getAttribute("userList");
                        for (Customer cus : cusList) {
                    %>
                    <tr>
                        <td><%= cus.getId()%></td>
                        <td><%= cus.getEmail()%></td>
                        <td><%= cus.getFullName()%></td>
                        <td><%= cus.getPhone()%></td>
                        <%
                            Date createdAt = cus.getCreateAt();
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                            String formattedDate = sdf.format(createdAt);
                        %>
                        <td><%= formattedDate%></td>
                        <td><%= cus.isActive() ? "Active" : "Block"%></td>
                        <td class="action-col">
                            <a href="#"
                               class="btn btn-warning"
                               onclick="confirmStatusChange(<%=cus.getId()%>,<%=cus.isActive()%>, '<%=cus.getFullName()%>')">
                                Change Status
                            </a>
                            <a href="CustomerList?action=detail&id=<%= cus.getId()%>" class="btn btn-primary">Detail</a>   
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null && !error.isEmpty()) {
                %>
                <div class="container">
                    <div class="alert alert-danger" role="alert">
                        <%= error%>
                    </div>
                </div>
                <%
                    }
                %>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                   function confirmStatusChange(customerId, currentStatus, fullName) {

                                       const actionUpper = currentStatus ? "Block" : "Unblock";
                                       const statusText = currentStatus
                                               ? `This user ${fullName} will be Blocked.`
                                               : `This user ${fullName} will be Unblocked.`;

                                       console.log("ID:", customerId);
                                       console.log("Full name:", fullName);
                                       console.log("Status Text:", statusText);

                                       Swal.fire({
                                           title: 'Are you sure?',
                                           text: statusText,
                                           icon: 'warning',
                                           showCancelButton: true,
                                           confirmButtonColor: '#d33',
                                           cancelButtonColor: '#3085d6',
                                           confirmButtonText: actionUpper,
                                           cancelButtonText: 'Cancel'
                                       }).then((result) => {
                                           if (result.isConfirmed) {
                                               window.location.href = 'CustomerList?action=changeStatus&id=' + customerId;
                                           }
                                       });
                                   }



        </script>
    </body>
</html>
