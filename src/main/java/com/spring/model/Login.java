package com.spring.model;

import org.hibernate.validator.constraints.NotEmpty;


public class Login {
	private int ID;
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	@NotEmpty(message="Please provide your UserID")
	private String Id;
	@NotEmpty(message="please provide your password")
	private String Password;
	private UserRole userRole;
	
	public UserRole getUserRole() {
		return userRole;
	}
	public void setUserRole(UserRole userRole) {
		this.userRole = userRole;
	}
	public String getId() {
		return Id;
	}
	public String getPassword() {
		return Password;
	}
	
	public void setId(String id) {
		Id = id;
	}
	public void setPassword(String password) {
		Password = password;
	}

}
