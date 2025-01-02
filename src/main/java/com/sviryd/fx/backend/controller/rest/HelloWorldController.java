package com.sviryd.fx.backend.controller.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {
    @GetMapping
    public String helloWorld() {
        return "{\"message: \"hello world\"}";
    }
}
