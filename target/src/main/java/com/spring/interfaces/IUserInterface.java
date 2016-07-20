package com.spring.interfaces;

import java.util.ArrayList;
import java.util.Map;

import com.spring.model.Login;
import com.spring.model.UserDetail;

public interface IUserInterface {

	String authenticateUser(Login login);

	boolean createUser(UserDetail userDetail);

	boolean deleteUser(int id);

	boolean editUser(int id,String userID,String userName,String sex,String state,String role,String district );

	ArrayList<UserDetail> getAllUsers();

	Map<Integer, String> getStates();

	Map<Integer, String> getDistrictList(int stateId);

	Map<Integer, String> getRoles();
	
	int getStateID(String stateName);
	
	int getRoleID(String userID);
	

}
