
 ## 🍖Project_Mung
<br>

 * 개발기간
   - 2024-01-15 ~ 2024-01-25
 * 설계 배경
   - 초보 반려견주를 위한 반려견 특징별 애견사료 검색 
 * 설계 목적 
   - 사료 문의가 많아 사료 기능별 검색을 위한 사이트 구축
   - 반려견주의 사료를 정하는데 도움을 주기위한 목적
 * 기능 요약
   - 반려견 사료 검색기능
   - 선택한사료의 장바구니 추가기능
   - 장바구니에 담긴 물건을 선택 결제 기능
  
  ### 🔧개발환경
  * Front-End :  HTML5, CSS3, JavaScript, JSP
  * Back-End : Java, SpringBoot, SpringSecurity
  * Database : MYSQL
  * ORM : MYBATIS
  * Server : ApacheTomcat, AWS EC2,RDS
  * Tool : IntelliJ, Git

  ### ⚙ 핵심 기능
  * 기능 글씨 클릭시 해당 코드로 이동됩니다.
  * 기능 이미지 클릭시 크게 출력됩니다.
  <table>
    <tr>
    <th>
     <a href="https://github.com/Malvin222/Project_Mung/blob/d88fe8e1ca3f7153cc4a923e2a58286450d2b8e0/src/main/java/com/project_mung/controller/DogController.java#L35"> 반려견 사료검색  </a>
    </th>
    <th>
     <a href="https://github.com/Malvin222/Project_Mung/blob/d88fe8e1ca3f7153cc4a923e2a58286450d2b8e0/src/main/java/com/project_mung/controller/CartController.java#L31"> 장바구니 추가 CRUD</a>
    </th>
    <th>
     <a href="https://github.com/Malvin222/Project_Mung/blob/d88fe8e1ca3f7153cc4a923e2a58286450d2b8e0/src/main/java/com/project_mung/controller/OrderController.java#L33"> 결제 </a>
    </th>
   </tr>
   <tr>
     <td>
      <img src="https://github.com/Malvin222/Project_Mung/assets/127707299/d7e1ec67-bd52-4b61-8727-9583dda7edaf" width="250" height="300">
     </td>
     <td>
      <img src="https://github.com/Malvin222/Project_Mung/assets/127707299/c0544bda-eca9-42ed-9368-4f85dfaf5486" width="200" height="300">
     </td>
     <td>
      <img src="https://github.com/Malvin222/Project_Mung/assets/127707299/695982e1-ca1a-481c-ac61-f5222e05badf" width="200" height="300">
     </td>
   </tr>
  </table>

   ### 🛠트러블 슈팅
   - DB 설계 및 쿼리 작성의 난이도<br>
    초기에는 Order 테이블에 CartId를 외래키로 받아오기로 설계했으나, 주문정보에 여러 개의 CartId를 받아와야 하는 문제가 발생하여 DB 설계를 변경하였습니다. 새로운 구조에서는 Cart 테이블에 OrderId를 외래키로 받아오도록 변경하여 각 CartId 데이터가 해당 주문에 매칭되게 하였습니다.<br>
    이로써, 사료를 검색하고 선택할 때, Cart 테이블에는 OrderId가 null로 생성되며, 사용자가 결제 시 선택한 사료들에만 현재 시간과 사용자 ID로 구성된 OrderId가 업데이트되도록 설계하였습니다. 이렇게 함으로써 데이터의 일관성을 유지하면서도 간결하고 효과적인 구조로 변경하였습니다. 



  ### 프로젝트 후기
  - 기존 기술 복습 <br>
    국비학원을 수료한 후 여러 기술들을 학습하고 활용하며, 이번 프로젝트에서는 새로운 기술보다는 기존에 사용한 기술들을 복습하고자 했습니다. 이를 위해 MYBATIS 등을 활용하여 MVC를 설계했습니다.<br>
    이전에 학습한 기술들을 다시 사용함으로써 그 기술들에 대한 익숙함을 높일 수 있었습니다. 초기에 기술을 처음 사용했을 때와는 달리 오류 해결이나 로직 구현에 있어서 보다 능숙하게 대처할 수 있었습니다. 이로써 프로젝트 진행이 원활하게 이루어지면서 기존 기술들을 더욱 성숙하게 활용할 수 있는 기회가 되었습니다.
    
    
     

