<%-- 
    Document   : feedback
    Created on : Jul 21, 2025, 2:59:04 PM
    Author     : VinhNTCE181630
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
          <%-- ⭐ Feedback Section Start --%>
                <div class="customerFeedbackSection" style="margin-top: 30px; background: #fff; padding: 20px; border-radius: 12px; box-shadow: 0 0 8px rgba(0,0,0,0.05);">
                    <div style="text-align: center; margin-bottom: 20px; position: relative;">
                        <hr style="border: none; height: 1px; background: #ddd;">
                        <h2 style="font-size: 20px; font-weight: bold; margin: -15px auto 0; background: #fff; display: inline-block; padding: 0 15px; color: #333;">
                            Customer Feedback
                        </h2>
                    </div>

                    <c:if test="${empty productRatings}">
                        <p style="text-align: center; color: gray;">No feedback available for this product.</p>
                    </c:if>

                    <c:forEach var="rating" items="${productRatings}">
                        <div style="border: 1px solid #e1e1e1; border-radius: 8px; padding: 15px; margin-bottom: 20px; background: #fafafa;">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <strong>${rating.fullName}</strong> 

                                <small style="color: gray;">${rating.createdDate}</small>
                            </div>

                            <div style="color: #f5a623; margin: 5px 0;">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fa fa-star <c:if test='${i <= rating.star}'>checked</c:if>'"></i>
                                </c:forEach>
                            </div>

                            <p style="margin-top: 8px; font-size: 15px;">${rating.comment}</p>

                            <%-- ✅ Nếu có phản hồi từ nhân viên --%>
                            <c:if test="${not empty rating.replies}">
                                <div style="margin-top: 15px; padding: 10px 15px; background: #eaf4ff; border-left: 4px solid #3399ff; border-radius: 6px;">
                                    <strong style="color: #004a99;">Staff Response:</strong>
                                    <c:forEach var="reply" items="${rating.replies}">
                                        <p style="margin: 6px 0; font-size: 14px; color: #333;">${reply.answer}</p>
                                        
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
                <%-- ⭐ Feedback Section End --%>
    </body>
</html>
