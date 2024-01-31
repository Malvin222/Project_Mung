
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>주문조회</title>
</head>
<body>

<table class="delivery-info">
    <!-- 각 배송지에 대한 루프 -->
    <c:forEach var="order" items="${userOrderList}">
        <tr>
            <td>
                <label for="${order.orderdate}" class="delivery-name">결제완료</label>
                <span class="customer-name">${order.orderdate}</span><br>
                <span class="customer-phone">${order.dogfoodname}
                  <c:if test="${order.countOrder-1 != 0}">
                      외 ${order.countOrder-1}건
                  </c:if>
                </span>
                <br>
                <span class="delivery-address">${order.totalprice}</span>
                <button type="button" id="orderDetail" onclick="location='/dog/orderDetail/${order.orderid}'">결제상세</button>

            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
