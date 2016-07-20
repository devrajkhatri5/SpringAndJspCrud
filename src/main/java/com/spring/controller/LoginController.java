package com.spring.controller;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dao.UserServices;
import com.spring.model.Login;

@Controller
@RequestMapping(value="/Home")
public class LoginController {

	@Autowired
	private UserServices services;

	@RequestMapping(value = "/Index", method = RequestMethod.GET)
	public String getLoginForm(){
		
		
		return "View/Login";
			
	}

	@RequestMapping(value = "/Login", method = RequestMethod.POST)
	public String login( @Valid @ModelAttribute("Login") Login login,
			HttpSession session,final RedirectAttributes redirectAttributes) throws Exception {
		int roleId = Integer.parseInt(services.authenticateUser(login));
	 if(roleId==0){
		redirectAttributes.addFlashAttribute("message","userid password  mismatched");
		 return "redirect:Index";
	 }else if (roleId != login.getUserRole().getRoleId()) {
			
			redirectAttributes.addFlashAttribute("message","Please Select  appropriate Role.");
			 return "redirect:Index";	
		}else if (roleId == login.getUserRole().getRoleId()) {
			session.setAttribute("userId", login.getId());
			redirectAttributes.addFlashAttribute("roleId",roleId);
			return "redirect:Welcome";
		}else{
			throw new NullPointerException();
		}
     
		
			
	}
	@RequestMapping(value = "/Welcome", method = RequestMethod.GET)
	public String getWelcome() {
		return "View/Welcome";
	}

}
