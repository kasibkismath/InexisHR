package com.inexisconsulting.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.User;
import com.inexisconsulting.service.UserService;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/")
	public String showLogin(){
		return "login";
	}
	
	@RequestMapping("/admin-dashboard")
	public String onLoginSuccessAdmin(Model model ,Principal principal) {
		
		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		
		return "admin-dashboard";
	}
	
	@RequestMapping("/user/settings")
	public String showUserSettings(Model model, Principal principal) {
		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		
		return "userSettings";
	}
	
	@RequestMapping(value="/user/settings/getUser",method=RequestMethod.POST, 
			consumes = {"application/json;charset=UTF-8"}, produces={"application/json;charset=UTF-8"})
	@ResponseBody
	public User getUser(@RequestBody User user)  {
		User fetchedUser = userService.getUser(user);
		return fetchedUser;
	}
	
	@RequestMapping(value="/user/settings/updateUser", method=RequestMethod.POST, produces="application/json" )
	@ResponseBody
	public void updateUser(@RequestBody User user)  {
		userService.updateUserSettings(user);
	}
	
	
}
