<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<html>
<head>
    <title>배송지 관리</title>
    <link rel="stylesheet" type="text/css" href="/css/delivery.css">
</head>
<body>
<div class="h2-container">
    <h2>배송지 목록</h2>
</div>

<div class="addr-container">
    <table>
        <tr>
            <td colspan="2" style="text-align: center;">
                <!-- 신규 배송지 버튼 -->
                <button type="button" id="newDeliveryButton" onclick="showNewDeliveryForm()">
                    배송지 추가</button>
            </td>
        </tr>
    </table>
    <!-- 신규 배송지 입력 양식 -->
    <table style="text-align:center">
        <tr id="newDeliveryRow" style="display: none;">
            <td><input type="text" name="deliveryname" id="deliveryname" placeholder="배송지이름을 입력해주세요"></td>
        </tr>
        <tr id="customerNameRow" style="display: none;">
            <td><input type="text" name="customername" id="customername" placeholder="수령인이름을 입력해주세요"></td>
        </tr>
        <tr id="customerPhoneRow" style="display: none;">
            <td><input type="text" name="customerphone" id="customerphone" placeholder="전화번호를 입력해주세요"></td>
        </tr>
        <tr id="deliveryPostcodeRow" style="display: none;">
            <td><input type="text" name="deliverypostcode" id="deliverypostcode" placeholder="우편번호" readonly>
                <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
            </td>
        </tr>
        <tr id="deliveryAddressRow" style="display: none;">
            <td><input type="text" name="deliveryaddress" id="deliveryaddress" placeholder="주소를 입력해주세요"></td>
        </tr>
        <tr id="deliveryDetailAddrRow" style="display: none;">
            <td>
                <input type="text" id="deliverydetailaddr" name="deliverydetailaddr" placeholder="상세주소">
            </td>
            <input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
        </tr>
        <tr id="saveButtonRow" style="display:none; text-align:center">
            <td colspan="2">
                <button type="button" id="deliverySave" onclick="deliverySave()">저장</button>
                <button type="button" onclick="hideDelivery()">취소</button>
            </td>
        </tr>

    </table>

    <table class="delivery-info">
        <!-- 각 배송지에 대한 루프 -->
        <c:forEach var="delivery" items="${deliveryList}">
            <tr>
                <td>
                    <label for="${delivery.deliveryname}" class="delivery-name">${delivery.deliveryname}</label>
                    <input type="hidden" id="deliveryid" name="deliveryid" value="${delivery.deliveryid}">
                    <!-- 각 배송지의 삭제 버튼에 클릭 이벤트 핸들러 추가 -->
                    <button type="button" id="deliveryRemove" onclick="deliveryRemove(${delivery.deliveryid})" style="float:right">삭제</button>
                    <button type="button" id="deliveryModify" onclick="deliveryModify(this)" style="float:right">수정</button>
                    <br>
                    <span class="customer-name">${delivery.customername}</span><br>
                    <span class="customer-phone">${delivery.customerphone}</span><br>
                    <span class="delivery-address">${delivery.deliveryaddress}</span>
                    <span class="delivery-detail-addr">${delivery.deliverydetailaddr}</span>
                    <span class="delivery-postcode">${delivery.deliverypostcode}</span>
                </td>
            </tr>
        </c:forEach>

    </table>

</div>
</body>

<script>
    function showNewDeliveryForm() {
        document.getElementById('newDeliveryRow').style.display = 'table-row';
        document.getElementById('customerNameRow').style.display = 'table-row';
        document.getElementById('customerPhoneRow').style.display = 'table-row';
        document.getElementById('deliveryPostcodeRow').style.display = 'table-row';
        document.getElementById('deliveryAddressRow').style.display = 'table-row';
        document.getElementById('deliveryDetailAddrRow').style.display = 'table-row';
        document.getElementById('saveButtonRow').style.display = 'table-row';
    }
    function hideDelivery() {
        document.getElementById('newDeliveryRow').style.display = 'none';
        document.getElementById('customerNameRow').style.display = 'none';
        document.getElementById('customerPhoneRow').style.display = 'none';
        document.getElementById('deliveryPostcodeRow').style.display = 'none';
        document.getElementById('deliveryAddressRow').style.display = 'none';
        document.getElementById('deliveryDetailAddrRow').style.display = 'none';
        document.getElementById('saveButtonRow').style.display = 'none';
    }

    function deliveryAdd() {
        // 배송지 추가 폼을 표시합니다.
        showNewDeliveryForm();
    }


</script>

