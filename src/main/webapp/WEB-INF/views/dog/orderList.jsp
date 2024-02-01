
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>주문조회</title>
    <link rel="stylesheet" type="text/css" href="/css/order.css">
</head>

<%-- 로그인 --%>
<div class="login-container">
        <div><a href="/dog/dogFoodSearch"><img src="/imgs/home.png" height="40px"></a></div>
        <div><a href="/dog/orderList"><img src="/imgs/user.png" height="40px"></a></div>
        <div><a href="/dog/cart"><img src="/imgs/shopping-cart.png" height="40px"></a></div>
</div>

<div class="login-container">
    <c:if test="${not empty sessionScope.user}">
    <div>${sessionScope.user.userid}</div>
        <div>|</div>
        <div id="logout"><a href="/user/logout">로그아웃</a></div>
    </c:if>
    <c:if test="${empty sessionScope.user}">
        <script>
            window.location.href = "/user/login";
        </script>
    </c:if>
</div>

<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/dog/dogFoodSearch"><img src="/imgs/mung-logo.png" width="250"></a>
</div>

<div class="orderList-h2-container">
    <h2>주문내역</h2>
</div>

<table class="order-info">
    <!-- 각 배송지에 대한 루프 -->
    <c:forEach var="order" items="${userOrderList}">
        <tr>
            <td align="center">
                <label for="${order.orderdate}" class="order-status">결제완료</label>
            </td>
            <td>
                <button type="button" class="orderDetail" onclick="location='/dog/orderDetail/${order.orderid}'">결제상세</button>
                <div class="order-date">${order.orderdate}<span> 결제</span></div>
                <div class="order-item">${order.dogfoodname}
                    <c:if test="${order.countOrder-1 != 0}">
                        외 ${order.countOrder-1}건
                    </c:if>
                </div>
                <div class="order-price">${order.totalprice}<span>원</span></div>
            </td>
        </tr>
    </c:forEach>
</table>

<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>

</body>


</html>
