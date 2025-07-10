<%-- 
    Document   : view-staff-detail
    Created on : Jun 12, 2025, 10:01:59 PM
    Author     : pc
--%>

<%@page import="model.Customer"%>
<%@page import="model.Account"%>
<%@page import="model.Staff"%>
<%

    Customer sta = (Customer) request.getAttribute("cus");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            html, body {
                height: 100%;
            }
            body {
                display: flex;
                flex-direction: column;
            }
            .content {
                flex: 1;
            }
            .error-message {
                color: #dc3545;
                font-size: 0.875rem;
                font-style: italic;
                margin-left: 10px;
                display: inline-block;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

        <div class="content">
            <div class="container-fluid mt-5">
                <div class="card mx-auto shadow" style="max-width: 700px;">        
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Profile</h4>
                    </div>
                    <form method="get" action="ViewProfile?action=list">
                        <div class="card-body">
                            <table class="table table-borderless">
                                <tr>
                                    <th>ID:</th>
                                    <td>
                                        <%= sta.getId()%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Full Name:</th>
                                    <td>
                                        <%= sta.getFullName()%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Phone Number:</th>
                                    <td>
                                        <%= (sta.getPhone() == null || sta.getPhone().isEmpty())
                                                ? "<span class='error-message'>Vui lòng nhập số điện thoại</span>"
                                                : sta.getPhone()%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Email:</th>
                                    <td>
                                        <%= sta.getEmail()%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Date of Birth:</th>
                                    <td>
                                        <%-- Dán đoạn JSP xử lý date ở đây --%>
                                        <%
                                            String birth = sta.getBirthDay();
                                            String birthFormatted = "";
                                            if (birth != null && !birth.isEmpty()) {
                                                try {
                                                    java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                    java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
                                                    java.util.Date birthDate = inputFormat.parse(birth);
                                                    birthFormatted = outputFormat.format(birthDate);
                                                } catch (Exception e) {
                                                    birthFormatted = "Ngày sinh không hợp lệ";
                                                }
                                            }
                                        %>

                                        <%= (birth == null || birth.isEmpty())
                                                ? "<span class='error-message'>Vui lòng nhập ngày tháng năm sinh</span>"
                                                : birthFormatted%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Sex:</th>
                                    <td>
                                        <input type="radio" class="form-check-input" name="sex" value="male"
                                               <%= ("male".equalsIgnoreCase(sta.getGender()) ? "checked" : "")%> disabled /> Male
                                        <input type="radio" class="form-check-input ms-3" name="sex" value="female"
                                               <%= ("female".equalsIgnoreCase(sta.getGender()) ? "checked" : "")%> disabled /> Female

                                        <% if (sta.getGender() == null || sta.getGender().trim().isEmpty()) { %>
                                        <span class="error-message">Vui lòng chọn giới tính</span>
                                        <% }%> 
                                    </td>
                                </tr>
                            </table>
                            <div class="d-flex justify-content-between mt-4">
                                <div>
                                    <a href="ChangePassword" class="btn btn-secondary" ><i class="bi bi-tools"></i> Change Password</a>
                                </div>
                                <div>      
                                    <a href="UpdateProfile?id=<%= sta.getId()%>" class="btn btn-warning">Update</a>
                                </div>
                            </div>
                        </div>
                    </form> <!-- đóng form đúng chỗ -->
                </div> <!-- đóng card -->
            </div> <!-- đóng container -->
        </div> <!-- đóng content -->
        
        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
    </body>
</html>