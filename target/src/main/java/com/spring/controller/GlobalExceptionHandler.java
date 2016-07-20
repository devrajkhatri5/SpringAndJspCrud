package com.spring.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


@ControllerAdvice
public class GlobalExceptionHandler {
	@ExceptionHandler(value=Exception.class)
	public String handleResourceNotFoundException(Exception e)
	{
		System.out.println("Null pointer Exception Occurred");
		return "View/ResourceNotFound";
	}
	

}
