<%-- 
    Document   : createCategory
    Created on : Jun 15, 2025, 12:44:49 AM
    Author     : HP - Gia Khiêm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String createSuccess = (String) request.getAttribute("createSuccess");
    String createError = (String) request.getAttribute("createError");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/createCategory.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/updateCategory.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <div style="display: flex; align-items: center; gap: 10px; margin-left: 21.5%; margin-bottom: 3%;  margin-top: 3%">
            <h1 class = "display-5 fw-bold" style="font-size: 320%; margin: 0;">Category</h1>
            <span style="font-size: 120%; color: gray; margin-top: 4%;">Add New Category</span>
        </div>

        <!--            <== Category name==>-->
        <div style = "margin-left: 21.5%; border-radius: 12px; border: 1px solid #ccc; width: 75%; margin-bottom: 3%; ">

        </div>
        <!--            <== Category name==>-->

        <!--            <== Category detail==>-->
        <div style="margin-left: 21.5%; border-radius: 12px; border: 1px solid #ccc; width: 75%;">

            <form action="CreateCategory" method="post">
                <div>
                    <div class="form-row" style = "margin-bottom: 2%">
                        <label for="categoryName">Category Name:</label>
                        <input type="text"
                               id="categoryName"
                               name="categoryName"
                               class="input-category" />
                    </div>

                    <div class="form-row">
                        <label for="description">Description:</label>
                        <input type="text"
                               id="description"
                               name="description"
                               class="input-category" />
                    </div>
                </div>
                <div>
                    <div id="groupWrapper"></div>
                    <button type="button" onclick="addGroup()">+ Add Detail Group</button><br><br>

                    <button type="submit">Add</button>
                </div>
            </form>

        </div>
        <!--            <== Category detail==>-->

    </body>
</html>

<script>
    let groupCount = 0;

    function addGroup() {
        groupCount++;
        const groupDiv = document.createElement('div');
        groupDiv.classList.add('group-container');

        groupDiv.innerHTML = `
               <div style="margin-bottom: 8px;">
                   <label>Detail Group Name:</label>
<input type="text" name="groups[${groupCount}][name]" class="input-category" required maxlength="500" />
                   <button type="button" onclick="addDetail(this, ${groupCount})">+ Add Detail</button>
                   <button type="button" onclick="this.parentElement.parentElement.remove()">❌ Remove Group</button>
               </div>
               <div class="detail-list"></div>
           `;
        document.getElementById('groupWrapper').appendChild(groupDiv);
    }

    function addDetail(button, groupIndex) {
        const detailDiv = document.createElement('div');
        detailDiv.classList.add('detail-input');

        detailDiv.innerHTML = `
               <input type="text" name="groups[${groupIndex}][details][]" class="input-category" required maxlength="500"/>
               <button type="button" onclick="this.parentElement.remove()">❌</button>
           `;
        button.parentElement.parentElement.querySelector('.detail-list').appendChild(detailDiv);
    }

    window.onload = function () {
    <% if ("1".equals(createSuccess)) { %>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: 'Category has been added.',
            timer: 2000,
            showConfirmButton: false
        });
    <% } else if ("1".equals(createError)) { %>
        Swal.fire({
            icon: 'error',
            title: 'Failed!',
            text: 'Could not add category.',
            timer: 2000,
            showConfirmButton: false
        });
    <% }%>
    };
</script>
