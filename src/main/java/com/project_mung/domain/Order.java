package com.project_mung.domain;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private String  orderid;             // 주문아이디
    private String  userid;              // 유저아이디
    private String  paymentmethod;       // 결제방법
    private int     deliveryid;
    private String  orderdate;           // 주문날짜
    private int     cartid;
    //cart
    private int     dogfoodid;
    private String  dogfoodname;
    private int     totalprice;
    private int     countOrder;
}