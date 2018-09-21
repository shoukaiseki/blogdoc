package org.shoukaiseki.test.springbootcentosserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringbootCentosServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootCentosServerApplication.class, args);

        System.out.println("----------------- Successful startup");
    }
}
