package com.project_mung.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {
    private String userid;  //유저아이디
    private String userpass;    //비밀번호
    private String username;    //이름
    private String userphone;   //전화번호
    private String userpostcode;    //우편번호
    private String useraddress;     //주소
    private String userdetailaddress;   //상세주소
    private String useremail; //이메일
}
