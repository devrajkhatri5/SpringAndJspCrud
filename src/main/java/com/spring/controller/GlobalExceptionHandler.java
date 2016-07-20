package com.spring.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.ResourceAccessException;


@ControllerAdvice
public class GlobalExceptionHandler {
	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
	@ExceptionHandler(value=ResourceAccessException.class)
	public String handleResourceNotFoundException(Exception e){
		logger.info("Resource Exception Occurred"+e);
		return "View/ResourceNotFound";
	}
	@ExceptionHandler(value=NullPointerException.class)
	public String handleNullPointerException(Exception e){
		logger.info("Null pointer Exception Occurred"+e);
		return "View/NullPointerException";
	}
	
	@ExceptionHandler(value=Exception.class)
	public String handleAnyException(Exception e){
		logger.info("Unknown error Occurred"+e);
		return "View/UnknownException";
	}
	

}
