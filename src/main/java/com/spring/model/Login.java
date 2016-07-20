package com.spring.model;




public class Login {
	private int iD;
	private String Id;
	private String Password;
	private UserRole userRole;
	public int getID() {
		return iD;
	}
	public void setID(int iD) {
		this.iD = iD;
	}
	
	
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
