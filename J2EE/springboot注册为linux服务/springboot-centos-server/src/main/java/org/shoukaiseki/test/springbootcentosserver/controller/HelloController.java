package org.shoukaiseki.test.springbootcentosserver.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloController {

    Logger logger= LoggerFactory.getLogger(HelloController.class);

    @RequestMapping("/")
    @ResponseBody
    public String index(){
        logger.debug("-------hello1");
        System.out.println("----------hello2");
        return "hello";
    }

    public void test(){
        String a1="";
        System.out.println(a1);

        String a2="";
        System.out.println(a2);

    }



}
