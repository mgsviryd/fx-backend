package com.sviryd.fx.backend.controller.error.advice;

import com.sviryd.fx.backend.controller.error.ErrorResponse;
import com.sviryd.fx.backend.controller.error.exception.SomeException;
import com.sviryd.fx.backend.controller.rest.HelloWorldRestController;
import com.sviryd.fx.backend.service.MessageI18nService;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice(basePackageClasses = {HelloWorldRestController.class})
public class HelloWorldRestControllerAdvice {

    private final MessageI18nService messageI18nService;

    public HelloWorldRestControllerAdvice(MessageI18nService messageI18nService) {
        this.messageI18nService = messageI18nService;
    }

    @ExceptionHandler(SomeException.class)
    public ResponseEntity<ErrorResponse> handleSomeException(SomeException ex) {
        String message = messageI18nService.getMessage(ex.getClass().getName(), new Object[]{}, LocaleContextHolder.getLocale());
        ErrorResponse response = ErrorResponse.builder()
                .message(message)
                .build();
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }
}