<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Address" %>
<%
    List<Address> addressList = (List<Address>) request.getAttribute("addressList");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My addresses</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        html, body { height: 100%; margin: 0; padding: 0; }
        body { min-height: 100vh; display: flex; flex-direction: column; }
        .main-content { flex: 1 0 auto; }
        .site-footer { flex-shrink: 0; }
        .add-address-btn { background: #f44336; color: #fff; border: none; border-radius: 6px; padding: 5px 15px; font-size: 15px; float: right; }
        .address-row { padding: 15px 0 10px 0; border-bottom: 1px solid #eee; }
        .address-actions a { margin-right: 18px; text-decoration: none; font-size: 15px; }
        .address-actions .delete-link { color: #f44336; }
        .default-label { color: #f44336; font-weight: bold; margin-bottom: 5px; display: inline-block; }
        .set-default-link { color: #888; font-size: 14px; margin-left: 12px; cursor: pointer; text-decoration: underline; }
        .update-link { color: #0d6efd; }
        .my-addresses-title { margin-bottom: 24px; margin-top: 24px; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

    <div class="container main-content" style="max-width: 780px;">
        <div class="my-addresses-title">
            <h3 style="display:inline;">My addresses</h3>
            <a href="AddAddress" class="add-address-btn float-end">+ Add address</a>
            <div style="clear:both"></div>
        </div>
        <h6 style="color:#333; margin-bottom:12px;">Address</h6>
        <div>
            <% if (addressList != null && addressList.size() > 0) {
                for (Address addr : addressList) { %>
                <div class="address-row" data-address-id="<%=addr.getAddressId()%>">
                    <div>
                        <%= addr.getAddressDetails()%>, 
                        <%= addr.getWardName()%>, 
                        <%= addr.getDistrictName()%>, 
                        <%= addr.getProvinceName()%>
                    </div>
                    <% if (addr.isDefault()) { %>
                        <div class="default-label">Default</div>
                    <% } %>
                    <div class="address-actions" style="margin-top:5px;">
                        <a class="update-link" href="UpdateAddress?id=<%=addr.getAddressId()%>">Update</a>
                        <% if (!addr.isDefault()) { %>
                            <a class="delete-link delete-btn" 
                               href="#" 
                               data-address-id="<%=addr.getAddressId()%>" 
                               data-address-detail="<%=addr.getAddressDetails()%>">
                                Delete
                            </a>
                            <span class="set-default-link" onclick="window.location = 'SetDefaultAddress?id=<%=addr.getAddressId()%>'">
                                Set as default
                            </span>
                        <% } %>
                    </div>
                </div>
            <% }
            } else { %>
                <div>No address found. Please add your address!</div>
            <% } %>
        </div>
    </div>

    <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

    <!-- SweetAlert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
    window.onload = function () {
        // Xử lý nút xóa
        document.querySelectorAll('.delete-btn').forEach(function(btn) {
            btn.onclick = function(e) {
                e.preventDefault();
                const addressId = btn.getAttribute('data-address-id');
                const detail = btn.getAttribute('data-address-detail');
                Swal.fire({
                    title: 'Delete Address?',
                    html: `<b>${detail}</b><br>Are you sure to delete this address?`,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        fetch('DeleteAddress?id=' + addressId, { method: 'POST' })
                        .then(res => {
                            if (res.ok) {
                                // Xóa luôn dòng giao diện
                                btn.closest('.address-row').remove();
                                Swal.fire('Deleted!', 'Address has been deleted.', 'success');
                            } else {
                                Swal.fire('Error', 'Failed to delete address.', 'error');
                            }
                        }).catch(() => {
                            Swal.fire('Error', 'Something went wrong.', 'error');
                        });
                    }
                });
            };
        });
    };
    </script>
</body>
</html>
