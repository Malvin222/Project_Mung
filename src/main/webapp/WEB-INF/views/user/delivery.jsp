<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<html>
<style>
    td {
        text-align: center;
    }

    /* 라디오 버튼 스타일 */
    input[type="radio"] {
        width: 10px;
        height: 15px;
        margin: 0; /* 여백을 0으로 설정 */
    }

    /* 라벨 스타일 */
    label {
        font-size: 14px;
    }
    /* 버튼을 가운데 정렬하는 스타일 */
    .button-container {
        text-align: center;
        margin-top: 20px; /* 원하는 여백 값으로 조절하세요 */
    }

    /* 버튼 스타일 */
    #delivarySave, #delivaryRemove {
        padding: 10px 20px;
        font-size: 16px;
        background-color: #4CAF50; /* 원하는 배경색으로 조절하세요 */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 10px; /* 버튼 사이의 간격을 조절하세요 */
    }

    /* 버튼 호버 효과 스타일 */
    #delivarySave:hover, #delivaryRemove:hover {
        background-color: #45a049; /* 원하는 호버 배경색으로 조절하세요 */
    }
    /* 인풋 상자들을 가운데 정렬하는 스타일 */
    input[type="text"], select {
        width: 80%; /* 인풋 상자의 너비를 조절할 수 있습니다. */
        padding: 10px;
        margin: 5px 0;
        display: inline-block;
        border: 1px solid #ccc;
        box-sizing: border-box;
    }

    /* 우편번호 찾기 버튼 스타일 */
    input[type="button"] {
        width: auto; /* 기본 크기 유지 */
        padding: 10px;
        margin: 5px 0;
        display: inline-block;
        border: 1px solid #ccc;
        box-sizing: border-box;
        cursor: pointer;
    }
</style>
<head>
    <title>배송지 관리</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<!-- 메인 로고 -->

<div class="login-container" style="text-align:right; margin-right:50px;">
    <c:if test="${not empty sessionScope.user}">
        ${sessionScope.user.userid}
        <!-- 기타 사용자 정보를 필요에 따라 출력 -->
    </c:if>
</div>

<div class="h2-container">
    <h2>배송정보</h2>
</div>

<div class="addr-container">
    <table>
            <td>
                <!-- 각 배송지에 대한 루프 -->
                <c:forEach var="delivery" items="${deliveryList}">
                    <!-- 각 배송지에 대한 라디오 버튼 및 라벨 -->
                    <input type="radio" id="${delivery.deliveryname}" name="address" value="${delivery.deliveryname}"
                           style="width: 10px; height: 15px;"
                           onclick="setDeliveryInfo('${delivery.deliveryname}',
                                   '${delivery.customername}'
                                   , '${delivery.customerphone}'
                                   , '${delivery.deliverypostcode}'
                                   , '${delivery.deliveryaddress}'
                                   , '${delivery.deliveryid}')" >
                    <label for="${delivery.deliveryname}" style="margin-right:10px; ">${delivery.deliveryname}</label>
                </c:forEach>
                <input type="radio" id="newDelivary" name="address"
                       style="width: 10px; height: 15px;"
                       onclick="newDelivary()">
                <label for=newDelivary style="margin-right: 5px;">신규배송지</label>
            </td>
        </tr>
        <tr>
            <td><input type="text" name="deliveryname" id="deliveryname" placeholder="배송지이름을 입력해주세요"></td>
        </tr>
        <tr>
            <td><input type="text" name="customername" id="customername" placeholder="수령인이름을 입력해주세요"></td>
        </tr>
        <tr>
            <td><input type="text" name="cusomerphone" id="customerphone" placeholder="전화번호를 입력해주세요"></td>
        </tr>
        <tr>
            <td><input type="text" name="deliverypostcode" id="deliverypostcode" placeholder="우편번호를 입력해주세요">
                <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
            </td>
        </tr>
        <tr>
            <td><input type="text" name="deliveryaddress" id="deliveryaddress" placeholder="주소를 입력해주세요"></td>
        </tr>
        <tr>
            <td>  <input type="text" id="sample6_detailAddress"  placeholder="상세주소">
                <input type="text" id="sample6_extraAddress" placeholder="참고항목"></td>
        </tr>
        <input hidden name="deliveryid" id="deliveryid">
        <tr>
            <td>
                <select id="delivery-option" name="delivery-option">
                    <option value="door">부재 시 문 앞에 놓아주세요.</option>
                    <option value="call">배송 전 연락바랍니다.</option>
                    <option value="security">부재 시 경비실에 맡겨주세요.</option>
                    <option value="custom">직접 입력</option>
                </select>
            </td>
        </tr>
        <tr id="custom-input" style="display:none;">
            <td>
                <input type="text" id="custom-text" name="custom-text" placeholder="배송메모를 입력해주세요.">
            </td>
        </tr>
    </table>
