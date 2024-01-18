<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>강아지 사료 검색</title>
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

        .search-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap; /* 화면 크기가 작아질 때 줄 바꿈이 일어나도록 설정 */
            margin-top: 50px;
            margin-bottom: 30px;
        }

        .search-container input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 300px;
            box-sizing: border-box;
        }

        .search-button {
            padding: 10px;
            background-color: #e3ccc3;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
        }

        .search-icon {
            width: 18px;
            height: 18px;
        }

        .checkbox-group input {
            display: none; /* 실제 체크박스를 숨김 */
        }
        .checkbox-group-container {
            display: flex;
            margin: 20px 20px 20px 20px;
            border: 1px solid #ccc; /* 외곽선 추가 */
            border-radius: 10px; /* 동그라미 모양을 위해 조절 */
            padding: 10px 0px 30px 20px;
            background-color: white;
        }

        .checkbox-group {
            margin-right: 30px; /* 브랜드와 나이 체크박스 그룹 간의 간격 조절 */
        }

        .checkbox-label {
            font-size: 14px;
            padding: 4px 8px; /* 체크박스 스타일을 위한 여백 추가 */
            border: 1px solid #ccc;
            border-radius: 5px;
            cursor: pointer;
            user-select: none;
            margin-bottom: 10px; /* 라벨 간 여백을 늘림 */
            display: inline-block; /* 인라인 요소로 설정 */
        }


        /* 체크박스 체크 상태일 때의 스타일 */
        .checkbox-group input:checked + .checkbox-label {
            background-color: #e3ccc3; /* 체크되었을 때의 배경색 */
        }

        p {
            font-family: "Noto Sans KR SemiBold";
        }

        .result-container {
            margin: 20px 20px 20px 20px;
            background-color: #f9f9f9;
        }

        .result-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 10px;
            padding: 10px;
        }

        .result-item h3 {
            margin-top: 0;
        }

        /* Footer 스타일 */
        footer {
            text-align: center;
            padding: 10px;
            bottom: 0;
            width: 100%;
            z-index: 0; /* Footer가 하위로 내려가도록 z-index 추가 */
        }
        /* 페이징 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            z-index: 1; /* 페이지 버튼이 상위로 올라오도록 z-index 추가 */
        }

        .pagination a {
            color: #4b4a4a;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color 0.3s;
            border: 1px solid #ddd;
            margin: 0 4px;
        }

        .pagination a.active {
            background-color: #e3ccc3;
            color: white;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }


    </style>
</head>
<body>

<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/"><img src="/imgs/mung-logo.png" width="250"></a>
</div>

<!-- 사료 검색창 -->
<div class="search-container">
    <input type="text" placeholder="사료 검색하기">
    <button class="search-button">
        <img src="/imgs/search-icon.png" class="search-icon" width="14">
    </button>
</div>

<!-- 체크 그룹 컨테이너 -->
<div class="checkbox-group-container">

    <!-- 체크 창 -->
    <div class="checkbox-group">
        <p>브랜드</p>

        <% List<String> dogfoodbrands = (List<String>)request.getAttribute("dogfoodbrands"); %>
        <% int batchSize = 8; // 6개씩 자르기 %>
        <% for (int i = 0; i < dogfoodbrands.size(); i += batchSize) { %>
        <div class="brand-batch">
            <% for (int j = i; j < Math.min(i + batchSize, dogfoodbrands.size()); j++) { %>
            <input type="checkbox" id="brandCheckbox<%= j %>" name="dogfoodbrand" value="<%= dogfoodbrands.get(j) %>">
            <label for="brandCheckbox<%= j %>" class="checkbox-label" title="<%= dogfoodbrands.get(j) %>">
                <%= dogfoodbrands.get(j) %>
            </label>
            <% } %>
        </div>
        <% } %>
    </div>


    <div class="checkbox-group">
        <p>나이</p>
        <% String[] ages = {"전 연령용", "퍼피", "어덜트", "시니어"}; %>
        <% for (int i = 0; i < ages.length; i++) { %>
        <input type="checkbox" id="ageCheckbox<%= i %>">
        <label for="ageCheckbox<%= i %>" class="checkbox-label"><%= ages[i] %></label>
        <% } %>
    </div>

    <div class="checkbox-group">
        <p>특징</p>
        <% String[] features = {"장건강", "치아건강", "관절건강", "하이포알러제닉"}; %>
        <% for (int i = 0; i < features.length; i++) { %>
        <input type="checkbox" id="featureCheckbox<%= i %>">
        <label for="featureCheckbox<%= i %>" class="checkbox-label"><%= features[i] %></label>
        <% } %>
    </div>


</div>


<!-- 검색 결과 리스트 컨테이너 -->
<div class="result-container">
    <table class="result-table">
        <thead>
        <tr>
            <th>사료명</th>
            <th>브랜드</th>
            <!-- 다른 필드에 대한 헤더 추가 -->
        </tr>
        </thead>
        <tbody>
        <c:forEach var="dogFood" items="${dogFoodList}">
            <tr class="result-item">
                <td>${dogFood.dogfoodname}</td>
                <td>${dogFood.dogfoodbrand}</td>
                <!-- 다른 필드에 대한 데이터 추가 -->
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- 페이징 처리 -->
<div class="pagination">
    <!-- 이전 페이지로 이동하는 화살표 -->
    <a href="javascript:void(0);" onclick="goToPage(${currentPage - 5})" class="arrow ${currentPage > 1 ? '' : 'disabled'}">❮</a>

    <!-- 페이지 버튼 표시 -->
    <c:forEach var="pageNumber" begin="1" end="${totalPage}" varStatus="loop">
        <c:if test="${pageNumber >= currentPage - 5 && pageNumber <= currentPage + 5}"> <!-- 현재 페이지 기준 전후 5개까지만 표시 -->
            <a href="javascript:void(0);" onclick="goToPage(${pageNumber})" class="page-number ${pageNumber eq currentPage ? 'active' : ''}">${pageNumber}</a>
        </c:if>
    </c:forEach>

    <!-- 다음 페이지로 이동하는 화살표 -->
    <a href="javascript:void(0);" onclick="goToPage(${currentPage + 5})" class="arrow ${currentPage < totalPage ? '' : 'disabled'}">❯</a>
</div>



<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>


</body>
<!-- 페이징 처리 -->
<script>
    function goToPage(pageNumber) {
        // 페이지 범위 확인
        if (pageNumber >= 1 && pageNumber <= ${totalPage}) {
            window.location.href = "/dog/dogSearch?page=" + pageNumber + "&pageSize=10";
        }
        if(pageNumber < 0){
            window.location.href = "/dog/dogSearch?page=1&pageSize=10";
        }
        if(pageNumber > ${totalPage}) {
            window.location.href = "/dog/dogSearch?page=" + ${totalPage} + "&pageSize=10";
        }
    }
</script>

</html>