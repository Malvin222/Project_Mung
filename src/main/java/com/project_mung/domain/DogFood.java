package com.project_mung.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DogFood {


    private int    dogfoodid;       // 아이디
    private String dogfoodname;     // 사료명
    private int    dogfoodprice;    // 사료 가격
    private String dogage;          // 강아지 나이
    private String dogfoodfeat;     // 사료 특징
    private String dogfoodbrand;    // 사료 브랜드
    private String dogfoodnut;      // 사료 주성분
    private String dogfoodwei;      // 사료 용량
    private String dogfooddetail;   // 사료 상세정보
    private String link;            // 제품 링크

}
