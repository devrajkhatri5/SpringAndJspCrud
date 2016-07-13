package com.spring.model;

import java.util.Date;

public class UserDetail {
	private String userName;
	private String sex;
	private long mobileNumber;
	private Date dateOfBirth;
	private UserRole userRole;
	private District district;
	private State state;
	private Login login;
	public Login getLogin() {
		return login;
	}

	public void setLogin(Login login) {
		this.login = login;
	}

	public District getDistrict() {
		return district;
	}

	public State getState() {
		return state;
	}

	public void setDistrict(District district) {
		this.district = district;
	}

	public void setState(State state) {
		this.state = state;
	}

	public UserRole getUserRole() {
		return userRole;
	}

	public void setUserRole(UserRole userRole) {
		this.userRole = userRole;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}


	public long getMobileNumber() {
		return mobileNumber;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setMobileNumber(long mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}



}
