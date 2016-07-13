package com.spring.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.DAO.UserServices;
import com.spring.model.UserDetail;

@Controller
public class AdminController {

	@Autowired
	private UserServices services;

	@RequestMapping(value = "/CreateNewUser", method = RequestMethod.GET)
	public String getAddUserForm(ModelMap model) throws Exception {
		Map<Integer, String> roles = new HashMap<Integer, String>();
		Map<Integer, String> states = new HashMap<Integer, String>();
		roles.putAll(services.getRoles());
		states.putAll(services.getStates());
		model.addAttribute("roles", roles);
		model.addAttribute("states", states);

		return "View/CreateNewUser";
	}

	@RequestMapping(value = "/AddUser", method = RequestMethod.POST)
	public ModelAndView ModelAndView(
			@ModelAttribute("UserDetail") UserDetail userDetail)
			throws Exception {
		if (services.createUser(userDetail)) {
			ModelAndView modelAndview = new ModelAndView("View/CreateNewUser");
			modelAndview.addObject("msg", "Sucessfully Added");
			return modelAndview;
		} else {
			ModelAndView modelAndview = new ModelAndView("View/CreateNewUser");
			modelAndview.addObject("msg", "fail to create Try again");
			return modelAndview;
		}
	}

	@RequestMapping(value = "/ajaxforDistrictList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Integer, String> getAllDistrict(
			@RequestParam("stateID") int stateID) {

		return (services.getDistrictList(stateID));
	}
	
	@RequestMapping(value = "/ajaxforDropDownListForDistrict", method = RequestMethod.POST)
	@ResponseBody
	public Map<Integer, String> getDistrictsForEdit(
			@RequestParam("stateName") String stateName) {
		int stateID=services.getStateID(stateName);
		return(services.getDistrictList(stateID));

		
	}
	
	//pagianation code for userDetail UI

	@RequestMapping(value = "/UserDetail", method = RequestMethod.GET)
	public String getViewPageUserForm(ModelMap model, HttpServletRequest request)
			throws Exception {
		PagedListHolder pagedListHolder = new PagedListHolder(
				services.getAllUsers());
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setPageSize(5);
		model.put("pagedListHolder", pagedListHolder);
		// model.addAttribute("role", request.getParameter("id"));
		return "View/UserDetail";
	}

	@RequestMapping(value = "/ajaxForDeleteUser", method = RequestMethod.POST)
	@ResponseBody
	public boolean detete(@RequestParam("UserID") int ID) {

		return (services.deleteUser(ID));
	}

	@RequestMapping(value = "/ajaxForStateList", method = RequestMethod.GET)
	@ResponseBody
	public Map<Integer, String> getAllStates() {

		return (services.getStates());
	}

	@RequestMapping(value = "/ajaxForUserRole", method = RequestMethod.GET)
	@ResponseBody
	public Map<Integer, String> getUserRole() {

		return (services.getRoles());
	}
}
