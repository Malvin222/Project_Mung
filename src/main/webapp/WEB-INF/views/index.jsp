<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<html>
<head>
    <title>메인</title>
    <style>
        body {
            background: #f1eee9;
            margin: 0; /* body의 기본 마진을 제거하여 전체 화면을 채우도록 설정 (선택적) */
            padding: 0; /* body의 기본 패딩을 제거하여 전체 화면을 채우도록 설정 (선택적) */
            font-family: "Noto Sans KR ExtraLight";
            color: #4b4a4a;
        }

        .main-logo {
            margin-top: 50px;
            align-items: center;

        }


        /* Footer 스타일 */
        footer {
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

    </style>
</head>
<body>

<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/dog/dogFoodSearch"><img src="/imgs/m2.png" width="100"></a><br>
</div>

<div align="center">
    <c:choose>
        <c:when test="${empty sessionScope.user}">
            <a href="/user/join">회원가입</a>
            <a href="/user/login">로그인</a>
            <a href="/oauth2/authorization/kakao">카카오로그인</a>
        </c:when>
        <c:otherwise>
            <a href="/user/logout">로그아웃</a>
        </c:otherwise>
    </c:choose>
</div>
<div>
    <c:if test="${not empty sessionScope.user}">
        <h2>로그인된 사용자 정보</h2>
        <p>사용자 아이디: ${sessionScope.user.userid}</p>
        <p>사용자 이름: ${sessionScope.user.username}</p>
        <!-- 기타 사용자 정보를 필요에 따라 출력 -->
    </c:if>
</div>


<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>


</body>
</html>
