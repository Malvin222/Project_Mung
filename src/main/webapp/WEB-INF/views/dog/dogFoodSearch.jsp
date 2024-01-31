<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<c:set var="userid" value="${sessionScope.user.userid}"></c:set>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>강아지 사료 검색</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>

<body>

<%-- 로그인 --%>
<div class="login-container">
    <c:if test="${not empty sessionScope.user}">
        <div><a href="/dog/cart">장바구니</a></div>
        <div>|</div>
        <div>${sessionScope.user.userid}</div>
        <div>|</div>
        <div><a href="/user/logout">로그아웃</a></div>
    </c:if>
    <c:if test="${empty sessionScope.user}">
        <script>
            window.location.href = "/user/login";
        </script>
    </c:if>
</div>

<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/"><img src="/imgs/mung-logo.png" width="250"></a>
</div>


<!-- 장바구니 로고 -->
<%--<div class="cart-container-search" align="right">--%>
<%--    <a href="/dog/cart"><img src="/imgs/cart-logo.png" width="50"></a>--%>
<%--</div>--%>



<!-- 체크 그룹 컨테이너 -->
<div class="checkbox-group-container">
    <!-- 체크 창 -->
    <div class="checkbox-group">
        <p>브랜드</p>

        <c:forEach var="brandGroup" items="${dogfoodBrands}" varStatus="status">
            <c:if test="${status.index % 8 == 0}">
                <div class="brand-group">
            </c:if>

            <c:set var="isChecked" value="${selectedBrands != null and selectedBrands.contains(brandGroup)}" />
            <input type="checkbox" id="brandCheckbox${status.index}" name="selectedBrands" value="${brandGroup}" ${isChecked ? 'checked' : ''}>
            <label for="brandCheckbox${status.index}" class="checkbox-label">${brandGroup}</label>

            <c:if test="${(status.index + 1) % 8 == 0 or status.last}">
                </div>
            </c:if>
        </c:forEach>
    </div>


    <div class="checkbox-group">
        <p>연령</p>
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
        <% String[] features = {"장건강", "치아건강", "관절건강", "저알러지", "소화개선", "피부건강", "피모건강", "체중관리", "근육발달", "면역증진"}; %>
        <% for (int i = 0; i < features.length; i++) { %>
        <% String feature = features[i]; %>
        <c:set var="isChecked" value="${selectedFeatures != null and selectedFeatures.contains(feature)}" />
        <input type="checkbox" id="featureCheckbox<%= i %>" name="selectedFeatures" value="<%= feature %>" ${isChecked ? 'checked' : ''}>
        <label for="featureCheckbox<%= i %>" class="checkbox-label"><%= feature %></label>
        <% if ((i + 1) % 5 == 0 || i == features.length - 1) { %>
        <br>
        <% } %>
        <% } %>
    </div>

    <div class="checkbox-group">
        <p>주성분</p>
        <% String[] nutrients = {"닭고기", "소고기", "양고기", "칠면조", "연어", "오리", "고구마", "밀웜", "쌀"}; %>
        <% for (int i = 0; i < nutrients.length; i++) { %>
        <% String nutrient = nutrients[i]; %>
        <c:set var="isChecked" value="${selectedNutrients != null and selectedNutrients.contains(nutrient)}" />
        <input type="checkbox" id="nutrientCheckbox<%= i %>" name="selectedNutrients" value="<%= nutrient %>" ${isChecked ? 'checked' : ''}>
        <label for="nutrientCheckbox<%= i %>" class="checkbox-label"><%= nutrient %></label>
        <% if ((i + 1) % 5 == 0 || i == nutrients.length - 1) { %>
        <br>
        <% } %>
        <% } %>
    </div>

    <div class="checkbox-group">
        <p>가격</p>
        <% String[] prices = {"~1만원", "1만원대", "2만원대", "3만원대", "4만원대", "5만원~"}; %>
        <% for (int i = 0; i < prices.length; i++) { %>
        <% String price = prices[i]; %>
        <c:set var="isChecked" value="${selectedPrices != null and selectedPrices.contains(price)}" />
        <input type="checkbox" id="priceCheckbox<%= i %>" name="selectedPrices" value="<%= price %>" ${isChecked ? 'checked' : ''}>
        <label for="priceCheckbox<%= i %>" class="checkbox-label"><%= price %></label>
        <% if ((i + 1) % 5 == 0 || i == prices.length - 1) { %>
        <br>
        <% } %>
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
            <th style="width:30%" !important>사료명</th>
            <th>브랜드</th>
            <th>연령</th>
            <th style="width:20%" !important>특징</th>
            <th>주성분</th>
            <th>용량</th>
            <th>가격</th>
            <th>장바구니</th>
            <!-- 다른 필드에 대한 헤더 추가 -->
        </tr>
        </thead>
        <tbody>
        <c:forEach var="dogFood" items="${dogFoodList}">
            <tr class="result-item">
                <td>${dogFood.dogfoodname}</td>
                <td>${dogFood.dogfoodbrand}</td>
                <td>${dogFood.dogage}</td>
                <td>${dogFood.dogfoodfeat}</td>
                <td>${dogFood.dogfoodnut}</td>
                <td>${dogFood.dogfoodwei}</td>
                <td>${dogFood.dogfoodprice}</td>
                <td><button type="button" onclick="addCart(${dogFood.dogfoodid}, ${dogFood.dogfoodprice}, '${dogFood.dogfoodname}')">담기</button></td>
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

        // 연령 체크박스에 대한 이벤트 핸들러
        $('input[name="selectedAges"]').change(function() {
            updateHiddenInput($('input[name="selectedAges"]:checked'), 'selectedAges');
        });

        // 특징 체크박스에 대한 이벤트 핸들러
        $('input[name="selectedFeatures"]').change(function() {
            updateHiddenInput($('input[name="selectedFeatures"]:checked'), 'selectedFeatures');
        });

        // 주성분 체크박스에 대한 이벤트 핸들러
        $('input[name="selectedNutrients"]').change(function() {
            updateHiddenInput($('input[name="selectedNutrients"]:checked'), 'selectedNutrients');
        });

        // 가격 체크박스에 대한 이벤트 핸들러
        $('input[name="selectedPrices"]').change(function() {
            updateHiddenInput($('input[name="selectedPrices"]:checked'), 'selectedPrices');
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
                    selectedFeatures: $('input[name="selectedFeatures"]:checked').map(function () { return this.value; }).get(),
                    selectedNutrients: $('input[name="selectedNutrients"]:checked').map(function () { return this.value; }).get(),
                    selectedPrices: $('input[name="selectedPrices"]:checked').map(function () { return this.value; }).get()
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

<script>

    function addCart(dogfoodid, dogfoodprice, dogfoodname) {
        var userid = "${sessionScope.user.userid}";

        // 만약 사용자가 로그인한 경우에만 처리
        if (userid) {
            // dogFood 객체의 속성 정의

            $.ajax({
                url: "/cart/addToCart",
                type: "POST",
                data: {
                    dogfoodid: dogfoodid,
                    dogfoodprice: dogfoodprice,
                    dogfoodname: dogfoodname,
                    userid: userid
                },
                success: function (data) {
                    if (data === "success") {
                        alert("장바구니에 추가되었습니다.");
                    } else {
                        alert("장바구니에 추가 중 오류가 발생했습니다.");
                    }
                },
                error: function () {
                    alert("서버 오류가 발생했습니다.");
                }
            });
        } else {
            // 로그인하지 않은 경우에 대한 처리
            alert("로그인 후에 이용 가능합니다.");
            window.location.href = "/user/login"; // 이 부분을 수정
        }
    }
</script>


</html>
