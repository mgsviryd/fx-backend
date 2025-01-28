package com.sviryd.fx.backend.controller.rest;

import com.sviryd.fx.backend.controller.error.exception.SomeException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello-world")
public class HelloWorldRestController {
    @GetMapping
    public String helloWorld() throws SomeException {
        if (true) {
            throw new SomeException();
        }
        return "{\"message: \"hello world\"}";
    }
}
