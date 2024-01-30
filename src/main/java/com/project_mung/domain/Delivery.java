package com.project_mung.domain;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Delivery {
        private int     deliveryid;
        private String  userid;
        private String  deliveryname;
        private String  customername;
        private String  deliveryaddress;
        private int     deliverypostcode;
        private String  customerphone;
        private String  deliveryoption;
        private String  deliverydetailaddr;
}
