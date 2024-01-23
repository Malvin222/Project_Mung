package com.project_mung.domain;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Cart {

    private int    cartid;          // 장바구니 아이디
    private int    itemcnt;         // 아이템 개수
    private int    totalcnt;        // 아이템 총 개수
    private int    totalprice;      // 총 가격

    private int    dogfoodid;       // 아이디
    private int    dogfoodprice;    // 사료 가격
    private String dogfoodname;     // 사료명

    private String userid;          // 유저아이디


}
