<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            padding: 8px 16px; /* 체크박스 스타일을 위한 여백 추가 */
            border: 1px solid #ccc;
            border-radius: 5px;
            cursor: pointer;
            user-select: none;
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
            position: fixed;
            bottom: 0;
            width: 100%;
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
        <% String[] brands = {"가나", "다라", "마바", "사아"}; %>
        <% for (int i = 0; i < brands.length; i++) { %>
        <input type="checkbox" id="brandCheckbox<%= i %>">
        <label for="brandCheckbox<%= i %>" class="checkbox-label"><%= brands[i] %></label>
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
    <!-- 예시로 두 개의 결과 아이템을 나타내는 코드 -->
    <div class="result-item">
        <p>검색 결과 </p>
        <p>검색 결과에 대한 설명이나 내용을 여기에 추가합니다.</p>
    </div>

</div>


<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>


</body>
</html>