</div>
<div class="button-container">
    <button type="button" id="delivarySave" onclick="deliverySave()">저장</button>
    <button type="button" id="delivaryRemove" onclick="deliveryRemove()">삭제</button>
</div>
<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>



</body>
<!--배송지 정보-->
<script>
    function setDeliveryInfo(deliveryName, customerName, customerPhone, deliveryPostcode, deliveryAddress, deliveryid) {
        document.getElementById('deliveryname').value = deliveryName;
        document.getElementById('customername').value = customerName;
        document.getElementById('customerphone').value = customerPhone;
        document.getElementById('deliverypostcode').value = deliveryPostcode;
        document.getElementById('deliveryaddress').value = deliveryAddress;
        document.getElementById('deliveryid').value = deliveryid;
    }
    <!--신규배송지-->
    function newDelivary(){
        document.getElementById('deliveryname').value = "";
        document.getElementById('customername').value = "";
        document.getElementById('customerphone').value = "";
        document.getElementById('deliverypostcode').value = "";
        document.getElementById('deliveryaddress').value = "";
        document.getElementById('deliveryid').value = "";
    }
</script>

<script>
    function deliverySave() {
        // 여기에 저장 로직을 추가하면 됩니다.
        // 새로운 배송지 정보를 가져와서 서버에 저장하도록 구현하세요.
        // 예시: Ajax를 사용하여 서버로 데이터 전송
        var userid = '${sessionScope.user.userid}'
         $.ajax({
             url: '/user/deliverySave',
             type: 'POST',
             data: {
                 // 여기에 필요한 데이터를 추가
                 userid: userid,
                 deliveryname: document.getElementById('deliveryname').value,
                 customername: document.getElementById('customername').value,
                 deliveryaddress: document.getElementById('deliveryaddress').value,
                 deliverypostcode: document.getElementById('deliverypostcode').value,
                 customerphone: document.getElementById('customerphone').value,
                 // ... (나머지 필요한 데이터 추가)
             },
             success: function(data) {
                 if(data === 'success') {
                     alert("배송지가 저장되었습니다.")
                     location.reload();
                     window.opener.location.reload();
                 }
             },
             error: function(error) {
                 // 저장 실패 시 처리
                 console.error('배송지 저장 실패', error.responseText);
             }
         });
    }

    // 배송지 삭제 함수
    function deliveryRemove() {
        // 여기에 삭제 로직을 추가하면 됩니다.
        // 선택한 배송지를 서버에서 삭제하도록 구현하세요.
        // 예시: Ajax를 사용하여 서버로 데이터 전송
        var deliveryid = document.getElementById('deliveryid').value;
         $.ajax({
             url: '/user/deliveryRemove',
             type: 'POST',
             data: {
                 // 여기에 필요한 데이터를 추가
                 deliveryid: deliveryid,
                 // ... (나머지 필요한 데이터 추가)
             },
             success: function(data) {
                 // 삭제 성공 시 처리
                 if(data ==='success'){
                     alert("배송지가 삭제되었습니다.")
                     location.reload();
                     window.opener.location.reload();
                 }
             },
             error: function(error) {
                 // 삭제 실패 시 처리
                 console.error('배송지 삭제 실패', error.responseText);
             }
         });
    }
</script>

<!--우편번호-->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;

                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('deliverypostcode').value = data.zonecode;
                document.getElementById("deliveryaddress").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }

</script>

</html>
