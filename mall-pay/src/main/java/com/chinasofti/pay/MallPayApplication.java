package com.chinasofti.pay;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
//引入Spring Task
//@EnableScheduling
@EnableFeignClients
@EnableDiscoveryClient
public class MallPayApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallPayApplication.class, args);
    }
}
