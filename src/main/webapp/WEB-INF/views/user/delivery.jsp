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
            <td>
                <button type="button" id="deliverySave" onclick="deliverySave()">저장</button>
                <button type="button" id="deliveryModifyButton" style="display:none;" onclick="deliveryUpdate()">수정</button>
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
                    ( <span class="delivery-postcode">${delivery.deliverypostcode}</span> )

                </td>
            </tr>
        </c:forEach>

    </table>

</div>
</body>

<script>
    // 배송지 입력 폼 표시 및 숨기기 함수
    function toggleDeliveryForm(displayValue) {
        const elements = ['newDeliveryRow', 'customerNameRow', 'customerPhoneRow', 'deliveryPostcodeRow', 'deliveryAddressRow', 'deliveryDetailAddrRow', 'saveButtonRow'];
        elements.forEach(function(elementId) {
            document.getElementById(elementId).style.display = displayValue;
            if (displayValue === 'none') {
                document.getElementById(elementId).querySelector('input').value = ""; // 입력 필드 초기화
            }
        });
    }

    function showNewDeliveryForm() {
        // 배송지 입력 폼을 표시합니다.
        toggleDeliveryForm('table-row');
    }

    function hideDelivery() {
        // 배송지 입력 폼을 숨깁니다.
        toggleDeliveryForm('none');
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

        document.getElementById('deliveryid').value = deliveryRow.querySelector("#deliveryid").value;


        document.getElementById('deliveryModifyButton').style.display = 'inline';
        document.getElementById('deliverySave').style.display = 'none';


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

    // 페이지 로드 시 각 삭제 버튼에 대한 클릭 이벤트 핸들러 등록
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.delivery-remove').forEach(function(button) {
            button.addEventListener('click', function() {
                // 클릭한 삭제 버튼의 부모 요소에서 deliveryid 가져오기
                var deliveryId = button.parentElement.querySelector('.deliveryid').value;
                // 삭제 작업 수행
                deliveryRemove(deliveryId);
            });
        });
    });

    // 배송지 삭제 함수
    function deliveryRemove(deliveryId) {
        $.ajax({
            url: '/user/deliveryRemove',
            type: 'POST',
            data: {
                deliveryid: deliveryId
            },
            success: function(data) {
                if (data === 'success') {
                    alert("배송지가 삭제되었습니다.");
                    location.reload();
                    window.opener.location.reload();
                }
            },
            error: function(error) {
                console.error('배송지 삭제 실패', error.responseText);
            }
        });
    }
</script>

<!--우편번호-->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/deliveryPost.js"></script>

</html>