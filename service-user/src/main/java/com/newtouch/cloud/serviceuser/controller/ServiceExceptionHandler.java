package com.newtouch.cloud.serviceuser.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ServiceExceptionHandler {

    @ExceptionHandler(value = {Exception.class})
    public String errorHandler() {
        return "";
    }
}
