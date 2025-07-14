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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-content {
            flex: 1 0 auto;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 50px 0 40px 0;
        }
        .address-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.10);
            padding: 40px 40px 30px 40px;
            width: 100%;
            max-width: 700px;
            border: none;
        }
        .address-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 25px 30px 20px 30px;
            margin: -40px -40px 30px -40px;
            border: none;
            box-shadow: 0 6px 12px -8px #aaa3;
        }
        .address-header h3 {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
        }
        .add-address-btn {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 8px 24px;
            font-size: 16px;
            font-weight: 600;
            float: right;
            transition: all 0.2s;
            margin-left: 20px;
        }
        .add-address-btn:hover {
            background: linear-gradient(135deg, #0bb485 0%, #22ce61 100%);
            color: #fff;
        }
        .address-row {
            padding: 18px 0 14px 0;
            border-bottom: 1px solid #eee;
            font-size: 17px;
        }
        .address-row:last-child { border-bottom: none; }
        .address-actions a {
            margin-right: 18px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
        }
        .address-actions .delete-link { color: #f44336; }
        .default-label {
            color: #f44336;
            font-weight: bold;
            margin-bottom: 5px;
            display: inline-block;
            font-size: 16px;
        }
        .set-default-link {
            color: #888;
            font-size: 15px;
            margin-left: 16px;
            cursor: pointer;
            text-decoration: underline;
        }
        .update-link { color: #0d6efd; }
        .no-address-found {
            color: #ff6b6b;
            font-size: 18px;
            margin: 30px 0 0 10px;
            font-style: italic;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

    <div class="main-content">
        <div class="address-card">
            <div class="address-header d-flex justify-content-between align-items-center">
                <h3 style="display:inline; margin-bottom:0;">
                    <i class="bi bi-geo-alt-fill me-2"></i>
                    My Addresses
                </h3>
                <a href="AddAddress" class="add-address-btn">
                    <i class="bi bi-plus-lg me-1"></i> Add Address
                </a>
            </div>
            <h6 style="color:#333; margin-bottom:20px; margin-top:6px; font-weight:500;">Your Saved Addresses</h6>
            <div>
                <% if (addressList != null && addressList.size() > 0) {
                    for (Address addr : addressList) { %>
                    <div class="address-row" data-address-id="<%=addr.getAddressId()%>">
                        <div>
                            <strong><%= addr.getAddressDetails()%></strong>,
                            <%= addr.getWardName()%>,
                            <%= addr.getDistrictName()%>,
                            <%= addr.getProvinceName()%>
                        </div>
                        <% if (addr.isDefault()) { %>
                            <div class="default-label">Default</div>
                        <% } %>
                        <div class="address-actions mt-2">
                            <a class="update-link" href="UpdateAddress?id=<%=addr.getAddressId()%>">
                                <i class="bi bi-pencil-square"></i> Update
                            </a>
                            <% if (!addr.isDefault()) { %>
                                <a class="delete-link delete-btn"
                                   href="#"
                                   data-address-id="<%=addr.getAddressId()%>"
                                   data-address-detail="<%=addr.getAddressDetails()%>">
                                    <i class="bi bi-trash"></i> Delete
                                </a>
                                <span class="set-default-link" onclick="window.location = 'SetDefaultAddress?id=<%=addr.getAddressId()%>'">
                                    <i class="bi bi-star"></i> Set as default
                                </span>
                            <% } %>
                        </div>
                    </div>
                <% }
                } else { %>
                    <div class="no-address-found">
                        <i class="bi bi-emoji-frown"></i> No address found. Please add your address!
                    </div>
                <% } %>
            </div>
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
