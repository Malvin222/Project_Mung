<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>주문 정보 상세페이지</title>
    <link rel="stylesheet" type="text/css" href="/css/order.css">
</head>
<body>
<%-- 로그인 --%>
<div class="login-container">
    <div><a href="/dog/dogFoodSearch"><img src="/imgs/home.png" height="40px"></a></div>
    <div><a href="/dog/orderList"><img src="/imgs/user.png" height="40px"></a></div>
    <div><a href="/dog/cart"><img src="/imgs/shopping-cart.png" height="40px"></a></div>
</div>

<div class="login-container">
    <c:if test="${not empty sessionScope.user}">
        <div><a href="/user/modify">${sessionScope.user.userid}</a></div>
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

<div class="h2-container">
    <h2>주문상세</h2>
</div>

<div>
    <table class="order-id">
        <tr>
            <td><span>주문번호</span> ${orderId}</td>
        </tr>
        <c:if test="${not empty cart}">
            <tr>
                <%-- 주문일자를 ISO 8601 형식에서 년-월-일 형태로 변환하여 표시 --%>
                <c:set var="formattedDate" value="${fn:substring(cart[0].orderdate, 0, 10)}" />
                <td><span>주문일자</span> ${formattedDate}</td>
            </tr>
        </c:if>
        <tr>
            <td><span>결제방법</span> ${userOrderList[0].paymentmethod}</td>
        </tr>
    </table>

</div>

<div>
    <table class="items-container">
        <tr align="center">
            <th>상품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>총 가격</th>
        </tr>
        <c:set var="totalPrice" value="0" />
        <c:forEach var="item" items="${cart}">
            <tr>
                <td>${item.dogfoodname}</td>
                <td align="center">${item.dogfoodprice}</td>
                <td align="center">${item.itemcnt}</td>
                <td align="center">${item.totalprice}</td>
                <c:set var="totalPrice" value="${totalPrice + item.totalprice}" />
            </tr>
        </c:forEach>
        <tr align="right">
            <td colspan="4"><h2 class="total-price"> 총 결제금액 ${totalPrice}원</h2></td>
        </tr>
    </table>
</div>

<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>

</body>
</html>
