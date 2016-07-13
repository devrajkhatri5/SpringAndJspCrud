package com.spring.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.DAO.UserServices;
import com.spring.model.*;

@Controller
public class LoginController {

	@Autowired
	private UserServices services;

	@RequestMapping(value = "/Index", method = RequestMethod.GET)
	public String getLoginForm(ModelMap model) throws Exception {
		Map<Integer, String> roles = new HashMap<Integer, String>();
		roles.putAll(services.getRoles());
		model.addAttribute("roles", roles);
		return "View/Login";
	}

	@RequestMapping(value = "/Login", method = RequestMethod.POST)
	public ModelAndView Login(HttpServletRequest request, @Valid @ModelAttribute("Login") Login login,
			BindingResult result) throws Exception {
		
		
		if (result.hasErrors()) {
			ModelAndView modelAndview = new ModelAndView("View/Login");
			modelAndview.addObject("msg", "All field required");
			return modelAndview;
		}

		int roleId = Integer.parseInt(((services.authenticateUser(login))));

		if (roleId != login.getUserRole().getRoleId()) {
			ModelAndView modelAndview = new ModelAndView("View/Login");
			modelAndview
					.addObject("msg", "Please select your appropriate role");
			return modelAndview;
		}

		else if (roleId == login.getUserRole().getRoleId()) {
			ModelAndView modelAndview = new ModelAndView("View/Welcome");
			modelAndview.addObject("role", roleId);
			
			return modelAndview;
		}

		return new ModelAndView("View/Login");
	}

}
