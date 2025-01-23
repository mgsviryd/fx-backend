package com.sviryd.fx.backend.controller.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello-world")
public class HelloWorldRestController {
    @GetMapping
    public String helloWorld() {
        return "{\"message: \"hello world\"}";
    }
}
