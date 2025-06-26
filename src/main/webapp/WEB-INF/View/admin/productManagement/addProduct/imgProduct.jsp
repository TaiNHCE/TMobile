<%-- 
    Document   : imgProduct
    Created on : Jun 24, 2025, 10:43:21 AM
    Author     : HP - Gia Khiêm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    </head>
    <body>
        <div style="width: 30%; background-color: #ffffff; padding: 16px; border-radius: 15px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); height: 500px; max-height: 500px;">

            <!-- Ảnh lớn - KHÔNG CÓ nền trắng -->
            <div class="text-center divAnhLon"
                 style="margin-left: 5%; width: 90%; margin-bottom: 16px; border-radius: 15px; height: 400px">
                <label for="fileInputMain" style="cursor: pointer; height: 100%">
                    <img id="previewMainImage" src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"
                         style="width: 100%; object-fit: cover; border-radius: 10px; height: 100%"
                         alt="Click to change image"
                         title="Click to change image">
                </label>
                <input type="file" name="fileMain" id="fileInputMain" accept="image/*"
                       style="display: none;" onchange="previewSelectedImage(this, 'previewMainImage')">
            </div>


            <!-- 4 ảnh nhỏ -->
            <div class="d-flex flex-wrap gap-3 div4AnhNho" style="width: 100%; margin-top: 8px; justify-content: center; display: flex">

                <!-- Ảnh nhỏ 1 -->
                <div class="text-center"
                     style="border: 1px solid #ccc; border-radius: 12px; max-height: 50px; width: 20%; ">
                    <label for="fileInput1" style="cursor: pointer; height: 100%">
                        <img id="previewImage1" src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"
                             style="width: 100%; object-fit: cover; border-radius: 10px; max-height: 100%"
                             alt="Click to change image"
                             title="Click to change image">
                    </label>
                    <input type="file" name="file1" id="fileInput1" accept="image/*"
                           style="display: none;" onchange="previewSelectedImage(this, 'previewImage1')">
                </div>

                <!-- Ảnh nhỏ 2 -->
                <div class=" text-center"
                     style="border: 1px solid #ccc; border-radius: 12px; max-height: 50px; width: 20%;">
                    <label for="fileInput2" style="cursor: pointer; height: 100%">
                        <img id="previewImage2" src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"
                             style="width: 100%; object-fit: cover; border-radius: 10px; max-height: 100%"
                             alt="Click to change image"
                             title="Click to change image">
                    </label>
                    <input type="file" name="file2" id="fileInput2" accept="image/*"
                           style="display: none;" onchange="previewSelectedImage(this, 'previewImage2')">
                </div>

                <!-- Ảnh nhỏ 3 -->
                <div class=" text-center"
                     style="border: 1px solid #ccc; border-radius: 12px; max-height: 50px; width: 20%;">
                    <label for="fileInput3" style="cursor: pointer; height: 100%">
                        <img id="previewImage3" src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"
                             style="width: 100%; object-fit: cover; border-radius: 10px; max-height: 100%"
                             alt="Click to change image"
                             title="Click to change image">
                    </label>
                    <input type="file" name="file3" id="fileInput3" accept="image/*"
                           style="display: none;" onchange="previewSelectedImage(this, 'previewImage3')">
                </div>

                <!-- Ảnh nhỏ 4 -->
                <div class=" text-center"
                     style="border: 1px solid #ccc; border-radius: 12px; max-height: 50px; width: 20%;">
                    <label for="fileInput4" style="cursor: pointer; height: 100%">
                        <img id="previewImage4" src="https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png"
                             style="width: 100%; object-fit: cover; border-radius: 10px; max-height: 100%"
                             alt="Click to change image"
                             title="Click to change image">
                    </label>
                    <input type="file" name="file4" id="fileInput4" accept="image/*"
                           style="display: none;" onchange="previewSelectedImage(this, 'previewImage4')">
                </div>
            </div>
        </div>
    </body>

    <script>

        function previewSelectedImage(input, imgId) {
            const preview = document.getElementById(imgId);
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }


        window.onload = function () {
            const urlParams = new URLSearchParams(window.location.search);
            const success = urlParams.get("success");
            const error = urlParams.get("error");
            if (success === "1") {
                Swal.fire({
                    icon: 'success',
                    title: 'Update Successful!',
                    text: 'The product information has been updated.',
                    timer: 2000,
                    showConfirmButton: false
                });
            }

            if (error === "1") {
                Swal.fire({
                    icon: 'error',
                    title: 'Update Failed!',
                    text: 'Unable to update the product. Please try again.',
                    timer: 2000,
                    showConfirmButton: false
                });
            }
        };

        function toggleDetails(index) {
            const detailGroup = document.getElementById("detailGroup" + index);
            const arrowIcon = document.getElementById("arrow" + index);

            if (detailGroup.classList.contains("hidden")) {
                detailGroup.classList.remove("hidden");
                arrowIcon.innerText = "▲"; // hoặc dùng ▾ nếu thích
            } else {
                detailGroup.classList.add("hidden");
                arrowIcon.innerText = "▼";
            }
        }
    </script>
</html>
