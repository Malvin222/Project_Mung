<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>주문 정보 상세페이지</title>
</head>
<body>

<div class="items-container">
    <table>
        <tr>
            <th>상품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>총 가격</th>
        </tr>
        <c:set var="totalPrice" value="0" />
        <c:forEach var="item" items="${cart}">
            <tr>
                <td>${item.dogfoodname}</td>
                <td>${item.dogfoodprice}</td>
                <td>${item.itemcnt}</td>
                <td>${item.totalprice}</td>
                <c:set var="totalPrice" value="${totalPrice + item.totalprice}" />
            </tr>
        </c:forEach>
    </table>
</div>

<div class="total-price-container">
    <table>
        <tr align="right">
            <td><h2 class="total-price"> 총 결제금액 ${totalPrice}원</h2></td>
        </tr>
    </table>
</div>

</body>
</html>
