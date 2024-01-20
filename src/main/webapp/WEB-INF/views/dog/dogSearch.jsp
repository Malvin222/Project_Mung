<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<html>
<head>
    <title>강아지 사료 검색</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>

<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/"><img src="/imgs/mung-logo.png" width="250"></a>
</div>

<!-- 검색 폼 -->
<form action="/dog/dogSearch" method="GET" id="searchForm">
    <div class="search-container">
        <input type="text" id="search-input" name="searchKeyword" placeholder="사료 검색하기">
        <button class="search-button" type="submit">
            <img src="/imgs/search-icon.png" class="search-icon" width="14">
        </button>
    </div>
</form>

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
<div class="result-container" id="resultContainer">
    <table class="result-table">
        <thead>
        <tr>
            <th>사료명</th>
            <th>브랜드</th>
            <th>가격</th>
            <!-- 다른 필드에 대한 헤더 추가 -->
        </tr>
        </thead>
        <tbody>
        <c:forEach var="dogFood" items="${dogFoodList}">
            <c:if test="${fn:containsIgnoreCase(dogFood.dogfoodname, searchKeyword) or fn:containsIgnoreCase(dogFood.dogfoodbrand, searchKeyword)}">
                <tr class="result-item">
                    <td>${dogFood.dogfoodname}</td>
                    <td>${dogFood.dogfoodbrand}</td>
                    <td>${dogFood.dogfoodprice}</td>
                    <!-- 추가로 필요한 정보들을 포함할 수 있습니다. -->
                </tr>
            </c:if>
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

<script>
    function performSearch() {
        var searchKeyword = document.getElementById('search-input').value;
        var pageSize = 10;

        // 체크된 브랜드 체크박스 값을 가져오기
        var selectedBrands = [];
        var brandCheckboxes = document.querySelectorAll('input[name="dogfoodbrand"]:checked');
        brandCheckboxes.forEach(function (checkbox) {
            selectedBrands.push(checkbox.value);
        });

        $.ajax({
            url: "/dog/dogSearch",
            type: "GET",
            data: {
                page: 1,
                pageSize: pageSize,
                searchKeyword: searchKeyword,
                selectedBrands: selectedBrands
            },
            success: function (data) {
                // 페이지 이동만 처리
                $('#resultContainer').html(data);
            },
            error: function () {
                alert('페이지 이동 중 오류가 발생했습니다.');
            }
        });
    }

    function goToPage(pageNumber) {
        // 페이지 범위 확인
        if (pageNumber >= 1 && pageNumber <= ${totalPage}) {
            var pageSize = 10;

            // 검색어와 체크된 브랜드 정보 전송
            $.ajax({
                url: "/dog/dogSearch",
                type: "GET",
                data: {
                    page: pageNumber,
                    pageSize: pageSize,
                    searchKeyword: document.getElementById('search-input').value,
                    selectedBrands: []  // 체크된 브랜드 정보 전송
                },
                success: function (data) {
                    // 페이지 이동만 처리
                    $('#resultContainer').html(data);
                },
                error: function () {
                    alert('페이지 이동 중 오류가 발생했습니다.');
                }
            });
        }
    }
</script>




</html>