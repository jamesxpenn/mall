package com.chinasofti.pay.vo;


import lombok.Data;

@Data
public class PaymentVO {
    private String orderNo;
    private String orderName;
    private String payType;
    private Integer amount;
}
