package com.spring.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.dao.UserServices;
import com.spring.model.UserDetail;

@Controller
@RequestMapping(value="/Admin")
public class AdminController {

	@Autowired
	private UserServices services;

	@RequestMapping(value = "/CreateNewUser", method = RequestMethod.GET)
	public String getAddUserForm()  {
          return "View/CreateNewUser";
	}

	@RequestMapping(value = "/AddUser", method = RequestMethod.POST)
	public ModelAndView addUser(
			@ModelAttribute("UserDetail") UserDetail userDetail){
		if (services.createUser(userDetail)) {
			ModelAndView modelAndview = new ModelAndView("View/CreateNewUser");
			modelAndview.addObject("msg", "User Sucessfully Added");
			return modelAndview;
		} else {
			ModelAndView modelAndview = new ModelAndView("View/CreateNewUser");
			modelAndview.addObject("msg", "User Already Exist try again");
			return modelAndview;
		}
	}

	@RequestMapping(value = "/ajaxforDistrictList", method = RequestMethod.POST, produces="application/json")
	@ResponseBody
	public  Map<Integer, String> getAllDistrict(
			@RequestParam("stateID") int stateID) {

         	return services.getDistrictList(stateID);
		
	}
	
	@RequestMapping(value = "/ajaxforDropDownListForDistrict", method = RequestMethod.POST)
	@ResponseBody
	public  Map<Integer, String> getDistrictsForEdit(
			@RequestParam("stateName") String stateName) {
		int stateID=services.getStateID(stateName);
		return services.getDistrictList(stateID);

		
	}
	

	@RequestMapping(value = "/UserDetail", method = RequestMethod.GET)
	public String getViewPageUserForm(ModelMap model, HttpServletRequest request){
		
		String userID=(String) request.getSession().getAttribute("userId");
		
		model.put("roleId",services.getRoleID(userID));
		model.put("userList", services.getAllUsers());
		return "View/UserDetail";
	
		
		
	}
	
	
	
	@RequestMapping(value = "/ajaxForDeleteUser", method = RequestMethod.POST)
	@ResponseBody
	public boolean detete(@RequestParam("UserID") int id) {

		return services.deleteUser(id);
	}

	@RequestMapping(value = "/ajaxForStateList", method = RequestMethod.GET)
	@ResponseBody
	public Map<Integer, String> getAllStates() {

		return services.getStates();
	}

	@RequestMapping(value = "/ajaxForUserRole", method = RequestMethod.GET	)
	@ResponseBody
	public Map<Integer, String> getUserRole() {

		return services.getRoles();
	}
	@RequestMapping(value = "/UpdateUser", method = RequestMethod.POST	)
	@ResponseBody
	public boolean updateUser(@RequestParam("ID") int id,@RequestParam("UserID") String userID,
			@RequestParam("UserName") String userName,
			@RequestParam("sex") String sex,
			@RequestParam("state") String state,
			@RequestParam("district") String district,
			@RequestParam("role") String role) {
		if(services.editUser(id,userID, userName, sex, state, role, district)){
			return true;
		}

		return false;
	}
}
