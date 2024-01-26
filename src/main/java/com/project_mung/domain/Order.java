package com.project_mung.domain;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private int    orderid;          // 주문아이디
    private LocalDateTime orderdate;// 주문날짜
    private int    userid;         // 유저아이디
    private int    cartid;      // 장바구니아이디
    private String    username;       // 고객이름
    private String    useraddress;    // 사료 가격
    private String userpostcode;     // 사료명


}
