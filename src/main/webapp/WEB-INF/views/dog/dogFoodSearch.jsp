<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>웹페이지 제목</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>

<body>
<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/"><img src="/imgs/mung-logo.png" width="250"></a>
</div>
<!-- 체크 그룹 컨테이너 -->
<div class="checkbox-group-container">
    <!-- 체크 창 -->
    <div class="checkbox-group">
        <p>브랜드</p>
        <c:forEach var="brand" items="${dogfoodBrands}" varStatus="status">
            <c:set var="isChecked" value="${selectedBrands != null and selectedBrands.contains(brand)}" />
            <input type="checkbox" id="brandCheckbox${status.index}" name="selectedBrands" value="${brand}" ${isChecked ? 'checked' : ''}>
            <label for="brandCheckbox${status.index}" class="checkbox-label">${brand}</label>
        </c:forEach>
    </div>

    <div class="checkbox-group">
        <p>나이</p>
        <% String[] ages = {"전연령", "퍼피", "어덜트", "시니어"}; %>
        <% for (int i = 0; i < ages.length; i++) { %>
        <% String age = ages[i]; %>
        <c:set var="isChecked" value="${selectedAges != null and selectedAges.contains(age)}" />
        <input type="checkbox" id="ageCheckbox<%= i %>" name="selectedAges" value="<%= age %>" ${isChecked ? 'checked' : ''}>
        <label for="ageCheckbox<%= i %>" class="checkbox-label"><%= age %></label>
        <% } %>
    </div>

    <div class="checkbox-group">
        <p>특징</p>
        <% String[] features = {"장건강", "치아건강", "관절건강", "하이포알러제닉"}; %>
        <% for (int i = 0; i < features.length; i++) { %>
        <% String feature = features[i]; %>
        <c:set var="isChecked" value="${selectedFeatures != null and selectedFeatures.contains(feature)}" />
        <input type="checkbox" id="featureCheckbox<%= i %>" name="selectedFeatures" value="<%= feature %>" ${isChecked ? 'checked' : ''}>
        <label for="featureCheckbox<%= i %>" class="checkbox-label"><%= feature %></label>
        <% } %>
    </div>
</div>

<!-- 검색 폼 -->
<form action="/dog/dogFoodSearch" method="GET" id="searchForm">
    <div class="search-container">
        <input type="text" id="search-input" name="searchKeyword" placeholder="사료 검색하기" value="${searchKeyword}">
        <button class="search-button" type="submit">
            <img src="/imgs/search-icon.png" class="search-icon" width="14">
        </button>
    </div>
</form>

<!-- 검색 결과 리스트 컨테이너 -->
<div class="result-container" id="resultContainer">
    <table class="result-table">
        <thead>
        <tr>
            <th style="width:500px" !important>사료명</th>
            <th>브랜드</th>
            <th>가격</th>
            <th>나이</th>
            <th>특징</th>
            <th>주성분</th>
            <th>용량</th>
            <!-- 다른 필드에 대한 헤더 추가 -->
        </tr>
        </thead>
        <tbody>
        <c:forEach var="dogFood" items="${dogFoodList}">
            <tr class="result-item">
                <td>${dogFood.dogfoodname}</td>
                <td>${dogFood.dogfoodbrand}</td>
                <td>${dogFood.dogfoodprice}</td>
                <td>${dogFood.dogage}</td>
                <td>${dogFood.dogfoodfeat}</td>
                <td>${dogFood.dogfoodnut}</td>
                <td>${dogFood.dogfoodwei}</td>
                <!-- 추가로 필요한 정보들을 포함할 수 있습니다. -->
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

<script>
    $(document).ready(function() {
        // 선택된 체크박스에 대한 hidden input을 업데이트하는 함수
        function updateHiddenInput(checkboxes, hiddenInputName) {
            var selectedItems = checkboxes.map(function() {
                return this.value;
            }).get();

            // 기존의 hidden input 업데이트
            $('#searchForm input[name="' + hiddenInputName + '"]').remove();

            for (var i = 0; i < selectedItems.length; i++) {
                $('<input>').attr({
                    type: 'hidden',
                    name: hiddenInputName,
                    value: selectedItems[i]
                }).appendTo('#searchForm');
            }
        }

        // 브랜드 체크박스에 대한 이벤트 핸들러
        $('input[name="selectedBrands"]').change(function() {
            updateHiddenInput($('input[name="selectedBrands"]:checked'), 'selectedBrands');
        });

        // 나이대 체크박스에 대한 이벤트 핸들러
        $('input[name="selectedAges"]').change(function() {
            updateHiddenInput($('input[name="selectedAges"]:checked'), 'selectedAges');
        });

        // 특징 체크박스에 대한 이벤트 핸들러
        $('input[name="selectedFeatures"]').change(function() {
            updateHiddenInput($('input[name="selectedFeatures"]:checked'), 'selectedFeatures');
        });
    });
</script>

<script>
    function goToPage(pageNumber) {
        // 페이지 범위 확인
        if (pageNumber >= 1 && pageNumber <= ${totalPage}) {
            var pageSize = 10;

            // 검색어와 체크된 브랜드, 나이대, 특징 정보 전송
            $.ajax({
                url: "/dog/dogFoodSearch",
                type: "GET",
                data: {
                    page: pageNumber,
                    pageSize: pageSize,
                    searchKeyword: document.getElementById('search-input').value,
                    selectedBrands: $('input[name="selectedBrands"]:checked').map(function () { return this.value; }).get(),
                    selectedAges: $('input[name="selectedAges"]:checked').map(function () { return this.value; }).get(),
                    selectedFeatures: $('input[name="selectedFeatures"]:checked').map(function () { return this.value; }).get()
                },
                success: function (data) {
                    // 페이지 이동만 처리
                    //$('#resultContainer').html(data);

                    // 현재 URL 파싱
                    var currentUrl = new URL(window.location.href);

                    // 페이지 번호 업데이트 또는 추가
                    currentUrl.searchParams.set('page', pageNumber);

                    // 새로운 URL로 변경
                    window.history.pushState({ page: pageNumber }, null, decodeURIComponent(currentUrl.href));
                    location.reload();
                },
                error: function () {
                    alert('페이지 이동 중 오류가 발생했습니다.');
                }
            });
        }
    }
</script>






</html>