<!--배송지 정보-->
<script>
    function setDeliveryInfo(deliveryName, customerName, customerPhone, deliveryPostcode, deliveryAddress, deliveryId,deliveryDetailaddr) {
        document.getElementById('deliveryname').value = deliveryName;
        document.getElementById('customername').value = customerName;
        document.getElementById('customerphone').value = customerPhone;
        document.getElementById('deliverypostcode').value = deliveryPostcode;
        document.getElementById('deliveryaddress').value = deliveryAddress;
        document.getElementById('deliveryid').value = deliveryId;
        document.getElementById('deliverydetailaddr').value = deliveryDetailaddr;
    }
    <!--신규배송지-->
    function newDelivery(){
        document.getElementById('deliveryname').value = "";
        document.getElementById('customername').value = "";
        document.getElementById('customerphone').value = "";
        document.getElementById('deliverypostcode').value = "";
        document.getElementById('deliveryaddress').value = "";
        document.getElementById('deliveryid').value = "";
        document.getElementById('deliverydetailaddr').value = "";
    }

</script>

<script>
    // 배송지 추가 로직
    function deliverySave() {
        // 배송지 정보를 서버로 전송하여 저장합니다.
        var userid = '${sessionScope.user.userid}';
        $.ajax({
            url: '/user/deliverySave',
            type: 'POST',
            data: {
                userid: userid,
                deliveryname: document.getElementById('deliveryname').value,
                customername: document.getElementById('customername').value,
                deliveryaddress: document.getElementById('deliveryaddress').value,
                deliverypostcode: document.getElementById('deliverypostcode').value,
                customerphone: document.getElementById('customerphone').value,
                deliverydetailaddr: document.getElementById('deliverydetailaddr').value,
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
                console.error('배송지 저장 실패', error.responseText);
            }
        });
    }

    function deliveryModify(button) {
        // 수정 폼을 표시합니다.
        showNewDeliveryForm();

        // 수정할 배송지의 정보를 가져옵니다.
        var deliveryRow = button.closest("tr");
        var deliveryName = deliveryRow.querySelector(".delivery-name").textContent.trim();
        var customerName = deliveryRow.querySelector(".customer-name").textContent.trim();
        var customerPhone = deliveryRow.querySelector(".customer-phone").textContent.trim();
        var deliveryAddress = deliveryRow.querySelector(".delivery-address").textContent.trim();
        var deliveryDetailAddr = deliveryRow.querySelector(".delivery-detail-addr").textContent.trim();
        var deliveryPostcode = deliveryRow.querySelector(".delivery-postcode").textContent.trim();

        // 가져온 정보를 인풋 상자에 설정합니다.
        document.getElementById('deliveryname').value = deliveryName;
        document.getElementById('customername').value = customerName;
        document.getElementById('customerphone').value = customerPhone;
        document.getElementById('deliverypostcode').value = deliveryPostcode;
        document.getElementById('deliveryaddress').value = deliveryAddress;
        document.getElementById('deliverydetailaddr').value = deliveryDetailAddr;
    }

    function deliveryUpdate() {
        // 수정된 배송지 정보를 서버로 전송하여 저장합니다.
        var userid = '${sessionScope.user.userid}';
        var deliveryId = document.getElementById('deliveryid').value;
        $.ajax({
            url: '/user/deliveryModify',
            type: 'POST',
            data: {
                userid: userid,
                deliveryid: deliveryId,
                deliveryname: document.getElementById('deliveryname').value,
                customername: document.getElementById('customername').value,
                deliveryaddress: document.getElementById('deliveryaddress').value,
                deliverypostcode: document.getElementById('deliverypostcode').value,
                customerphone: document.getElementById('customerphone').value,
                deliverydetailaddr: document.getElementById('deliverydetailaddr').value,
                // ... (나머지 필요한 데이터 추가)
            },
            success: function(data) {
                if(data === 'success') {
                    alert("배송지가 수정되었습니다.")
                    location.reload();
                    window.opener.location.reload();
                }
            },
            error: function(error) {
                console.error('배송지 수정 실패', error.responseText);
            }
        });
    }

    // 배송지 삭제 함수
    function deliveryRemove() {

        $.ajax({
            url: '/user/deliveryRemove',
            type: 'POST',
            data: {
                // 여기에 필요한 데이터를 추가
                deliveryid: document.getElementById('deliveryid').value,
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
                document.getElementById("deliverydetailaddr").focus();
            }
        }).open();
    }

</script>
<script>
    $(document).ready(function(){
        $("#deliveryoption").change(function(){
            if ($(this).val() === "custom") {
                $("#custom-input").show();
            } else {
                $("#custom-input").hide();
            }
        });
    });
</script>

</html>